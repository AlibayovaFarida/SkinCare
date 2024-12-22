//
//  ProductAccordionTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 19.12.24.
//

import UIKit

import UIKit

protocol ProductAccordionTableViewCellDelegate: AnyObject {
    func didTapAccordionButton(in cell: ProductAccordionTableViewCell)
}

class ProductAccordionTableViewCell: UITableViewCell {
    private var isExpanded: Bool = false
    weak var delegate: ProductAccordionTableViewCellDelegate?
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accordionCellBgBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    private let generalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    private let headerLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Semibold", size: 16)
        lb.textColor = UIColor(named: "customDarkBlue")
        lb.numberOfLines = 0
        lb.setLineHeight(24)
        return lb
    }()
    private let arrowButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow-left"), for: .normal)
        btn.addTarget(nil, action: #selector(didTapAccordionButton), for: .touchUpInside)
        return btn
    }()
    @objc
    private func didTapAccordionButton(){
        isExpanded.toggle()
        detailsLabel.isHidden.toggle()
        lineView.isHidden.toggle()
        rotateArrowButton(isExpanded)
        delegate?.didTapAccordionButton(in: self)
    }
    private func rotateArrowButton(_ expand: Bool) {
        UIView.animate(withDuration: 0.3) {
            let angle: CGFloat = expand ? .pi / 2 : 0
            self.arrowButton.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    private let detailsLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 14)
        lb.textColor = UIColor(named: "customDarkBlue")
        lb.numberOfLines = 0
        lb.layoutIfNeeded()
        lb.setLineHeight(21)
        lb.isHidden = true
        return lb
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(bgView)
        bgView.addSubview(generalStackView)
        [
            headerStackView,
            lineView,
            detailsLabel
        ].forEach(generalStackView.addArrangedSubview)
        [
            headerLabel,
            arrowButton
        ].forEach(headerStackView.addArrangedSubview)
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        generalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        arrowButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        lineView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            make.width.equalTo(screenWidth - 56)
            make.height.equalTo(1)
        }
    }
    func configure(_ item: ProductDetailsModel.Information){
        headerLabel.text = item.question
        detailsLabel.text = item.answer
    }
}
