//
//  CompleteTestViewController.swift
//  Skincare-app
//
//  Created by Umman on 12.08.24.
//

import UIKit
import SnapKit

class CompleteTestViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupReturnHomeButton()
        setupStackView()
        self.navigationItem.hidesBackButton = true
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 192/255, green: 215/255, blue: 253/255, alpha: 1).cgColor,
            UIColor(red: 153/255, green: 189/255, blue: 236/255, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupReturnHomeButton() {
        let returnHomeButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .customBlueHomeButton
        config.baseForegroundColor = .white
        let customFont = UIFont(name: "Montserrat-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        config.attributedTitle = AttributedString("Ana səhifəyə qayıt", attributes: AttributeContainer([.font: customFont]))
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
        returnHomeButton.configuration = config
        returnHomeButton.addTarget(self, action: #selector(returnHomeButtonTapped), for: .touchUpInside)
        returnHomeButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        returnHomeButton.addTarget(self, action: #selector(buttonTouchUpInside), for: [.touchUpInside, .touchCancel])
        
        view.addSubview(returnHomeButton)
        
        returnHomeButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(-20)
            make.trailing.equalTo(view.snp.trailing).offset(20)
            make.bottom.equalTo(view.snp.bottom).offset(20)
            make.height.equalTo(90)
        }
    }

    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 0.7
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc private func buttonTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 1.0
            sender.transform = CGAffineTransform.identity
        }
    }

    
    private func setupStackView() {
        configureStackView()
        let containerView = configureContainerView()
        configureIconLabelStackView(in: containerView)
        configureLineView()
        configureBottomStackView()
    }

    private func configureStackView() {
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 25
        stackView.layer.masksToBounds = true
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(322)
            make.width.equalTo(343)
            make.center.equalTo(view)
        }
    }

    private func configureContainerView() -> UIView {
        let containerView = UIView()
        stackView.addArrangedSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(130)
        }
        
        return containerView
    }

    private func configureIconLabelStackView(in containerView: UIView) {
        let iconLabelStackView = UIStackView()
        iconLabelStackView.axis = .vertical
        iconLabelStackView.spacing = 12
        
        let iconImageView = UIImageView(image: UIImage(named: "Check"))
        iconImageView.contentMode = .scaleAspectFit
        iconLabelStackView.addArrangedSubview(iconImageView)
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Test tamamlandı!"
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont(name: "Montserrat-Medium", size: 20)
        iconLabelStackView.addArrangedSubview(bottomLabel)
        
        containerView.addSubview(iconLabelStackView)
        
        iconLabelStackView.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(10)
        }
    }

    private func configureLineView() {
        let lineView = UIImageView(image: UIImage(named: "Line"))
        lineView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
            make.height.equalTo(2)
        }
    }

    private func configureBottomStackView() {
        let bottomStackView = UIStackView()
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 10
        
        let topLabel = UILabel()
        topLabel.text = "Dəri tipiniz verdiyiniz cavablara əsasən təyin olundu. İstifadə etdiyiniz məhsulları dəri tipinizə görə tənzimləməniz tövsiyə olunur."
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        topLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        let iconLabelStackViewBottom = configureIconLabelStackViewBottom()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .customLightGreen
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.masksToBounds = true
        
        bottomStackView.addArrangedSubview(topLabel)
        bottomStackView.addArrangedSubview(backgroundView)
        
        stackView.addArrangedSubview(bottomStackView)
        
        backgroundView.addSubview(iconLabelStackViewBottom)
        
        bottomStackView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
            make.height.equalTo(150)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.equalTo(bottomStackView).offset(41)
            make.trailing.equalTo(bottomStackView).offset(-41)
            make.bottom.equalTo(bottomStackView).offset(-16)
            make.height.equalTo(55)
        }
        
        iconLabelStackViewBottom.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView).inset(10)
            make.height.equalTo(55)
        }
        
        let spacerView = UIView()
        bottomStackView.addArrangedSubview(spacerView)
        
        spacerView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        topLabel.snp.makeConstraints { make in
            make.leading.equalTo(stackView).offset(22)
            make.trailing.equalTo(stackView).offset(-22)
        }
    }

    private func configureIconLabelStackViewBottom() -> UIStackView {
        let iconLabelStackViewBottom = UIStackView()
        iconLabelStackViewBottom.axis = .horizontal
        iconLabelStackViewBottom.spacing = 10
        
        let iconImageViewBottom = UIImageView(image: UIImage(named: "OilyFace"))
        iconImageViewBottom.contentMode = .scaleAspectFit
        iconLabelStackViewBottom.addArrangedSubview(iconImageViewBottom)
        
        let bottomLabelTwo = UILabel()
        bottomLabelTwo.textAlignment = .left
        iconLabelStackViewBottom.addArrangedSubview(bottomLabelTwo)
        
        updateBottomLabel(with: "Yağlıdır", label: bottomLabelTwo)
        
        return iconLabelStackViewBottom
    }

    private func updateBottomLabel(with dynamicText: String, label: UILabel) {
        let fullText = "Sizin dəri tipiniz \(dynamicText)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let normalFont = UIFont(name: "Montserrat-Medium", size: 16)!
        let highlightedFont = UIFont(name: "Montserrat-Bold", size: 16)!
        
        let dynamicTextRange = (fullText as NSString).range(of: dynamicText)
        
        attributedString.addAttribute(.font, value: normalFont, range: NSRange(location: 0, length: (fullText as NSString).length - dynamicText.count))
        attributedString.addAttribute(.font, value: highlightedFont, range: dynamicTextRange)
        
        label.attributedText = attributedString
    }
    
    @objc private func returnHomeButtonTapped() {
        let homeVC = CustomTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.sublayers?.first?.frame = view.bounds
    }
    
}
