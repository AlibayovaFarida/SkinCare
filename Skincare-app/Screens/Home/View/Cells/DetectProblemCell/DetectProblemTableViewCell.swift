//
//  DetectProblemTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 14.08.24.
//

import UIKit

class DetectProblemTableViewCell: UITableViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBgBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        return view
    }()
    private let descriptionStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        return sv
    }()
    private let textStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        return sv
    }()
    private let logoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Sacramento-Regular", size: 36)
        lb.textColor = UIColor(named: "customBlack")
        lb.text = "SkinCare"
        return lb
    }()
    private let mottoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 12)
        lb.textColor = UIColor(named: "customBlack")
        lb.numberOfLines = 2
        lb.text = NSLocalizedString("detectProblemDescription", comment: "")
        lb.setLineHeight(14.63)
        return lb
    }()
    private let detectProblemButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isUserInteractionEnabled = true
        btn.setTitle(NSLocalizedString("detectProblemButton", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(named: "customBlack"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 12)
        btn.backgroundColor = UIColor(named: "customLightGreen")
        btn.layer.cornerRadius = 17
        return btn
    }()
    private let detectProblemImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "detect-problem")
        return iv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        detectProblemButton.addTarget(self, action: #selector(didTapDetectProblem), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func didTapDetectProblem() {
        UIView.animate(withDuration: 0.2, animations: {
            self.detectProblemButton.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.detectProblemButton.alpha = 1.0
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let viewController = self.findViewController() {
                let vc = DetectProblemViewController()
                viewController.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    private func setupUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(descriptionView)
        bgView.addSubview(detectProblemImageView)
        
        descriptionView.addSubview(descriptionStackView)
        [
            textStackView,
            detectProblemButton
        ].forEach(descriptionStackView.addArrangedSubview)
        [
            logoLabel,
            mottoLabel
        ].forEach(textStackView.addArrangedSubview)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        descriptionStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(21.5)
            make.leading.trailing.equalToSuperview()
        }
        detectProblemButton.snp.makeConstraints { make in
            make.width.equalTo(168)
            make.height.equalTo(34)
        }
        detectProblemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(descriptionView.snp.trailing).offset(-16)
            make.width.equalTo(154)
            make.height.equalTo(180)
        }
    }
}
