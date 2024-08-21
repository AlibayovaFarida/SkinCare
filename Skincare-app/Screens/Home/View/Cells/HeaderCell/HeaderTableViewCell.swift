//
//  HeaderTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 14.08.24.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    private let generalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillProportionally
        return sv
    }()
    private let welcomeStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    private let welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 12)
        lb.textColor = UIColor(named: "customBlack")
        lb.text = NSLocalizedString("welcome", comment: "")
        return lb
    }()
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        lb.textColor = UIColor(named: "customBlack")
        lb.text = "Ayla"
        return lb
    }()
    private let notificationsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "notifications"), for: .normal)
        btn.layer.cornerRadius = 22
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(named: "customGray")?.cgColor
        return btn
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(generalStackView)
        
        [
            welcomeStackView,
            notificationsButton
        ].forEach(generalStackView.addArrangedSubview)
        
        [
            welcomeLabel,
            usernameLabel
        ].forEach(welcomeStackView.addArrangedSubview)
        
        generalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
        notificationsButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    }
}
