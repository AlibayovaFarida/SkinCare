//
//  PopularProblemsTableViewCell.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

import UIKit

class PopularProblemsTableViewCell: UITableViewCell {
    private var problemsList: [PopularProblemsItemModel] = []
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customMediumBlue")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Bold", size: 20)
        lb.textColor = UIColor(named: "black")
        lb.text = NSLocalizedString("popularProblemsTitle", comment: "")
        return lb
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = .init(width: (screenWidth - 38), height: 100)
        layout.sectionInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        cv.showsVerticalScrollIndicator = false
        cv.register(PopularProblemsCollectionViewCell.self, forCellWithReuseIdentifier: PopularProblemsCollectionViewCell.identifier)
        cv.isScrollEnabled = false
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(collectionView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().inset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
    }
}

extension PopularProblemsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return problemsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularProblemsCollectionViewCell.identifier, for: indexPath) as! PopularProblemsCollectionViewCell
        cell.configure(problemsList[indexPath.row])
        return cell
    }
    
    func configure(_ item: [PopularProblemsItemModel]){
        problemsList = item
        collectionView.reloadData()
        adjustCollectionViewHeight()
    }
    
    private func adjustCollectionViewHeight() {
        let numberOfRows = ceil(Double(problemsList.count))
        let height = numberOfRows * 100 + ((numberOfRows + 1) * 8)
        collectionView.snp.updateConstraints { make in
                make.height.equalTo(height)
        }
    }
}

extension PopularProblemsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth - 38
        return CGSize(width: width, height: 100)
    }
}
