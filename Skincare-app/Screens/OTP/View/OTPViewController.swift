//
//  OTPViewController.swift
//  Skincare-app
//
//  Created by Apple on 29.09.24.
//

import UIKit

class OTPViewController: UIViewController {
    private let viewModel: OTPViewModel = OTPViewModel()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        sv.alignment = .center
        return sv
    }()
    private let logoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Sacramento", size: 48)
        lb.text = "SkinCare"
        lb.textColor = .black
        return lb
    }()
    private let emailTextField = CustomTextField(placeholder: "Email", title: "Email", textFieldWidth: (UIScreen.main.bounds.width - 32))
    private let OTPTextField = CustomTextField(placeholder: "● ● ● ● ● ●", title: "OTP", textFieldWidth: (UIScreen.main.bounds.width - 32))
    private let submitButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(named: "threatening_red")
        btn.layer.cornerRadius = 16
        btn.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        btn.tintColor = .white
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customBgBlue")
        view.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        stackView.setCustomSpacing(32, after: logoLabel)
        setupUI()
        setupActions()
        viewModel.onSuccess = { [weak self] in
            self?.presentLoginViewController()
        }

    }
    private func setupUI(){
        view.addSubview(stackView)
        view.addSubview(submitButton)
        [
            logoLabel,
            emailTextField,
            OTPTextField,
        ].forEach(stackView.addArrangedSubview)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(48)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(274)
            make.height.equalTo(44)
        }
    }
    private func setupActions(){
        emailTextField.textField.addTarget(self, action: #selector(didTapEmailValidate), for: .editingChanged)
        OTPTextField.textField.addTarget(self, action: #selector(didTapOTPCodeValidate), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(didTapOTPCodeButton), for: .touchUpInside)
    }
    private func presentLoginViewController() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
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
    private func didTapOTPCodeValidate() {
        if !isValidOTP(otpCode: OTPTextField.textField.text ?? "" ) {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: OTPTextField, errorMessage: "Invalid OTP code")
            }
        } else {
            validState(textField: OTPTextField)
        }
    }
    @objc
    private func didTapOTPCodeButton(){
        validState(textField: emailTextField)
        validState(textField: OTPTextField)
        let isEmailValid = validateEmail()
        let isOTPCodeValid = validateOTPCode()
        guard let email = emailTextField.textField.text else {return}
        guard let otpCode = OTPTextField.textField.text else {return}
        if isEmailValid && isOTPCodeValid {
            viewModel.otpCode(email: email, otpCode: otpCode) { error in
                print(error, "Hello OTP error")
            }
        }
    }
    func validateEmail() -> Bool {
        guard let email = emailTextField.textField.text, !email.isEmpty else {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: emailTextField, errorMessage: "Invalid email")
            }
            return false
        }
        return true
    }
    func validateOTPCode() -> Bool {
        guard let otpCode = OTPTextField.textField.text, !otpCode.isEmpty else {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: OTPTextField, errorMessage: "Invalid OTP code")
            }
            return false
        }
        return true
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidOTP(otpCode: String) -> Bool {
        let otpRegex = "^[0-9]{6}$"
        let otpPredicate = NSPredicate(format: "SELF MATCHES %@", otpRegex)
        return otpPredicate.evaluate(with: otpCode)
    }
    func inValidState(textField: CustomTextField, errorMessage: String) {
        textField.errorLabel.isHidden = false
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
