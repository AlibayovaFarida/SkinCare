//
//  MoreSkinProblemsViewController.swift
//  Skincare-app
//
//  Created by Umman on 15.09.24.
//

import UIKit

class MoreSkinProblemsViewController: UIViewController
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
        SkinProblemItemModel(image: "rosacea", title: "Rosacea"),
        SkinProblemItemModel(image: "acne", title: "Akne"),
        SkinProblemItemModel(image: "melazma", title: "Melazma"),
        SkinProblemItemModel(image: "ekzema", title: "Ekzema"),
        SkinProblemItemModel(image: "seboreik", title: "Seboreik"),
        SkinProblemItemModel(image: "skinCancer", title: "Dəri xərçəngi"),
        SkinProblemItemModel(image: "redSkin", title: "Qızartı"),
        SkinProblemItemModel(image: "Vitiligo", title: "Vitiliqo"),
    ]
    
    private var filteredItems: [SkinProblemItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        title = "Dəri Problemləri"
        view.backgroundColor = UIColor(named: "customWhite")
        
        if let navigationController = navigationController {
            let titleTextAttributes: [NSAttributedString.Key: Any] =
            [
                .foregroundColor: UIColor(named: "customDarkBlue") ?? UIColor.black,
                .font: UIFont(name: "Montserrat-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20)
            ]
            navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        let backButtonImage = UIImage(named: "back-button")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .customDarkBlue
        navigationItem.leftBarButtonItem = backButton
        
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
            make.leading.equalTo(view).offset(34)
            make.trailing.equalTo(view).offset(-34)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MoreSkinProblemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinProblemCollectionViewCell", for: indexPath) as! SkinProblemCollectionViewCell
        let item = filteredItems[indexPath.item]
        cell.configure(item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SkinProblemDetailsViewController(problemName: allItems[indexPath.row].title)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoreSkinProblemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 147, height: 161)
    }
}

extension MoreSkinProblemsViewController: UISearchBarDelegate {
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
