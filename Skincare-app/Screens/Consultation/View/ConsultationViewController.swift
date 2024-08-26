//
//  ConsultationViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit
import SnapKit

class ConsultationViewController: UIViewController {
    private var dermatologistCollectionViewTopConstraintWithFilter: Constraint?
        private var dermatologistCollectionViewTopConstraintWithoutFilter: Constraint?
        
        private var filterItems: [ConsultationFilterItemModel] = [] {
            didSet {
                updateConstraints()
                filterCollectionView.reloadData()
            }
        }
    private var items: [DermatologistModel] = [
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Laura", profession: "Dermatologist", rating: 4.9, patientCount: 140, price: 18, experience: 3, image: "youngWoman"),
        .init(name: "Edwards", profession: "Dermatologist", rating: 4.5, patientCount: 230, price: 30, experience: 18, image: "oldMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(name: "Stanford", profession: "Dermatologist", rating: 4.2, patientCount: 100, price: 20, experience: 5, image: "youngMan"),]
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "Search"), for: .search, state: .normal)
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .white
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = .white
            searchTextField.layer.borderWidth = 1
            searchTextField.layer.borderColor = UIColor.customGray.cgColor
            searchTextField.layer.cornerRadius = 19
            searchTextField.placeholder = NSLocalizedString("searchTextField", comment: "")
            
            let placeholderColor = UIColor.customGray
            let placeholderFont = UIFont(name: "Montserrat-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor,
                    .font: placeholderFont
            ]
            searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder ?? "", attributes: attributes)
        }
        
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        return searchBar
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapPresentFilter), for: .touchUpInside)
        return button
    }()
    private let filterCountView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customLightGreen")
        view.layer.cornerRadius = 4.5
        return view
    }()
    private let filterCountLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Montserrat-Regular", size: 10)
        lb.textColor = .black
//        lb.text = "15"
        return lb
    }()
    @objc
    private func didTapPresentFilter(){
        let vc = ConsultationFilterViewController()
        vc.onApplyFilters = { [weak self] filters in
            self?.filterItems = filters
            self?.filterCountLabel.text = filters.count == 0 ? "" : "\(filters.count)"
            self?.filterCollectionView.reloadData()
        }
        vc.sheetPresentationController?.detents = [.medium()]
        present(vc, animated: true)
    }
    
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 8, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = .init(width: 124, height: 26)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterItemCollectionViewCell.self, forCellWithReuseIdentifier: FilterItemCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let dermatologistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setLeftAlignTitleView(font: UIFont(name: "Montserrat-SemiBold", size: 20)!, text: NSLocalizedString("consultationScreenTitle", comment: ""), textColor: .black)
        updateConstraints()
    }
    
    func setLeftAlignTitleView(font: UIFont, text: String, textColor: UIColor) {
        guard let navFrame = navigationController?.navigationBar.frame else{
            return
        }
        
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: navFrame.width*2, height: navFrame.height))
        self.navigationItem.titleView = parentView
        
        let label = UILabel(frame: .init(x: parentView.frame.minX-8, y: parentView.frame.minY, width: parentView.frame.width, height: parentView.frame.height))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = font
        label.textAlignment = .left
        label.textColor = textColor
        label.text = text
        parentView.addSubview(label)
    }

    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(sortButton)
        view.addSubview(filterCountView)
        filterCountView.addSubview(filterCountLabel)
        view.addSubview(filterCollectionView)
        view.addSubview(dermatologistCollectionView)
        
        dermatologistCollectionView.register(ConsultationCollectionViewCell.self, forCellWithReuseIdentifier: "ConsultationCollectionViewCell")
        dermatologistCollectionView.dataSource = self
        dermatologistCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    private func setupConstraints() {
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
                make.leading.equalTo(view).offset(4.5)
                make.trailing.equalTo(sortButton.snp.leading).offset(-12)
                make.height.equalTo(36)
            }
            
            sortButton.snp.makeConstraints { make in
                make.centerY.equalTo(searchBar.snp.centerY)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
                make.width.height.equalTo(24)
            }
            
            filterCountView.snp.makeConstraints { make in
                make.bottom.equalTo(sortButton.snp.bottom).offset(-13.5)
                make.leading.equalTo(sortButton.snp.trailing).offset(-7)
            }
            
            filterCountLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(2)
                make.top.bottom.equalToSuperview().inset(1)
            }
            
            filterCollectionView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(4)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(34)
            }
            
            dermatologistCollectionView.snp.makeConstraints { make in
                // İki fərqli constraint yaradılır
                dermatologistCollectionViewTopConstraintWithFilter = make.top.equalTo(filterCollectionView.snp.bottom).offset(10).constraint
                dermatologistCollectionViewTopConstraintWithoutFilter = make.top.equalTo(searchBar.snp.bottom).offset(10).constraint
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            
            // Əvvəlcə filter ilə olan constraint aktivdir, filterItems boşdursa dəyişdiriləcək
            dermatologistCollectionViewTopConstraintWithFilter?.activate()
            dermatologistCollectionViewTopConstraintWithoutFilter?.deactivate()
        }
        
        private func updateConstraints() {
            if filterItems.isEmpty {
                // Əgər filterItems boşdursa, searchBar-a bağlanan constraint aktiv edilir
                dermatologistCollectionViewTopConstraintWithFilter?.deactivate()
                dermatologistCollectionViewTopConstraintWithoutFilter?.activate()
                filterCollectionView.isHidden = true
            } else {
                // Əks halda, filterCollectionView-un altına bağlanan constraint aktiv edilir
                dermatologistCollectionViewTopConstraintWithFilter?.activate()
                dermatologistCollectionViewTopConstraintWithoutFilter?.deactivate()
                filterCollectionView.isHidden = false
            }
            view.layoutIfNeeded()
        }
}

extension ConsultationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dermatologistCollectionView {
            return items.count
        }
        if collectionView == filterCollectionView {
            return filterItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dermatologistCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConsultationCollectionViewCell", for: indexPath) as! ConsultationCollectionViewCell
            if !items[indexPath.row].isAnimatedDone {
                cell.alpha = 0
                UIView.animate(withDuration: 0.3, delay: 0.3*Double(indexPath.row),animations: {
                    cell.alpha = 1
                })
                items[indexPath.row].isAnimatedDone = true
            }
            cell.configure(items[indexPath.row])
            return cell
        }
        if collectionView == filterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionViewCell.identifier, for: indexPath) as! FilterItemCollectionViewCell
            cell.configure(filterItems[indexPath.row])
            cell.onRemoveFilter = {
                self.filterItems.remove(at: indexPath.row)
                self.filterCountLabel.text = self.filterItems.count == 0 ? "" : "\(self.filterItems.count)"
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ConsultationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dermatologistCollectionView {
            return CGSize(width: collectionView.frame.width - 15, height: 213)
        }
        return CGSize()
    }
}
