//
//  CustomTextField.swift
//  Skincare-app
//
//  Created by Apple on 07.08.24.
//

import Foundation
import UIKit

class CustomTextField: UIView {
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.alignment = .leading
        return sv
    }()
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    private let headerLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 16)
        lb.textColor = UIColor(named: "black")
        return lb
    }()
    private let starLabel: UILabel = {
        let lb = UILabel()
        lb.text = "*"
        lb.textColor = UIColor(named: "threatening_red")
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lb
    }()
    let textFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: "white")
        return view
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.textColor = UIColor(named: "customGray")
        tf.font = UIFont(name: "Montserrat-Medium", size: 14)
        return tf
    }()
    let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        lb.isHidden = true
        return lb
    }()
    init(placeholder: String, title: String, textFieldWidth: CGFloat){
        super.init(frame: .zero)
        self.textField.placeholder = placeholder
        self.headerLabel.text = title
        setupUI(textFieldWidth: textFieldWidth)
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(textFieldWidth: CGFloat){
        addSubview(stackView)
        [
            headerStackView,
            textFieldView,
            errorLabel
        ].forEach(stackView.addArrangedSubview)
        
        [
            headerLabel,
            starLabel
        ].forEach(headerStackView.addArrangedSubview)
        textFieldView.addSubview(textField)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textFieldView.snp.makeConstraints { make in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(44)
            make.leading.equalToSuperview().offset(0)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
        }
    }
    
    private func setupShadows() {
                
        applyShadow(to: textFieldView, color: UIColor.black, opacity: 0.04, offset: CGSize(width: 0, height: 0), radius: 1)
        applyShadow(to: textFieldView, color: UIColor.black, opacity: 0.04, offset: CGSize(width: 0, height: 2), radius: 6)
        applyShadow(to: textFieldView, color: UIColor.black, opacity: 0.05, offset: CGSize(width: 0, height: 16), radius: 24)
    }
    
    private func applyShadow(to view: UIView, color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }

}

