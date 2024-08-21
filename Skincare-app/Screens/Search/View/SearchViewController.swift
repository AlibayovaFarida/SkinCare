//
//  SearchViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    private var items: [(title: String, subtitle: String, leftImage: UIImage?, rightImage: UIImage?)] = [
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Rosacea", subtitle: "Həll Yolları; Günəşdən Qorunma, lazer Terapiyası, Soyuq Kompreslər və.s.", leftImage: UIImage(named: "rosacea"), rightImage: UIImage(named: "redirection-black")),
        (title: "Psoriasis", subtitle: "Həll Yolları; Sağlam Pəhriz, Kömür Tüstüsü, Topikal Kalkineurin İnibitorlar", leftImage: UIImage(named: "acne2"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),
        (title: "Acne", subtitle: "Həll yolları: Kimyəvi peeling, lazer Terapiyası, işıq Terapiyası və.s.", leftImage: UIImage(named: "acne"), rightImage: UIImage(named: "redirection-black")),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        setupViews()
        setupConstraints()    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(sortButton)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
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
            make.top.equalTo(searchBar.snp.bottom).offset(10)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        let item = items[indexPath.item]
        cell.configure(with: item.title, subtitle: item.subtitle, leftImage: item.leftImage, rightImage: item.rightImage)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 19, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}





