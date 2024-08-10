//
//  DropdownButtonView.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import Foundation
import UIKit


class DropdownButtonView: UIView {
    var dataSource: [String] = []
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
    
    private let dropdownLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Medium", size: 13)
        lb.textColor = UIColor(named: "black")
//        lb.text = "Gün"
        return lb
    }()
    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow")
        return iv
    }()
    let tableView: UITableView = {
        let tv = UITableView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor(named: "customGray")?.cgColor
        tv.layer.cornerRadius = 8
        tv.register(DropdownTableViewCell.self, forCellReuseIdentifier: DropdownTableViewCell.identifier)
        return tv
    }()
    
    
    init(dataSource: [String], dropdownTitle: String){
        self.dataSource = dataSource
        self.dropdownLabel.text = dropdownTitle
        super.init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        setupGesture()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(buttonView)
        addSubview(tableView)
        buttonView.addSubview(stackView)
        [
            dropdownLabel,
            arrowImageView
        ].forEach(buttonView.addSubview)
        
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(28)
        }
        
        dropdownLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.bottom).offset(2)
            make.width.equalTo(75)
            make.height.equalTo(150)
        }
        
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleDropdown))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    @objc func toggleDropdown() {
        tableView.layer.zPosition = 1
        tableView.isHidden = !tableView.isHidden
    }
}

extension DropdownButtonView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropdownTableViewCell.identifier, for: indexPath) as! DropdownTableViewCell
        cell.configure(dataSource[indexPath.row])
        return cell
    }
}

extension DropdownButtonView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropdownLabel.text = dataSource[indexPath.row]
        tableView.isHidden = true
    }
}
