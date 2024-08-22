//
//  SearchViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    private var items: [PopularProblemsItemModel] = [
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
        .init(image: "rosacea", title: "Rosacea", solutions: ["Günəşdən Qorunma", "lazer Terapiyası", "Soyuq Kompreslər"]),
        .init(image: "psoriasis", title: "Psoriasis", solutions: ["Sağlam Pəhriz", "Kömür Tüstüsü", "Topikal Kalkineurin İnibitorlar"]),
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"]),
        .init(image: "acne", title: "Acne", solutions: ["Kimyəvi peeling", "lazer Terapiyası", "işıq Terapiyası"])
    ]
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
            searchTextField.placeholder = "Search"
            
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
    
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = .init(width: (screenWidth - 16), height: 100)
        layout.sectionInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        cv.showsVerticalScrollIndicator = false
        cv.register(PopularProblemsCollectionViewCell.self, forCellWithReuseIdentifier: PopularProblemsCollectionViewCell.identifier)
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(sortButton)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalTo(view).offset(4.5)
            make.trailing.equalTo(sortButton.snp.leading).offset(-12)
            make.height.equalTo(36)
        }
        
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularProblemsCollectionViewCell.identifier, for: indexPath) as! PopularProblemsCollectionViewCell
        if !items[indexPath.row].isAnimatedDone {
            cell.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0.3*Double(indexPath.row),animations: {
                cell.alpha = 1
            })
            items[indexPath.row].isAnimatedDone = true
        }
        cell.configure(items[indexPath.row])
        return cell
    }
}
