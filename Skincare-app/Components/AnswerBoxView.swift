//
//  AnswerBoxView.swift
//  Skincare-app
//
//  Created by Umman on 12.08.24.
//

import UIKit

class AnswerBoxView: UIView {
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.textColor = UIColor(named: "customDarkBlue")
        label.textAlignment = .center
        return label
    }()
    
    public var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    var onSelectionChanged: ((AnswerBoxView) -> Void)?
    
    init(answerText: String) {
        super.init(frame: .zero)
        answerLabel.text = answerText
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderColor = UIColor(named: "customGray")?.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 15
        addSubview(answerLabel)
        
        answerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        updateAppearance()
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? UIColor(named: "customDarkBlue") : UIColor(named: "white")
        answerLabel.textColor = isSelected ? .white : UIColor(named: "customDarkBlue")
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        isSelected.toggle()
        onSelectionChanged?(self)
    }
    
    func setSelected(_ selected: Bool) {
        isSelected = selected
    }
}
