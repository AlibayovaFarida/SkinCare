//
//  UIView+Ext.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func customSeperatorView(isFirstInSection: Bool, section: Int) {
        let separatorView = UIView()
        separatorView.backgroundColor = .headerGray
        separatorView.tag = 1001
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}


