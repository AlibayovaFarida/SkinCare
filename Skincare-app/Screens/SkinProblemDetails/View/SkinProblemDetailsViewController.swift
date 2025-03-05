//
//  SkinProblemDetailsViewController.swift
//  Skincare-app
//
//  Created by Apple on 19.09.24.
//

import UIKit

class SkinProblemDetailsViewController: UIViewController {
    private var problemName: String? = ""
    private var problemId: Int? = 0
    private var viewModel: SkinProblemDetailsViewModel!
    private var datas: [SkinProblemDetailsModel.Information] = []
    private var problemDescriptionData: DescriptionModel?
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "customBgBlue")
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 16
        tv.register(MainProblemCardTableViewCell.self, forCellReuseIdentifier: MainProblemCardTableViewCell.identifier)
        tv.register(SkinProblemAccordionTableViewCell.self, forCellReuseIdentifier: SkinProblemAccordionTableViewCell.identifier)
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor(named: "customSearchBlue")
        indicator.hidesWhenStopped = true
        return indicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = problemName
        activityIndicator.startAnimating()
        if let navigationController = navigationController {
            let titleTextAttributes: [NSAttributedString.Key: Any] =
            [
                .foregroundColor: UIColor(named: "customDarkBlue") ?? UIColor.black,
                .font: UIFont(name: "Montserrat-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20)
            ]
            navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        let backButtonImage = UIImage(named: "back-button")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .customDarkBlue
        navigationItem.leftBarButtonItem = backButton
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        setupUI()
        self.viewModel.skinProblemDetails { error in
            self.showAlert(message: error.localizedDescription)
            self.activityIndicator.stopAnimating()
        }
    }
    init(problemName: String, problemId: Int){
        super.init(nibName: nil, bundle: nil)
        self.problemName = problemName
        self.problemId = problemId
        self.viewModel = SkinProblemDetailsViewModel(id: problemId)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func setupUI(){
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        activityIndicator.snp.makeConstraints { make in
                make.center.equalTo(view)
        }
    }
    
    
}
extension SkinProblemDetailsViewController: UITableViewDataSource, UITableViewDelegate, SkinProblemAccordionTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainProblemCardTableViewCell.identifier) as! MainProblemCardTableViewCell
            
            if let descriptionData = problemDescriptionData {
                cell.configure(with: descriptionData)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkinProblemAccordionTableViewCell.identifier) as! SkinProblemAccordionTableViewCell
            cell.configure(datas[indexPath.row-1])
            cell.delegate = self
            return cell
        }
    }
    
    func didTapAccordionButton(in cell: SkinProblemAccordionTableViewCell) {
        guard tableView.indexPath(for: cell) != nil else { return }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SkinProblemDetailsViewController: SkinProblemDetailsDelegate {
    
    func didFetchSkinProblemDetails(data: SkinProblemDetailsModel.SkinProblemDetail) {
        self.problemId = data.id
        self.datas = data.information
        self.problemDescriptionData = .init(id: data.id, imageIds: data.imageIds[0], description: data.detail)
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
}
