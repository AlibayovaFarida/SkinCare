//
//  ConsultationViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit
import SnapKit

class ConsultationViewController: UIViewController {
    
    private var items: [DermatologistModel] = [
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Laura", profession: "Dermatologist", rating: 4.9, patientCount: 140, price: 18, experience: 3, image: "youngWoman"),
        .init(name: "Edwards", profession: "Dermatologist", rating: 4.5, patientCount: 230, price: 30, experience: 18, image: "oldMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),]
    
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
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setLeftAlignTitleView(font: UIFont(name: "Montserrat-SemiBold", size: 20)!, text: "Öz həkimini seç", textColor: .black)
    }
    
    func setLeftAlignTitleView(font: UIFont, text: String, textColor: UIColor) {
        guard let navFrame = navigationController?.navigationBar.frame else{
            return
        }
        
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: navFrame.width*2, height: navFrame.height))
        self.navigationItem.titleView = parentView
        
        let label = UILabel(frame: .init(x: parentView.frame.minX-8, y: parentView.frame.minY, width: parentView.frame.width, height: parentView.frame.height))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = font
        label.textAlignment = .left
        label.textColor = textColor
        label.text = text
        parentView.addSubview(label)
    }

    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(sortButton)
        view.addSubview(collectionView)
        
        collectionView.register(ConsultationCollectionViewCell.self, forCellWithReuseIdentifier: "ConsultationCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
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

extension ConsultationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConsultationCollectionViewCell", for: indexPath) as! ConsultationCollectionViewCell
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

extension ConsultationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 15, height: 213)
    }
}
