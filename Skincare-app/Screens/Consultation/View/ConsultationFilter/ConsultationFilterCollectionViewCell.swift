//
//  ConsultationFilterCollectionViewCell.swift
//  Skincare-app
//
//  Created by Apple on 22.08.24.
//

import UIKit

class ConsultationFilterCollectionViewCell: UICollectionViewCell {
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "customGray")?.cgColor
        view.layer.cornerRadius = 18.5
        return view
    }()
    private let label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 14)
        lb.textColor = UIColor(named: "customDarkBlue")
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
        contentView.addSubview(view)
        view.addSubview(label)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(_ item: ConsultationFilterItemModel){
        label.text = item.title
        view.backgroundColor = item.isSelected ? UIColor(named: "customLightGreen") : .clear
    }
}
