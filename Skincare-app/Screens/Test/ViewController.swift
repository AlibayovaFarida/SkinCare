//
//  ViewController.swift
//  Skincare-app
//
//  Created by Apple on 05.08.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
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
    
    private let appleButton = IconTitleBgColorButton(bgColor: "black", icon: "apple-icon", iconWidth: 18, iconHeight: 22.5, title: NSLocalizedString("appleButtonLoginTitle", comment: ""), titleColor: "white")
    
    private let googleButton = IconTitleBgColorButton(bgColor: "white", icon: "google-icon", iconWidth: 18, iconHeight: 18, title: NSLocalizedString("googleButtonLoginTitle", comment: ""), titleColor: "black")
    
    private let mailButton = IconTitleBgColorButton(bgColor: "white", icon: "mail-icon", iconWidth: 17.18, iconHeight: 14.7, title: NSLocalizedString("mailButtonLoginTitle", comment: ""), titleColor: "black")
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField = CustomTextField(placeholder: "Password")
    
    let signUpButton = TitleBgColorButton(staticText: NSLocalizedString("registerButtonStaticText", comment: ""), staticTextColor: .black, title: NSLocalizedString("registerButtonTitle", comment: ""), titleColor: .customBlue)
    
    let signInButton = TitleBgColorButton(staticText: NSLocalizedString("signInButtonStaticText", comment: ""), staticTextColor: .black, title: NSLocalizedString("signInButtonTitle", comment: ""), titleColor: .customBlue)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
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
    
    private func setupActions(){
        
        appleButton.action = {
            print("Apple 🍎🍎")
            print("Apple 🍎")
        }
        
        googleButton.action = {
            print("Google 🔍")
        }
        
        mailButton.action = {
            print("Mail ✉️")
        }
        
        emailTextField.textField.addTarget(self, action: #selector(didTapEmailValidate), for: .editingChanged)
        
        passwordTextField.textField.addTarget(self, action: #selector(didTapPasswordValidate), for: .editingChanged)
        
        signUpButton.action = {
              print("Sign Up button tapped")
          }
        
        signInButton.action = {
              print("Sign In button tapped")
          }
    }
    
    @objc
    private func didTapEmailValidate(){
        if !isValidEmail(email: emailTextField.textField.text ?? "" )  {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: emailTextField, errorMessage: "Invalid email")
            }
        } else{
            validState(textField: emailTextField)
        }
    }
    
    @objc
    private func didTapPasswordValidate(){
        if !isValidPassword(password: passwordTextField.textField.text ?? ""){
            UIView.animate(withDuration: 0.2) { [self] in
                self.inValidState(textField: passwordTextField, errorMessage: "Invalid password")
            }
        } else {
            validState(textField: passwordTextField)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func inValidState(textField: CustomTextField, errorMessage: String){
        textField.errorLabel.isHidden = false
        textField.errorLabel.text = errorMessage
        textField.textFieldView.layer.borderWidth = 1
        textField.textFieldView.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
    }
    
    func validState(textField: CustomTextField){
        textField.errorLabel.isHidden = true
        textField.errorLabel.text = ""
        textField.textFieldView.layer.borderWidth = 1
        textField.textFieldView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
    }
}

