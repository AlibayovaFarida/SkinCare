//
//  ProductCollectionViewCell.swift
//  Skincare-app
//
//  Created by Apple on 19.12.24.
//

import UIKit
import Alamofire

class ProductCollectionViewCell: UICollectionViewCell {
    private let bgView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "customGray")?.cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBlue")
        return view
    }()
    private let titleDirectionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    private let productTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        lb.setLineHeight(21)
        lb.textColor = .white
        return lb
    }()
    private let directionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "chevron-right"), for: .normal)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        blueView.layoutIfNeeded()
        blueView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(bgView)
        bgView.addSubview(productImageView)
        bgView.addSubview(blueView)
        blueView.addSubview(titleDirectionStackView)
        [
            productTitleLabel,
            directionButton
        ].forEach(titleDirectionStackView.addArrangedSubview)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            let screenWidth = UIScreen.main.bounds.width
            make.width.equalTo((screenWidth-64)/2-2)
            make.height.equalTo(161)
        }
        
        blueView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            let screenWidth = UIScreen.main.bounds.width
            make.width.equalTo((screenWidth-64)/2-2)
            make.height.equalTo(31)
        }
        
        titleDirectionStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(8)
        }
        directionButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    func configure(_ item: ProductsModel.Product){
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        NetworkManager.shared.getImage(url: "http://localhost:8080/api/product/photo/", imageId: item.imageIds[0], headers: headers) { image in
                self.productImageView.image = image
            }
        productTitleLabel.text = item.title
        
    }
}
