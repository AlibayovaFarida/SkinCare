//
//  InfoViewController.swift
//  Skincare-app
//
//  Created by Umman on 15.09.24.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dəri tipləri"
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Məsamələr"
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private func squareView(with image: UIImage, title: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 20
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(containerView).inset(16)
            make.width.equalTo(77)
            make.height.equalTo(71)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.equalTo(containerView).inset(8)
            make.leading.trailing.equalTo(containerView).inset(15)
        }
        
        return containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .infoBlue
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(subtitleLabel)
        view.addSubview(stackViewTwo)
        
        let image1 = UIImage(named: "Yağlı")
        let image2 = UIImage(named: "Normal")
        let image3 = UIImage(named: "Quru")
        let image4 = UIImage(named: "Çox məsaməli")
        let image5 = UIImage(named: "Az məsaməli")
        let image6 = UIImage(named: "Məsaməsiz")
        
        let titles1 = ["Yağlı", "Normal", "Quru"]
        let titles2 = ["Çox məsaməli", "Az məsaməli", "Məsaməsiz"]
        
        let images1 = [image1, image2, image3]
        let images2 = [image4, image5, image6]
        
        for (index, image) in images1.enumerated() {
            if let image = image {
                let title = titles1[index]
                stackView.addArrangedSubview(squareView(with: image, title: title))
            }
        }
        
        for (index, image) in images2.enumerated() {
            if let image = image {
                let title = titles2[index]
                stackViewTwo.addArrangedSubview(squareView(with: image, title: title))
            }
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(40)
            make.leading.equalTo(view).inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).inset(20)
            make.trailing.equalTo(view).inset(20)
            make.height.equalTo(124)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.leading.equalTo(view).inset(20)
        }
        
        stackViewTwo.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).inset(20)
            make.trailing.equalTo(view).inset(20)
            make.height.equalTo(145)
        }
    }
}

#Preview { return InfoViewController()}
