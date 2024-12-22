//
//  ProductsTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 19.12.24.
//

//
//  SkinProblemsTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 13.09.24.
//

import UIKit

protocol ProductsTableViewCellDelegate: AnyObject {
    func didTapProductsMoreButton()
//    func skinProblemsTableViewCell(_ cell: SkinProblemsTableViewCell, didSelectItem item: SkinProblemsModel.SkinProblem)
}

class ProductsTableViewCell: UITableViewCell {
    
    weak var delegate: ProductsTableViewCellDelegate?
    
    private var products: [ProductsModel.Product] = []
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        return sv
    }()
    private let headerTitle: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Bold", size: 20)
        lb.textColor = UIColor(named: "customDarkBlue")
        lb.text = NSLocalizedString("skinProblems", comment: "")
        return lb
    }()
    private let moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(NSLocalizedString("seeAll", comment: ""), for: .normal)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        btn.titleLabel?.attributedText = underlineAttributedString
        btn.setTitleColor(UIColor(named: "customDarkBlue"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 12)
        return btn
    }()
    private let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let screenWidth = UIScreen.main.bounds.width
//        layout.itemSize = .init(width: (screenWidth-64)/2, height: 161)
        layout.itemSize = .init(width: 147, height: 161)
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        productsCollectionView.dataSource = self
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(headerStackView)
        contentView.addSubview(productsCollectionView)
        [
            headerTitle,
            moreButton
        ].forEach(headerStackView.addArrangedSubview)
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(161)
        }
    }
    
    func configure(_ item: [ProductsModel.Product]){
        products = item
        productsCollectionView.reloadData()
    }
    
    @objc private func moreButtonTapped() {
        delegate?.didTapProductsMoreButton()
        print("More button tapped")
       }
}

extension ProductsTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(products[indexPath.row])
        return cell
    }
}

