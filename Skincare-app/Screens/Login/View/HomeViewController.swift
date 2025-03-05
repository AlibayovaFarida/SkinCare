//
//  HomeViewController.swift
//  Skincare-app
//
//  Created by Apple on 12.08.24.
//

import UIKit

enum HomeSection {
    case header
    case detectProblem
    case skinProblems
    case search
    case products
}

struct HomeModel: Hashable {
    let id: String = UUID().uuidString
    let skinProblems: [SkinProblemsModel.SkinProblem]
    let products: [ProductsModel.Product]
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias HomeDataSource = UITableViewDiffableDataSource<HomeSection, HomeModel>

class HomeViewController: UIViewController, SearchTableViewCellDelegate,
    SkinProblemsTableViewCellDelegate, ProductsTableViewCellDelegate
{

    private let skinProblemsviewModel: SkinProblemsViewModel =
        SkinProblemsViewModel()
    private let productsViewModel: ProductsViewModel = ProductsViewModel()
    private var skinProblems: [SkinProblemsModel.SkinProblem] = []
    private var products: [ProductsModel.Product] = []
    private lazy var homeDataSource: HomeDataSource = makeHomeDataSource()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(
            HeaderTableViewCell.self,
            forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tv.register(
            DetectProblemTableViewCell.self,
            forCellReuseIdentifier: DetectProblemTableViewCell.identifier)
        tv.register(
            SkinProblemsTableViewCell.self,
            forCellReuseIdentifier: SkinProblemsTableViewCell.identifier)
        tv.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.identifier)
        tv.register(
            ProductsTableViewCell.self,
            forCellReuseIdentifier: ProductsTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = false
        return tv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.additionalSafeAreaInsets.top = -28
        tableView.dataSource = homeDataSource
        view.backgroundColor = UIColor(named: "customWhite")
        setupUI()
        skinProblemsviewModel.delegate = self
        productsViewModel.delegate = self
        skinProblemsviewModel.skinProblems { error in
            self.showAlert(message: error.localizedDescription)
        }
        productsViewModel.products { error in
            self.showAlert(message: error.localizedDescription)
        }
        applySnapshot()
    }
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func didTapLightBlueView() {
        guard
            let tabBarController = self.tabBarController
                as? CustomTabBarController
        else { return }
        let targetIndex = 2

        guard tabBarController.selectedIndex != targetIndex else { return }

        UIView.transition(
            with: tabBarController.view,
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
    func didTapProductsMoreButton() {
        guard
            let tabBarController = self.tabBarController
                as? CustomTabBarController
        else { return }
        let targetIndex = 1  // Göstərmək istədiyiniz tab-ın indeksi

        guard tabBarController.selectedIndex != targetIndex else { return }

        UIView.transition(
            with: tabBarController.view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                tabBarController.selectedIndex = targetIndex
            },
            completion: nil)
    }
    func skinProblemsTableViewCell(
        _ cell: SkinProblemsTableViewCell,
        didSelectItem item: SkinProblemsModel.SkinProblem
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let viewController = self.findViewController() {
                let vc = SkinProblemDetailsViewController(
                    problemName: item.title, problemId: 0)
                viewController.navigationController?.pushViewController(
                    vc, animated: true)
            }
        }
    }
    private func makeHomeDataSource() -> HomeDataSource {
        return HomeDataSource(tableView: tableView) {
            tableView, indexPath, itemIdentifier in
            if indexPath.section == 0 {
                let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: HeaderTableViewCell.identifier)
                    as! HeaderTableViewCell
                return cell
            } else if indexPath.section == 1 {
                let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: DetectProblemTableViewCell.identifier)
                    as! DetectProblemTableViewCell
                return cell
            } else if indexPath.section == 2 {
                let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: SkinProblemsTableViewCell.identifier)
                    as! SkinProblemsTableViewCell
                cell.configure(itemIdentifier.skinProblems)
                cell.delegate = self
                return cell
            } else if indexPath.section == 3 {
                let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: SearchTableViewCell.identifier)
                    as! SearchTableViewCell
                cell.delegate = self
                return cell
            } else if indexPath.section == 4 {
                let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: ProductsTableViewCell.identifier)
                    as! ProductsTableViewCell
                cell.configure(itemIdentifier.products)
                cell.delegate = self
                return cell
            }
            return UITableViewCell()
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeModel>()
        snapshot.appendSections([
            .header,
            .detectProblem,
            .skinProblems,
            .search,
            .products,
        ])
        snapshot.appendItems(
            [.init(skinProblems: [], products: [])], toSection: .header)
        snapshot.appendItems(
            [.init(skinProblems: [], products: [])], toSection: .detectProblem)
        snapshot.appendItems(
            [.init(skinProblems: skinProblems, products: [])],
            toSection: .skinProblems)
        snapshot.appendItems(
            [.init(skinProblems: [], products: [])], toSection: .search)
        snapshot.appendItems(
            [.init(skinProblems: [], products: products)], toSection: .products)
        homeDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: SkinProblemsDelegate {
    func didFetchSkinProblems(data: [SkinProblemsModel.SkinProblem]) {
        self.skinProblems = data.map {
            SkinProblemsModel.SkinProblem(
                id: $0.id, title: $0.title, imageIds: $0.imageIds)
        }
        applySnapshot()
    }
}

extension HomeViewController: ProductsDelegate {
    func didFetchProducts(data: [ProductsModel.Product]) {
        self.products = data.map {
            ProductsModel.Product(
                id: $0.id, title: $0.title, imageIds: $0.imageIds)
        }
        applySnapshot()
    }
}
