//
//  SearchTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
    func didTapLightBlueView()
}

class SearchTableViewCell: UITableViewCell {
    
    weak var delegate: SearchTableViewCellDelegate?
    
    private let darkBlueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBlue")
        return view
    }()
    private let skinProblemsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()
    private let skinProblemsHeaderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Lab")
        return iv
    }()
    private let headerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        lb.textColor = UIColor(named: "customWhite")
        lb.text = NSLocalizedString("searchTitle", comment: "")
        return lb
    }()
    private let skinProblemsDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 14)
        lb.textColor = UIColor(named: "customWhite")
        lb.text = NSLocalizedString("searchDescription", comment: "")
        lb.numberOfLines = 0
        return lb
    }()
    private let lightBlueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBlueHomeButton")
        return view
    }()
    private let searchStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    private let searchLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 14)
        lb.textColor = UIColor(named: "customWhite")
        lb.text = NSLocalizedString("redirectionSearch", comment: "")
        return lb
    }()
    private let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "redirection")
        return iv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        addTapGesture()
    }
    
    private func addTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLightBlueViewTap))
            lightBlueView.addGestureRecognizer(tapGesture)
            lightBlueView.isUserInteractionEnabled = true
    }
    
    @objc private func handleLightBlueViewTap() {
        UIView.animate(withDuration: 0.2, animations: {
            self.lightBlueView.alpha = 0.8
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.lightBlueView.alpha = 1.0
            }) { _ in
                self.delegate?.didTapLightBlueView()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        darkBlueView.layoutIfNeeded()
        darkBlueView.roundCorners(corners: [.topLeft, .topRight], radius:16)
        lightBlueView.layoutIfNeeded()
        lightBlueView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(darkBlueView)
        contentView.addSubview(lightBlueView)
        
        darkBlueView.addSubview(skinProblemsStackView)
        
        [
            skinProblemsHeaderStackView,
            skinProblemsDescriptionLabel
        ].forEach(skinProblemsStackView.addArrangedSubview)
        
        [
            headerImageView,
            headerTitleLabel
        ].forEach(skinProblemsHeaderStackView.addArrangedSubview)
        
        lightBlueView.addSubview(searchStackView)
        
        [
            searchLabel,
            searchImageView
        ].forEach(searchStackView.addArrangedSubview)
        
        darkBlueView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(7)
            make.height.equalTo(102)
        }
        skinProblemsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        headerImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        lightBlueView.snp.makeConstraints { make in
            make.top.equalTo(darkBlueView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().inset(12)
        }
        
        searchStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(24)
        }
    }
}
