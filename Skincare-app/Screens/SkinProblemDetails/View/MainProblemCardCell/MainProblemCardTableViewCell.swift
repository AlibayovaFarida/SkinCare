//
//  MainProblemCardTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 20.09.24.
//

import UIKit
import Alamofire

class MainProblemCardTableViewCell: UITableViewCell {

    private let mainProblemCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accordionCellBgBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    private let mainProblemCardStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 8
        sv.alignment = .top
        sv.axis = .horizontal
        return sv
    }()
    private let problemImageBgView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "customGray")?.cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    private let problemImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    private let problemDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 13)
        lb.textColor = UIColor(named: "customDarkBlue")
        lb.numberOfLines = 0
        lb.setLineHeight(18)
        return lb
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    func configure(with model: DescriptionModel) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {return}
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        NetworkManager.shared.getImage(url: "http://localhost:8080/api/skin-problem/photo/", imageId: model.imageIds, headers: headers) { image in
            self.problemImageView.image = image
        }
        problemDescriptionLabel.text = model.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(mainProblemCardView)
        mainProblemCardView.addSubview(mainProblemCardStackView)
        problemImageBgView.addSubview(problemImageView)
        [
            problemImageBgView,
            problemDescriptionLabel
        ].forEach(mainProblemCardStackView.addArrangedSubview)
        
        mainProblemCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(8)
        }
        mainProblemCardStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        problemImageView.snp.makeConstraints { make in
            make.width.equalTo(99)
            make.height.equalTo(97)
            make.edges.equalToSuperview()
        }
    }
}
