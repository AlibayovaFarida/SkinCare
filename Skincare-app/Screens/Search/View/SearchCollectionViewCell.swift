//
//  SearchCollectionViewCell.swift
//  Skincare-app
//
//  Created by Umman on 20.08.24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(rightImageView)
        
        middleStackView.addArrangedSubview(horizontalStackView)
        middleStackView.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(leftImageView)
        contentView.addSubview(middleStackView)
        
        contentView.backgroundColor = .searchCell
        contentView.layer.cornerRadius = 16
    }
    
    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(85)
        }
        
        middleStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(24)
        }
    }
    
    func configure(with title: String, subtitle: String, leftImage: UIImage?, rightImage: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        leftImageView.image = leftImage
        rightImageView.image = rightImage
    }
}
