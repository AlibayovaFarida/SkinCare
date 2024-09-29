//
//  IconTitleBgColorButton.swift
//  Skincare-app
//
//  Created by Apple on 06.08.24.
//

import Foundation
import UIKit
import SnapKit

class IconTitleBgColorButton: UIView {
    var action: (() -> Void)?
    
    let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        return view
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        return sv
    }()
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 14)
        return lb
    }()
    
    init(bgColor: String, icon: String?, iconWidth: CGFloat?, iconHeight: CGFloat?, title: String, titleColor: String){
        super.init(frame: .zero)
        self.bgView.backgroundColor = UIColor(named: bgColor)
        self.iconImageView.image = UIImage(named: icon ?? "")
        self.titleLabel.text = title
        self.titleLabel.textColor = UIColor(named: titleColor)
        setupView(iconWidth: iconWidth ?? 0, iconHeight: iconHeight ?? 0)
        setupShadows(bgColor: bgColor)
        setupGesture()
        if icon == ""{
            iconImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(iconWidth: CGFloat, iconHeight: CGFloat){
        
        addSubview(bgView)
        bgView.addSubview(stackView)
        
        [
            iconImageView,
            titleLabel
        ].forEach(stackView.addArrangedSubview)
        
        bgView.snp.makeConstraints { make in
            make.width.equalTo(274)
            make.height.equalTo(44)
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconHeight)
        }
    }
    
    private func setupShadows(bgColor: String) {
        guard bgColor == "customWhite" else { return }
                
        applyShadow(to: bgView, color: "customBlack", opacity: 0.04, offset: CGSize(width: 0, height: 0), radius: 1)
        applyShadow(to: bgView, color: "customBlack", opacity: 0.04, offset: CGSize(width: 0, height: 2), radius: 6)
        applyShadow(to: bgView, color: "customBlack", opacity: 0.05, offset: CGSize(width: 0, height: 16), radius: 24)
    }
    
    private func applyShadow(to view: UIView, color: String, opacity: Float, offset: CGSize, radius: CGFloat) {
        view.layer.shadowColor = UIColor(named: color)?.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
    
    private func setupGesture(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0
        bgView.addGestureRecognizer(longPressGesture)
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
            self.bgView.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
}
