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
    case search
    case popularProblems
}

struct HomeModel: Hashable {
    let id: String = UUID().uuidString
    let popularProblems: [PopularProblemsItemModel]
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias HomeDataSource = UITableViewDiffableDataSource<HomeSection, HomeModel>

class HomeViewController: UIViewController, SearchTableViewCellDelegate {
    
    private lazy var homeDataSource: HomeDataSource = makeHomeDataSource()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tv.register(DetectProblemTableViewCell.self, forCellReuseIdentifier: DetectProblemTableViewCell.identifier)
        tv.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tv.register(PopularProblemsTableViewCell.self, forCellReuseIdentifier: PopularProblemsTableViewCell.identifier)
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
    
    private func makeHomeDataSource() -> HomeDataSource {
        return HomeDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: DetectProblemTableViewCell.identifier) as! DetectProblemTableViewCell
                return cell
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
                cell.delegate = self
                return cell
            } else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PopularProblemsTableViewCell.identifier) as! PopularProblemsTableViewCell
                cell.configure(itemIdentifier.popularProblems)
                return cell
            }
            return UITableViewCell()
        }
    }
    
    private func applySnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeModel>()
        snapshot.appendSections([.header, .detectProblem, .search, .popularProblems])
        snapshot.appendItems([.init(popularProblems: [])], toSection: .header)
        snapshot.appendItems([.init(popularProblems: [])], toSection: .detectProblem)
        snapshot.appendItems([.init(popularProblems: [])], toSection: .search)
        snapshot.appendItems([.init(popularProblems: [
            .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
            .init(image: "rosacea", title: "Rosacea", solutions: ["Günəşdən Qorunma", "lazer Terapiyası", "Soyuq Kompreslər"]),
            .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
            .init(image: "rosacea", title: "Rosacea", solutions: ["Günəşdən Qorunma", "lazer Terapiyası", "Soyuq Kompreslər"])])], toSection: .popularProblems)
        homeDataSource.apply(snapshot, animatingDifferences: true)
    }
}
