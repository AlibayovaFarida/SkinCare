//
//  ConsultationFilterViewController.swift
//  Skincare-app
//
//  Created by Apple on 22.08.24.
//

import UIKit


class ConsultationFilterViewController: UIViewController {
    var onApplyFilters: (([ConsultationFilterItemModel]) -> Void)?
    private var filterList: [ConsultationFilterItemModel] = [
        .init(title: NSLocalizedString("filterChoise1", comment: "")),
        .init(title: NSLocalizedString("filterChoise2", comment: "")),
        .init(title: NSLocalizedString("filterChoise3", comment: "")),
        .init(title: NSLocalizedString("filterChoise4", comment: "")),
        .init(title: NSLocalizedString("filterChoise5", comment: ""))
    ]{
        didSet{
            filterCollectionView.reloadData()
        }
    }
    private var selectedFilter: [ConsultationFilterItemModel] = []{
        didSet{
            filterCollectionView.reloadData()
        }
    }
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    private let contentViewInScroll: UIView = {
        let view = UIView()
        return view
    }()
    private let generalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 35
        return sv
    }()
    private let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    private let headerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Bold", size: 24)
        lb.textColor = .black
        lb.text = "Filter"
        return lb
    }()
    private let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.isEnabled = true
        btn.addTarget(nil, action: #selector(didTapCloseFilterView), for: .touchUpInside)
        return btn
    }()
    @objc
    private func didTapCloseFilterView(){
        dismiss(animated: true)
    }
    private let filterStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    private let filterTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "DMSans-Regular", size: 16)
        lb.textColor = .black
        lb.text = NSLocalizedString("filterTitle", comment: "")
        return lb
    }()
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = .init(width: (screenWidth - 42) / 3, height: 37)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ConsultationFilterCollectionViewCell.self, forCellWithReuseIdentifier: ConsultationFilterCollectionViewCell.identifier)
        return cv
    }()
    private let priceRangeStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    private let priceRangeTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "DMSans-Regular", size: 16)
        lb.text = NSLocalizedString("filterPriceTitle", comment: "")
        lb.textColor = .black
        return lb
    }()
    private let priceInputsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        return sv
    }()
    private let minPriceInputView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    private let minPriceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("price1", comment: "")
        tf.font = UIFont(name: "DMSans-Regular", size: 14)
        tf.keyboardType = .decimalPad
        return tf
    }()
    private let maxPriceInputView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    private let maxPriceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("price2", comment: "")
        tf.font = UIFont(name: "DMSans-Regular", size: 14)
        tf.keyboardType = .decimalPad
        return tf
    }()
    private let applyFilterButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(named: "customLightGreen")
        btn.layer.cornerRadius = 16
        btn.setTitle(NSLocalizedString("filterButton", comment: ""), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        btn.addTarget(nil, action: #selector(applyFilters), for: .touchUpInside)
        return btn
    }()
    @objc
    private func applyFilters() {
        let selectedFilterTitles = selectedFilter.map { $0.title }
        UserDefaults.standard.set(selectedFilterTitles, forKey: "selectedFilters")
        onApplyFilters?(selectedFilter)
        if let minPrice = minPriceTextField.text, !minPrice.isEmpty,
               let maxPrice = maxPriceTextField.text, !maxPrice.isEmpty {
                UserDefaults.standard.set(minPrice, forKey: "minPrice")
                UserDefaults.standard.set(maxPrice, forKey: "maxPrice")
                
                let userInfo: [String: Any] = [
                    "minPrice": Int(minPrice) ??  Int(UserDefaults.standard.integer(forKey: "minPrice")),
                    "maxPrice": Int(maxPrice) ?? Int(UserDefaults.standard.integer(forKey: "maxPrice")),
                ]
                NotificationCenter.default.post(name: .filterValuesDidUpdate, object: nil, userInfo: userInfo)
            }
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutIfNeeded()
        view.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        
        if let savedFilters = UserDefaults.standard.array(forKey: "selectedFilters") as? [String] {
            for (index, var item) in filterList.enumerated() {
                if savedFilters.contains(item.title) {
                    item.isSelected = true
                    selectedFilter.append(item)
                    filterList[index] = item
                }
            }
        }
        
        setupUI()
        adjustCollectionViewHeight()
    }
    private func adjustCollectionViewHeight() {
        let numberOfRows = ceil(Double(filterList.count) / 3.0)
        let height = numberOfRows * 37 + (numberOfRows * 8)
        filterCollectionView.snp.updateConstraints { make in
                make.height.equalTo(height)
        }
    }
    private func setupUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(generalStackView)
        [
            headerStackView,
            filterStackView,
            priceRangeStackView,
            applyFilterButton
        ].forEach(generalStackView.addArrangedSubview)
        [
            headerTitleLabel,
            closeButton
        ].forEach(headerStackView.addArrangedSubview)
        [
            filterTitleLabel,
            filterCollectionView
        ].forEach(filterStackView.addArrangedSubview)
        [
            priceRangeTitleLabel,
            priceInputsStackView
        ].forEach(priceRangeStackView.addArrangedSubview)
        [
            minPriceInputView,
            maxPriceInputView
        ].forEach(priceInputsStackView.addArrangedSubview)
        minPriceInputView.addSubview(minPriceTextField)
        maxPriceInputView.addSubview(maxPriceTextField)
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentViewInScroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(generalStackView.snp.top).offset(24)
            make.bottom.equalTo(generalStackView.snp.bottom).offset(24)
        }
        generalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(24)
        }
        applyFilterButton.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            make.height.equalTo(50)
            make.width.equalTo(screenWidth - 48)
        }
        filterCollectionView.snp.makeConstraints { make in
            make.height.equalTo(82)
        }
        minPriceInputView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            make.width.equalTo((screenWidth-60)/2)
            make.height.equalTo(45)
        }
        maxPriceInputView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            make.width.equalTo((screenWidth-60)/2)
            make.height.equalTo(45)
        }
        minPriceTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(12.5)
        }
        maxPriceTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(12.5)
        }
    }
}
extension ConsultationFilterViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConsultationFilterCollectionViewCell.identifier, for: indexPath) as! ConsultationFilterCollectionViewCell
        cell.configure(filterList[indexPath.row])
        return cell
    }
}

extension ConsultationFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        for index in filterList.indices {
            filterList[index].isSelected = false
        }

        filterList[indexPath.row].isSelected = true

        selectedFilter.removeAll()
        selectedFilter.append(filterList[indexPath.row])

        collectionView.reloadData()
    }
}

extension ConsultationFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - 42) / 3
        return CGSize(width: width, height: 37)
    }
}
