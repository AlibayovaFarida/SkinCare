//
//  titleBgColorButton.swift
//  Skincare-app
//
//  Created by Umman on 09.08.24.
//

import UIKit

class TitleBgColorButton: UIView {
    
    var action: (() -> Void)?
    
    private let staticLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    init(staticText: String, staticTextColor: UIColor, title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        
        staticLabel.text = staticText
        staticLabel.textColor = staticTextColor
        
        titleLabel.text = title
        titleLabel.textColor = titleColor
        
        setupView()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(staticLabel)
      
        stackView.addArrangedSubview(titleLabel)
        
        stackView.snp.makeConstraints { make in
              make.center.equalToSuperview()
              make.leading.greaterThanOrEqualToSuperview().offset(8)
              make.trailing.lessThanOrEqualToSuperview().offset(-8)
              make.top.greaterThanOrEqualToSuperview().offset(8)
              make.bottom.lessThanOrEqualToSuperview().offset(-8)
          }
    }
    
    private func setupGesture(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0
        stackView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
            case .began:
                animate(scale: 0.95)
            case .ended, .cancelled:
                animate(scale: 1.0)
                action?()
            default:
                break
            }
        }
        
    private func animate(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.stackView.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
}
