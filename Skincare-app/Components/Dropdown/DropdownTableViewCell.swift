//
//  DropdownTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {
    
    private let textlabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(named: "black")
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        lb.textColor = UIColor(named: "black")
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(textlabel)
        
        textlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(2)
        }
    }
    
    func configure(_ item: String){
        textlabel.text = item
    }
}
