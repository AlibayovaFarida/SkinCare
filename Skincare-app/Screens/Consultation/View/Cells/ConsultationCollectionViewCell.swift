//
//  ConsultationCollectionViewCell.swift
//  Skincare-app
//
//  Created by Umman on 20.08.24.
//

import UIKit
import SnapKit
import Alamofire

class ConsultationCollectionViewCell: UICollectionViewCell {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .glass
        stackView.layer.cornerRadius = 16
        stackView.spacing = 100
        return stackView
    }()
    
    private let priceLabel1: UILabel = {
        let label = UILabel()
        label.text = "$"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let priceLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Medium", size: 20)
        return label
    }()
    
    private let priceLabel3: UILabel = {
        let label = UILabel()
        label.text = "per hour"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Light", size: 12)
        return label
    }()
    
    private let experienceLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Medium", size: 20)
        return label
    }()
    
    private let experienceLabel2: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        return label
    }()
    
    private let experienceLabel3: UILabel = {
        let label = UILabel()
        label.text = "illik təcrübə"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Light", size: 12)
        return label
    }()
    
    private let nameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        return label
    }()
    
    private let positionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    private lazy var namePositionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var experienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .customBlueHomeButton
        return stackView
    }()
    
    private let bottomLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "Söhbət başlat"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        return label
    }()
    
    private let bottomRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "redirection")
        return imageView
    }()
    
    private let ratingCircleView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.customGray.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 22.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let reviewCountOvalView: UIView = {
        let view = UIView()
        view.backgroundColor = .patientBlue
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "100+"
        label.font = UIFont(name: "Montserrat-Regular", size: 8)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBottomStackViewTap))
        bottomStackView.addGestureRecognizer(tapGesture)
        bottomStackView.isUserInteractionEnabled = true
    }

    @objc private func handleBottomStackViewTap() {
        if let viewController = findViewController() {
            let nextViewController = ChatViewController()
            viewController.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomStackView.layoutIfNeeded()
        bottomStackView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .consultationCell
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        contentView.addSubview(namePositionStackView)
        
        contentView.addSubview(ratingCircleView)
        contentView.addSubview(reviewCountOvalView)
        
        ratingCircleView.addSubview(ratingLabel)
        ratingCircleView.addSubview(starImageView)
        reviewCountOvalView.addSubview(reviewCountLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        [priceLabel1,priceLabel2,priceLabel3].forEach(priceStackView.addArrangedSubview)
        [experienceLabel1,experienceLabel2,experienceLabel3].forEach(experienceStackView.addArrangedSubview)
        [nameTitle, positionTitle].forEach(namePositionStackView.addArrangedSubview)
        
        topStackView.addSubview(priceStackView)
        topStackView.addSubview(experienceStackView)
        
        bottomStackView.addArrangedSubview(bottomLeftLabel)
        bottomStackView.addArrangedSubview(bottomRightImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(9)
            make.trailing.equalTo(contentView).inset(54)
            make.bottom.equalTo(bottomStackView.snp.top)
            make.height.equalTo(173)
            make.width.equalTo(150)
        }
        
        namePositionStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(16)
            make.leading.equalTo(contentView).inset(16)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).inset(116)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(49)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(topStackView.snp.leading).inset(16)
            make.centerY.equalTo(topStackView.snp.centerY)
        }
        
        priceLabel1.transform = CGAffineTransform(translationX: 0, y: -2)
        
        experienceStackView.snp.makeConstraints { make in
            make.trailing.equalTo(topStackView.snp.trailing).inset(16)
            make.centerY.equalTo(topStackView.snp.centerY)
        }
        
        experienceLabel2.transform = CGAffineTransform(translationX: 0, y: -4)
        
        bottomStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(40)
        }
        
        bottomLeftLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView).inset(8)
        }
        
        bottomRightImageView.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(24)
            make.trailing.equalTo(contentView).inset(12)
            make.bottom.top.equalTo(bottomStackView).inset(8)
        }
        
        ratingCircleView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.trailing.equalTo(contentView).inset(14)
            make.width.height.equalTo(45)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingCircleView)
            make.leading.equalTo(ratingCircleView).inset(8)
        }
        
        starImageView.snp.makeConstraints { make in
            make.centerY.equalTo(ratingCircleView)
            make.leading.equalTo(ratingLabel.snp.trailing)
            make.width.height.equalTo(8)
        }
        
        starImageView.transform = CGAffineTransform(translationX: 0, y: -4)
        
        reviewCountOvalView.snp.makeConstraints { make in
            make.top.equalTo(ratingCircleView.snp.bottom).offset(-12)
            make.centerX.equalTo(ratingCircleView)
            make.height.equalTo(14)
            make.width.equalTo(27)
        }
        
        reviewCountLabel.snp.makeConstraints { make in
            make.edges.equalTo(reviewCountOvalView).inset(4)
        }
    }
    
    func configure(_ item: DermatologistModel.Dermatologist) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {return}
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        NetworkManager.shared.getImage(url: "http://localhost:8080/api/consultation/photo/", imageId: item.imageIds[0], headers: headers) { image in
            self.backgroundImageView.image = image
        }
        nameTitle.text = "Dr. \(item.name)"
        positionTitle.text = item.speciality
        ratingLabel.text = "\(item.rating)"
        reviewCountLabel.text = "\(item.review)"
        priceLabel2.text = "\(item.perHourPrice)"
        experienceLabel1.text = "\(item.experience)"
    }
}


