//
//  HomeViewController.swift
//  Skincare-app
//
//  Created by Apple on 12.08.24.
//

import UIKit

enum HomeSection{
    case header
    case detectProblem
    case skinProblems
    case search
}

struct HomeModel: Hashable {
    let id: String = UUID().uuidString
    let skinProblems: [SkinProblemItemModel]
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias HomeDataSource = UITableViewDiffableDataSource<HomeSection, HomeModel>

class HomeViewController: UIViewController, SearchTableViewCellDelegate, SkinProblemsTableViewCellDelegate {
    
    private lazy var homeDataSource: HomeDataSource = makeHomeDataSource()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tv.register(DetectProblemTableViewCell.self, forCellReuseIdentifier: DetectProblemTableViewCell.identifier)
        tv.register(SkinProblemsTableViewCell.self, forCellReuseIdentifier: SkinProblemsTableViewCell.identifier)
        tv.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.additionalSafeAreaInsets.top = -28
        tableView.dataSource = homeDataSource
        view.backgroundColor = UIColor(named: "customWhite")
        setupUI()
        applySnapshot()
    }
    private func setupUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func didTapLightBlueView() {
        guard let tabBarController = self.tabBarController as? CustomTabBarController else { return }
        let targetIndex = 2
        
        guard tabBarController.selectedIndex != targetIndex else { return }
        
        UIView.transition(with: tabBarController.view,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            tabBarController.selectedIndex = targetIndex
        },
                          completion: nil)
    }
    
    func didTapMoreButton() {
        let vc = MoreSkinProblemsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    
    private func makeHomeDataSource() -> HomeDataSource {
        return HomeDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: DetectProblemTableViewCell.identifier) as! DetectProblemTableViewCell
                return cell
            } 
            else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SkinProblemsTableViewCell.identifier) as! SkinProblemsTableViewCell
                cell.configure(itemIdentifier.skinProblems)
                cell.delegate = self
                return cell
            }
            else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
                cell.delegate = self
                return cell
            }
            return UITableViewCell()
        }
    }
    
    private func applySnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeModel>()
        snapshot.appendSections([
            .header,
            .detectProblem,
            .skinProblems,
            .search,
        ])
        snapshot.appendItems([.init(skinProblems: [])], toSection: .header)
        snapshot.appendItems([.init(skinProblems: [])], toSection: .detectProblem)
        snapshot.appendItems([.init(skinProblems: [
            .init(image: "rosacea", title: "Rosacea"),
            .init(image: "acne", title: "Acne"),
            .init(image: "melazma", title: "Melazma"),
            .init(image: "ekzema", title: "Ekzema"),
            .init(image: "seboreik", title: "Seboreik")])],
            toSection: .skinProblems)
        snapshot.appendItems([.init(skinProblems: [])], toSection: .search)
        homeDataSource.apply(snapshot, animatingDifferences: true)
    }
}
