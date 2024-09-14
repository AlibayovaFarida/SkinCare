//
//  FilterItemCollectionViewCell.swift
//  Skincare-app
//
//  Created by Apple on 26.08.24.
//

import UIKit

class FilterItemCollectionViewCell: UICollectionViewCell {
    var onRemoveFilter: (() -> Void)?
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customLightGreen")
        view.layer.cornerRadius = 13
        return view
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        return sv
    }()
    private let removeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(nil, action: #selector(removeButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc
    private func removeButtonTapped(){
        onRemoveFilter?()
    }
    private let filterTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 12)
        lb.textColor = .black
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
        bgView.addSubview(stackView)
        [
            removeButton,
            filterTitleLabel
        ].forEach(stackView.addArrangedSubview)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        removeButton.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
    
    func configure(_ item: ConsultationFilterItemModel){
        filterTitleLabel.text = item.title
    }
}
