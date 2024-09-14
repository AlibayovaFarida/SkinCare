//
//  SkinProblemsTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 13.09.24.
//

import UIKit

protocol SkinProblemsTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class SkinProblemsTableViewCell: UITableViewCell {
    
    weak var delegate: SkinProblemsTableViewCellDelegate?
    
    private var skinProblems: [SkinProblemItemModel] = []
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        return sv
    }()
    private let headerTitle: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Bold", size: 20)
        lb.textColor = UIColor(named: "customDarkBlue")
        lb.text = NSLocalizedString("skinProblems", comment: "")
        return lb
    }()
    private let moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(NSLocalizedString("seeAll", comment: ""), for: .normal)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        btn.titleLabel?.attributedText = underlineAttributedString
        btn.setTitleColor(UIColor(named: "customDarkBlue"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 12)
        return btn
    }()
    private let skinProblemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let screenWidth = UIScreen.main.bounds.width
//        layout.itemSize = .init(width: (screenWidth-64)/2, height: 161)
        layout.itemSize = .init(width: 147, height: 161)
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SkinProblemCollectionViewCell.self, forCellWithReuseIdentifier: SkinProblemCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        skinProblemsCollectionView.dataSource = self
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(headerStackView)
        contentView.addSubview(skinProblemsCollectionView)
        [
            headerTitle,
            moreButton
        ].forEach(headerStackView.addArrangedSubview)
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        skinProblemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(161)
        }
    }
    
    func configure(_ item: [SkinProblemItemModel]){
        skinProblems = item
    }
    
    @objc private func moreButtonTapped() {
           delegate?.didTapMoreButton()
        print("More button tapped")
       }
}

extension SkinProblemsTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skinProblems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkinProblemCollectionViewCell.identifier, for: indexPath) as! SkinProblemCollectionViewCell
        cell.configure(skinProblems[indexPath.row])
        return cell
    }
}
