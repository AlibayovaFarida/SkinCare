//
//  ProfileViewController.swift
//  Skincare-app
//
//  Created by Apple on 09.09.24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    private var viewModel: ProfileViewModel!
    private var profileData: ProfileModel.Profile = .init(name: "", surname: "", email: "")
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let cellTexts: [String] = [
        "Profili redaktə et", "Bildirişlər", "Kömək", "Language", "Privacy Policy", "Report", "Çıxış"
    ]
    
    private let cellImages: [String] = [
        "ProfileBlack", "Bell", "Help", "Language", "Policy",
        "Report", "LogOut"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel()
        viewModel.delegate = self
        viewModel.profile { error in
            self.showAlert(message: error.localizedDescription)
        }
        configureViewController()
        setupTableView()
    }
    
    private func configureViewController() {
        view.backgroundColor = UIColor(named: "customWhite")
        title = "Profil"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "customWhite")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "customCell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    
    private func createHeaderView(for section: Int) -> UIView {
        let headerView = UIView()
        
        switch section {
        case 0:
            setupTallHeaderView(headerView)
            
            headerView.customSeperatorView(isFirstInSection: true, section: section)
            
        case 1, 2, 3:
            setupNormalHeaderView(headerView, for: section)
            
        default:
            break
        }
        
        return headerView
    }
    
    private func setupTallHeaderView(_ headerView: UIView) {
        headerView.backgroundColor = UIColor(named: "customWhite")
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 37
        imageView.clipsToBounds = true
        headerView.addSubview(imageView)
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        nameLabel.textColor = .black
        headerView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(24)
            make.top.equalTo(headerView.snp.top)
            make.width.height.equalTo(74)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.centerY.equalTo(imageView.snp.centerY)
            make.trailing.equalTo(headerView.snp.trailing).offset(-16)
        }
        nameLabel.text = "\(String(describing: profileData.name)) \(String(describing: profileData.surname))"
    }
    
    private func setupNormalHeaderView(_ headerView: UIView, for section: Int) {
        let label = UILabel()
        label.text = section == 1 ? "Ümumi" : (section == 2 ? "Legal" : "Personal")
        label.font = UIFont(name: "DMSans-Regular", size: 14)
        label.textColor = .headerGray
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(20)
            make.centerY.equalTo(headerView.snp.centerY)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 4
        case 2:
            return 1
        case 3:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ProfileTableViewCell
        
        let text: String
        let imageName: String
        
        switch indexPath.section {
        case 0:
            text = ""
            imageName = ""
        case 1:
            text = cellTexts[indexPath.row]
            imageName = cellImages[indexPath.row]
        case 2:
            text = cellTexts[4]
            imageName = cellImages[4]
        case 3:
            text = cellTexts[5 + indexPath.row]
            imageName = cellImages[5 + indexPath.row]
        default:
            text = ""
            imageName = ""
        }
        
        cell.customLabel.text = text
        cell.customLabel.font = UIFont(name: "DMSans-Regular", size: 16)
        cell.customLabel.textColor = .black
        cell.customImageView.image = UIImage(named: imageName)
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 110 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(for: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.viewWithTag(1001)?.removeFromSuperview()
        
        let isFirstInSection = indexPath.row == 0
        cell.contentView.customSeperatorView(isFirstInSection: isFirstInSection, section: indexPath.section)
    }
}

extension ProfileViewController: ProfileDelegate {
    func didFetchProfile(data: ProfileModel.Profile) {
        print(data, "hello data")
        
        self.profileData = data
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
}
