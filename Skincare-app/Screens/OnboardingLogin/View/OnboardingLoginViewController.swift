//
//  OnboardingLoginViewController.swift
//  Skincare-app
//
//  Created by Umman on 11.08.24.
//

import UIKit
import SnapKit

class OnboardingLoginViewController: UIViewController {
    
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
    
    private let appleButton = IconTitleBgColorButton(bgColor: "customBlack", icon: "apple-icon", iconWidth: 18, iconHeight: 22.5, title: NSLocalizedString("appleButtonLoginTitle", comment: ""), titleColor: "customWhite")
    
    private let googleButton = IconTitleBgColorButton(bgColor: "customWhite", icon: "google-icon", iconWidth: 18, iconHeight: 18, title: NSLocalizedString("googleButtonLoginTitle", comment: ""), titleColor: "customBlack")
    
    private let mailButton = IconTitleBgColorButton(bgColor: "customWhite", icon: "mail-icon", iconWidth: 17.18, iconHeight: 14.7, title: NSLocalizedString("mailButtonLoginTitle", comment: ""), titleColor: "customBlack")
    
    let signUpButton = TitleBgColorButton(staticText: NSLocalizedString("registerButtonStaticText", comment: ""), staticTextColor: .black, title: NSLocalizedString("registerButtonTitle", comment: ""), titleColor: .customBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
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
        stackView.addArrangedSubview(signUpButton)
        
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
    private func setupAction(){
        mailButton.action = redirectionLogin
        signUpButton.action = redirectionOnboardingRegister
    }
    @objc
    private func redirectionLogin(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc
    private func redirectionOnboardingRegister(){
        self.dismiss(animated: true)
    }
    
}
