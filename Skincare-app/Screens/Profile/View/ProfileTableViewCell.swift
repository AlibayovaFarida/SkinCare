//
//  ProfileTableViewCell.swift
//  Skincare-app
//
//  Created by Umman on 14.09.24.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let customLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let customArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Chevron_Left")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(customImageView)
        contentView.addSubview(customLabel)
        contentView.addSubview(customArrowImageView)
    }
    
    private func setupConstraints() {
        customImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(24)
        }
        
        customLabel.snp.makeConstraints { make in
            make.leading.equalTo(customImageView.snp.trailing).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(customArrowImageView.snp.leading).offset(-8)
        }
        
        customArrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(24)
        }
    }
}
