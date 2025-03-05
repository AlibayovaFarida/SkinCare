//
//  MoreProductsViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit

class MoreProductsViewController: UIViewController
{
    private let viewModel: ProductsViewModel = ProductsViewModel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(MoreProductCollectionViewCell.self, forCellWithReuseIdentifier: MoreProductCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.setImage(UIImage(named: "Search"), for: .search, state: .normal)
            searchBar.backgroundImage = UIImage()
            searchBar.backgroundColor = .white
            
            if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
                searchTextField.backgroundColor = .white
                searchTextField.layer.borderWidth = 1
                searchTextField.layer.borderColor = UIColor.customGray.cgColor
                searchTextField.layer.cornerRadius = 19
                searchTextField.placeholder = NSLocalizedString("searchTextField", comment: "")
                
                let placeholderColor = UIColor.customGray
                let placeholderFont = UIFont(name: "Montserrat-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: placeholderColor,
                    .font: placeholderFont
                ]
                searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder ?? "", attributes: attributes)
            }
            
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        return searchBar
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor(named: "customSearchBlue")
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var allItems: [ProductsModel.Product] = []
    private var filteredItems: [ProductsModel.Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        navigationItem.title = "Baxım məhsulları"
        activityIndicator.startAnimating()
        if let navigationController = navigationController {
            let titleTextAttributes: [NSAttributedString.Key: Any] =
            [
                .foregroundColor: UIColor(named: "customDarkBlue") ?? UIColor.black,
                .font: UIFont(name: "Montserrat-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20)
            ]
            navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        }

        view.backgroundColor = UIColor(named: "customWhite")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        filteredItems = allItems
        viewModel.delegate = self
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.viewModel.products { error in
                self.showAlert(message: error.localizedDescription)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalTo(view).offset(32)
            make.trailing.equalTo(view).offset(-32)
            make.height.equalTo(36)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(32)
            make.trailing.equalTo(view).offset(-32)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        activityIndicator.snp.makeConstraints { make in
                make.center.equalTo(view)
        }
    }
}

extension MoreProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreProductCollectionViewCell.identifier, for: indexPath) as! MoreProductCollectionViewCell
        let item = filteredItems[indexPath.item]
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController(problemName: allItems[indexPath.row].title, problemId: filteredItems[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoreProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - 81)/2 , height: 161)
    }
}

extension MoreProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { item in
                item.title.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}

extension MoreProductsViewController: ProductsDelegate {
    func didFetchProducts(data: [ProductsModel.Product]) {
        self.allItems = data.map {
            ProductsModel.Product(id: $0.id, title: $0.title, imageIds: $0.imageIds) }
        self.filteredItems = allItems
        self.collectionView.reloadData()
        self.activityIndicator.stopAnimating()
    }
}
