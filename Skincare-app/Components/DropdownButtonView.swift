
import Foundation
import UIKit

class DropdownButtonView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    var dataSource: [String] = []
    var dropdownTitle: String = ""
    private let pickerView = UIPickerView()
    private let toolbar = UIToolbar()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "white")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "customGray")?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    private let dropdownTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Montserrat-Medium", size: 13)
        tf.textColor = UIColor(named: "black")
        return tf
    }()
    
    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow")
        return iv
    }()
    
    init(dataSource: [String], dropdownTitle: String) {
        self.dataSource = dataSource
        self.dropdownTitle = dropdownTitle
        self.dropdownTextField.placeholder = dropdownTitle
        super.init(frame: .zero)
        setupUI()
        configurePicker()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(buttonView)
        buttonView.addSubview(stackView)
        [
            dropdownTextField,
            arrowImageView
        ].forEach(buttonView.addSubview)
        
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        dropdownTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        dropdownTextField.inputView = pickerView
        dropdownTextField.inputAccessoryView = toolbar
    }
    
    private func configurePicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showPicker() {
        dropdownTextField.becomeFirstResponder()
    }
    
    @objc private func doneButtonTapped() {
        dropdownTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dropdownTitle == NSLocalizedString("mounth", comment: ""){
            if dataSource[row].count > 5{
                dropdownTextField.text = String(dataSource[row].prefix(3))
            } else {
                dropdownTextField.text = dataSource[row]
            }
        } else {
            dropdownTextField.text = dataSource[row]
        }
    }
}
