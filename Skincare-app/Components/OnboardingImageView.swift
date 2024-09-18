//
//  onboardingImageView.swift
//  Skincare-app
//
//  Created by Umman on 09.08.24.
//

import UIKit
import SnapKit

class OnboardingImageView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBgBlue")
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let label1: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Sacramento-Regular", size: 36)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    private let label2: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 16)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    private let bottomLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Light", size: 20)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .black
        return lb
    }()
    
    init(image: UIImage?, label1Text: String, label2Text: String, bottomLabelText: String, bgColor: UIColor) {
        super.init(frame: .zero)
        setupView()
        imageView.image = image
        label1.text = "SkinCare"
        label2.text = "Çünki dəriniz ən yaxşı qayğıya layiqdir."
        bottomLabel.text = "Cildinizi parlatmaq üçün İlk addımınızı burada atın!"
        backgroundView.backgroundColor = UIColor(named: "customBgBlue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backgroundView)
        backgroundView.addSubview(imageView)

        addSubview(label1)
        addSubview(label2)
        addSubview(bottomLabel)
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom)
        }
        
        label1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(71)
        }
        
        label2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(34)
            make.leading.equalTo(backgroundView).offset(50)
            make.height.equalTo(321)
            make.width.equalTo(363)
            
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
    }
    
    private func applyRoundedCorners() {
           let cornerRadius: CGFloat = 150
           let path = UIBezierPath(roundedRect: backgroundView.bounds,
                                   byRoundingCorners: [.bottomLeft, .bottomRight],
                                   cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           backgroundView.layer.mask = mask
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           applyRoundedCorners()
       }
}
