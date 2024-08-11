//
//  RegisterViewController.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private let contentViewInScroll: UIView = {
        let view = UIView()
        return view
    }()

    private let formStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 28
        sv.alignment = .leading
        return sv
    }()

    private let nameTextField = CustomTextField(placeholder: NSLocalizedString("nameTextField", comment: ""), title: NSLocalizedString("nameTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    private let surnameTextField = CustomTextField(placeholder: NSLocalizedString("surnameTextField", comment: ""), title: NSLocalizedString("surnameTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    private let emailTextField = CustomTextField(placeholder: NSLocalizedString("emailTextField", comment: ""), title: NSLocalizedString("emailTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    private let passwordTextField = CustomTextField(placeholder: NSLocalizedString("passwordTextField", comment: ""), title: NSLocalizedString("passwordTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    private let passwordTestTextField = CustomTextField(placeholder: NSLocalizedString("passwordTextField", comment: ""), title: NSLocalizedString("passwordTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    
    private let titleBirthDateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        return sv
    }()
    
    private let birthDateHeaderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    private let headerLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 16)
        lb.textColor = UIColor(named: "black")
        lb.text = NSLocalizedString("birthDateTextField", comment: "")
        return lb
    }()
    private let starLabel: UILabel = {
        let lb = UILabel()
        lb.text = "*"
        lb.textColor = UIColor(named: "threatening_red")
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lb
    }()
    
    private let birthDateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        sv.alignment = .leading
        return sv
    }()
    
    private let dayDropdown = DropdownButtonView(dataSource:["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"], dropdownTitle: "Gün")
    private let mounthDropdown = DropdownButtonView(dataSource:[NSLocalizedString("january", comment: ""), NSLocalizedString("february", comment: ""), NSLocalizedString("march", comment: ""), NSLocalizedString("april", comment: ""), NSLocalizedString("may", comment: ""), NSLocalizedString("june", comment: ""), NSLocalizedString("july", comment: ""), NSLocalizedString("august", comment: ""), NSLocalizedString("september", comment: ""), NSLocalizedString("october", comment: ""), NSLocalizedString("november", comment: ""), NSLocalizedString("december", comment: "")], dropdownTitle: "Ay")
    private let yearDropdown = DropdownButtonView(dataSource: Array(1950...2024).map {String($0)}, dropdownTitle: "İl")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
       
        birthDateStackView.layer.zPosition = 1
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(formStackView)
        [nameTextField,
         surnameTextField,
         emailTextField,
         passwordTextField,
         titleBirthDateStackView
        ].forEach(formStackView.addArrangedSubview)
        
        [
            birthDateHeaderStackView,
            birthDateStackView
        ].forEach(titleBirthDateStackView.addArrangedSubview)
        
        [
            headerLabel,
            starLabel
        ].forEach(birthDateHeaderStackView.addArrangedSubview)
        
        [
            dayDropdown,
            mounthDropdown,
            yearDropdown
        ].forEach(birthDateStackView.addArrangedSubview)
        
        view.bringSubviewToFront(dayDropdown)
        view.bringSubviewToFront(mounthDropdown)
        view.bringSubviewToFront(yearDropdown)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentViewInScroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        formStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }

    }

    private func setupActions() {
        nameTextField.textField.addTarget(self, action: #selector(didTapNameValidate), for: .editingChanged)
        surnameTextField.textField.addTarget(self, action: #selector(didTapSurnameValidate), for: .editingChanged)
        emailTextField.textField.addTarget(self, action: #selector(didTapEmailValidate), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(didTapPasswordValidate), for: .editingChanged)
    }

   
    @objc
    private func didTapNameValidate() {
        if !isValidNameSurname(name: nameTextField.textField.text ?? "") {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: nameTextField, errorMessage: "Invalid name")
            }
        } else {
            validState(textField: nameTextField)
        }
    }

    @objc
    private func didTapSurnameValidate() {
        if !isValidNameSurname(name: surnameTextField.textField.text ?? "") {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: surnameTextField, errorMessage: "Invalid surname")
            }
        } else {
            validState(textField: surnameTextField)
        }
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

    func isValidNameSurname(name: String) -> Bool {
        let nameRegex = "^[A-Za-z\\s-]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
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

