//
//  UILabel+Ext.swift
//  Skincare-app
//
//  Created by Apple on 09.09.24.
//

import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - self.font.lineHeight
        
        let attributedString = NSAttributedString(
            string: labelText,
            attributes: [
                .font: self.font as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: self.textColor as Any
            ]
        )
        
        self.attributedText = attributedString
    }
}
