//
//  ProductsViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit

class ProductsViewController: UIViewController
{
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(SkinProblemCollectionViewCell.self, forCellWithReuseIdentifier: "SkinProblemCollectionViewCell")
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
    
    private let allItems: [SkinProblemItemModel] =
    [
        SkinProblemItemModel(image: "cleansers", title: "Cleansers"),
        SkinProblemItemModel(image: "tonikler", title: "Toniklər"),
        SkinProblemItemModel(image: "skrablar", title: "Skrablar"),
        SkinProblemItemModel(image: "serumlar", title: "Serumlar"),
        SkinProblemItemModel(image: "nemlendirici", title: "Nəmləndirici"),
        SkinProblemItemModel(image: "spf", title: "SPF"),
        SkinProblemItemModel(image: "maskalar", title: "Maskalar"),
        SkinProblemItemModel(image: "baxim-yaglari", title: "Baxım yağları"),
    ]
    
    private var filteredItems: [SkinProblemItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        navigationItem.title = "Baxım məhsulları"
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
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
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
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinProblemCollectionViewCell", for: indexPath) as! SkinProblemCollectionViewCell
        let item = filteredItems[indexPath.item]
        cell.configure(item)
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 147, height: 161)
    }
}

extension ProductsViewController: UISearchBarDelegate {
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

