//
//  PopularProblemsCollectionViewCell.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

import UIKit

class PopularProblemsCollectionViewCell: UICollectionViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customLightBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let generalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    private let imageBackgroundView: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "customLightBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    private let descriptionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let headerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Bold", size: 16)
        lb.textColor = UIColor(named: "black")
        return lb
    }()
    
    private let redirectionImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "redirection-black")
        return iv
    }()
    private let descriptionTextLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 12)
        lb.textColor = UIColor(named: "black")
        lb.numberOfLines = 0
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(bgView)
        bgView.addSubview(generalStackView)
        [
            imageBackgroundView,
            descriptionStackView
        ].forEach(generalStackView.addArrangedSubview)
        imageBackgroundView.addSubview(imageView)
        [
            headerStackView,
            descriptionTextLabel
        ].forEach(descriptionStackView.addArrangedSubview)
        [
            headerTitleLabel,
            redirectionImageView
        ].forEach(headerStackView.addArrangedSubview)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        generalStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(2)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(84)
            make.edges.equalToSuperview()
        }
        redirectionImageView.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(24)
        }
    }
    
    func configure(_ item: PopularProblemsItemModel) {
        imageView.image = UIImage(named: item.image)
        headerTitleLabel.text = item.title
        descriptionTextLabel.text = "Həll Yolları: \(item.solutions.joined(separator: ", ")) və.s."
    }
}
