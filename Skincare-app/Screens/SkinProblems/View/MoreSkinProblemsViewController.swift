//
//  MoreSkinProblemsViewController.swift
//  Skincare-app
//
//  Created by Apple on 05.12.24.
//

import UIKit

class MoreSkinProblemsViewController: UIViewController
{
    private let viewModel: SkinProblemsViewModel = SkinProblemsViewModel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(MoreSkinProblemsCollectionViewCell.self, forCellWithReuseIdentifier: MoreSkinProblemsCollectionViewCell.identifier)
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
    private var allItems: [SkinProblemsModel.SkinProblem] = []
    private var filteredItems: [SkinProblemsModel.SkinProblem] = []
    
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
        
        viewModel.delegate = self
    }
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        viewModel.skinProblems { error in
            self.showAlert(message: error.localizedDescription)
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
    }
}

extension MoreSkinProblemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreSkinProblemsCollectionViewCell", for: indexPath) as! MoreSkinProblemsCollectionViewCell
        let item = filteredItems[indexPath.item]
        cell.configure(item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SkinProblemDetailsViewController(problemName: filteredItems[indexPath.row].title, problemId: filteredItems[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoreSkinProblemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - 81)/2, height: 161)
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
extension MoreSkinProblemsViewController: SkinProblemsDelegate{
    
    func didFetchSkinProblems(data: [SkinProblemsModel.SkinProblem]) {
        self.allItems = data.map { SkinProblemsModel.SkinProblem(id: $0.id, title: $0.title, imageIds: $0.imageIds) }
        self.filteredItems = allItems
        self.collectionView.reloadData()
    }
}
