//
//  LoginViewController.swift
//  Skincare-app
//
//  Created by Apple on 11.08.24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    private let contentViewInScroll: UIView = {
        let view = UIView()
        return view
    }()
    private let generalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .center
        return sv
    }()
    
    private let imageWithLabelsView = OnboardingImageView(
        image: UIImage(named: "onboarding-image"),
        label1Text: NSLocalizedString("label1Text", comment: ""),
        label2Text: NSLocalizedString("label2Text", comment: ""),
        bottomLabelText: "Şifrəni unutmusan?",
        bgColor: UIColor.red
    )
    
    private let formStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .center
        return sv
    }()
    private let emailTextField = CustomTextField(placeholder: "Email", title: "", textFieldWidth: 270)
    private let passwordTextField = CustomTextField(placeholder: "Password", title: "", textFieldWidth: 270)
    private let loginButton = IconTitleBgColorButton(bgColor: "mainColor", icon: "", iconWidth: 0, iconHeight: 0, title: "Daxil ol", titleColor: "white")
    
    let forgotPasswordButton = TitleBgColorButton(staticText:"", staticTextColor: .black, title: "Şifrəni unutmusan?", titleColor: .customBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupActions()
    }
    
    private func setupUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(formStackView)
        [
            imageWithLabelsView,
            emailTextField,
            passwordTextField,
            loginButton,
            forgotPasswordButton
        ].forEach(formStackView.addArrangedSubview)
        
        let customSpacing: CGFloat = 20
        formStackView.setCustomSpacing(customSpacing, after: imageWithLabelsView)

        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentViewInScroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        formStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        imageWithLabelsView.snp.makeConstraints { make in
            make.top.equalTo(contentViewInScroll.snp.top)
            make.leading.equalTo(contentViewInScroll.snp.leading)
            make.trailing.equalTo(contentViewInScroll.snp.trailing)
        }
    }
    private func setupActions() {
        emailTextField.textField.addTarget(self, action: #selector(didTapEmailValidate), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(didTapPasswordValidate), for: .editingChanged)
    }

    @objc
    private func didTapEmailValidate() {
        if !isValidEmail(email: emailTextField.textField.text ?? "" ) {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: emailTextField, errorMessage: "Invalid email")
            }
        } else {
            validState(textField: emailTextField)
        }
    }

    @objc
    private func didTapPasswordValidate() {
        if !isValidPassword(password: passwordTextField.textField.text ?? "") {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: passwordTextField, errorMessage: "Invalid password")
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

    func inValidState(textField: CustomTextField, errorMessage: String) {
        textField.errorLabel.isHidden = true
        textField.errorLabel.text = errorMessage
        textField.textFieldView.layer.borderWidth = 1
        textField.textFieldView.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
    }

    func validState(textField: CustomTextField) {
        textField.errorLabel.isHidden = true
        textField.errorLabel.text = ""
        textField.textFieldView.layer.borderWidth = 1
        textField.textFieldView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
}
