//
//  RegisterViewController.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import UIKit

class RegisterViewController: UIViewController {
    private let viewModel: RegisterViewModel = RegisterViewModel()
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
    private let passwordTestTextField = CustomTextField(placeholder: NSLocalizedString("confirmPasswordTextField", comment: ""), title: NSLocalizedString("confirmPasswordTextField", comment: ""), textFieldWidth: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.16)))
    
    private let titleBirthDateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        return sv
    }()
    
    private let birthdateHeaderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    private let birthdateHeaderLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 16)
        lb.textColor = .black
        lb.text = NSLocalizedString("birthdateTextField", comment: "")
        return lb
    }()
    private let birthdateStarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "*"
        lb.textColor = UIColor(named: "threatening_red")
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lb
    }()
    
    private let birthdateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        sv.alignment = .leading
        return sv
    }()
    
    private let dayDropdown = DropdownButtonView(
        dataSource: Array(1...31).map {String($0)},
        dropdownTitle: NSLocalizedString("day", comment: ""))
    private let monthDropdown = DropdownButtonView(
        dataSource:[
            NSLocalizedString("january", comment: ""),
            NSLocalizedString("february", comment: ""),
            NSLocalizedString("march", comment: ""),
            NSLocalizedString("april", comment: ""),
            NSLocalizedString("may", comment: ""),
            NSLocalizedString("june", comment: ""),
            NSLocalizedString("july", comment: ""),
            NSLocalizedString("august", comment: ""),
            NSLocalizedString("september", comment: ""),
            NSLocalizedString("october", comment: ""),
            NSLocalizedString("november", comment: ""),
            NSLocalizedString("december", comment: "")],
        dropdownTitle: NSLocalizedString("month", comment: ""))
    private let yearDropdown = DropdownButtonView(dataSource: Array(1950...2024).map {String($0)}, dropdownTitle: NSLocalizedString("year", comment: ""))
    
    private let genderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        return sv
    }()
    
    private let genderHeaderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    private let genderHeaderLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 16)
        lb.textColor = .black
        lb.text = NSLocalizedString("genderTextField", comment: "")
        return lb
    }()
    private let genderStarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "*"
        lb.textColor = UIColor(named: "threatening_red")
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lb
    }()
    
    private let maleOptionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        return sv
    }()
    private let maleRadioButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "unselected-radio-btn"), for: .normal)
        btn.tag = 1
        return btn
    }()
    
    private let maleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        lb.textColor = .black
        lb.text = NSLocalizedString("male", comment: "")
        return lb
    }()
    private let femaleOptionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        return sv
    }()
    private let femaleRadioButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "unselected-radio-btn"), for: .normal)
        btn.tag = 2
        return btn
    }()
    
    private let femaleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 14)
        lb.textColor = .black
        lb.text = NSLocalizedString("female", comment: "")
        return lb
    }()
    private let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(named: "mainColor")
        btn.layer.cornerRadius = 16
        btn.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        btn.tintColor = .white
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Qeydiyyat"
        if let navigationBar = self.navigationController?.navigationBar {
            let textAttributes: [NSAttributedString.Key: Any] =
            [
                .foregroundColor: UIColor.black,
                .font: UIFont(name: "Montserrat-SemiBold", size: 20)!
            ]
            navigationBar.titleTextAttributes = textAttributes
        }
        setupCustomBackButton()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        birthdateStackView.layer.zPosition = 1
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(formStackView)
        contentViewInScroll.addSubview(submitButton)
        [nameTextField,
         surnameTextField,
         emailTextField,
         passwordTextField,
         passwordTestTextField,
         titleBirthDateStackView,
         genderStackView
        ].forEach(formStackView.addArrangedSubview)
        
        [
            birthdateHeaderStackView,
            birthdateStackView
        ].forEach(titleBirthDateStackView.addArrangedSubview)
        
        [
            birthdateHeaderLabel,
            birthdateStarLabel
        ].forEach(birthdateHeaderStackView.addArrangedSubview)
        
        [
            dayDropdown,
            monthDropdown,
            yearDropdown
        ].forEach(birthdateStackView.addArrangedSubview)
        
        [
            genderHeaderStackView,
            maleOptionStackView,
            femaleOptionStackView
        ].forEach(genderStackView.addArrangedSubview)
        
        [
            genderHeaderLabel,
            genderStarLabel
        ].forEach(genderHeaderStackView.addArrangedSubview)
        
        [
            maleRadioButton,
            maleLabel
        ].forEach(maleOptionStackView.addArrangedSubview)
        
        [
            femaleRadioButton,
            femaleLabel
        ].forEach(femaleOptionStackView.addArrangedSubview)
        
        view.bringSubviewToFront(dayDropdown)
        view.bringSubviewToFront(monthDropdown)
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
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(formStackView.snp.bottom).offset(68)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(35)
            make.width.equalTo(106)
            make.height.equalTo(44)
        }

    }

    private func setupActions() {
        nameTextField.textField.addTarget(self, action: #selector(didTapNameValidate), for: .editingChanged)
        surnameTextField.textField.addTarget(self, action: #selector(didTapSurnameValidate), for: .editingChanged)
        emailTextField.textField.addTarget(self, action: #selector(didTapEmailValidate), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(didTapPasswordValidate), for: .editingChanged)
        passwordTestTextField.textField.addTarget(self, action: #selector(didTapPasswordTestValidate), for: .editingChanged)
        maleRadioButton.addTarget(self, action: #selector(didTapGenderOption), for: .touchUpInside)
        femaleRadioButton.addTarget(self, action: #selector(didTapGenderOption), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    private func setupCustomBackButton() {
        guard let backButtonImage = UIImage(named: "back-button") else {
            print("Error: Back button image not found.")
            return
        }
                
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
                
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
                
        backButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
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

    @objc
    private func didTapPasswordTestValidate() {
        if !isValidPassword(password: passwordTestTextField.textField.text ?? "") {
            UIView.animate(withDuration: 0.2) { [self] in
                inValidState(textField: passwordTestTextField, errorMessage: "Invalid confirm password")
            }
        } else {
            validState(textField: passwordTestTextField)
        }
    }
    
    @objc
    private func didTapGenderOption(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            maleRadioButton.setImage(UIImage(named: "selected-radio-btn"), for: .normal)
            femaleRadioButton.setImage(UIImage(named: "unselected-radio-btn"), for: .normal)
        case 2:
            femaleRadioButton.setImage(UIImage(named: "selected-radio-btn"), for: .normal)
            maleRadioButton.setImage(UIImage(named: "unselected-radio-btn"), for: .normal)
        default:
            break
        }
    }
    @objc
    private func didTapRegisterButton(){
        guard let name = nameTextField.textField.text else {return}
        guard let surname = nameTextField.textField.text else {return}
        guard let email = nameTextField.textField.text else {return}
        guard let password = nameTextField.textField.text else {return}
        guard let rePassword = nameTextField.textField.text else {return}
        viewModel.register(name: name, surname: surname, email: email, password: password, rePassword: rePassword) { error in
            print(error, "Hello error")
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

