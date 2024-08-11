//
//  OnboardingRegisterViewController.swift
//  Skincare-app
//
//  Created by Umman on 11.08.24.
//

import UIKit
import SnapKit

class OnboardingRegisterViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let imageWithLabelsView = OnboardingImageView(
        image: UIImage(named: "onboarding-image"),
        label1Text: NSLocalizedString("label1Text", comment: ""),
        label2Text: NSLocalizedString("label2Text", comment: ""),
        bottomLabelText: NSLocalizedString("bottomLabelText", comment: ""),
        bgColor: UIColor.red
    )
    
    private let appleButton = IconTitleBgColorButton(bgColor: "black", icon: "apple-icon", iconWidth: 18, iconHeight: 22.5, title: NSLocalizedString("appleButtonRegisterTitle", comment: ""), titleColor: "white")
    
    private let googleButton = IconTitleBgColorButton(bgColor: "white", icon: "google-icon", iconWidth: 18, iconHeight: 18, title: NSLocalizedString("googleButtonRegisterTitle", comment: ""), titleColor: "black")
    
    private let mailButton = IconTitleBgColorButton(bgColor: "white", icon: "mail-icon", iconWidth: 17.18, iconHeight: 14.7, title: NSLocalizedString("mailButtonRegisterTitle", comment: ""), titleColor: "black")
    
    let signInButton = TitleBgColorButton(staticText: NSLocalizedString("signInButtonStaticText", comment: ""), staticTextColor: .black, title: NSLocalizedString("signInButtonTitle", comment: ""), titleColor: .customBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        stackView.addArrangedSubview(imageWithLabelsView)
        
        let customSpacing: CGFloat = 20
        stackView.setCustomSpacing(customSpacing, after: imageWithLabelsView)
        
        stackView.addArrangedSubview(appleButton)
        stackView.addArrangedSubview(googleButton)
        stackView.addArrangedSubview(mailButton)
        stackView.addArrangedSubview(signInButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageWithLabelsView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
}
