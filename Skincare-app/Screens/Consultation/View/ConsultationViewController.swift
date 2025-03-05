//
//  ConsultationViewController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import SnapKit
import UIKit

class ConsultationViewController: UIViewController {
    private var dermatologistCollectionViewTopConstraintWithFilter: Constraint?
    private var dermatologistCollectionViewTopConstraintWithoutFilter:
        Constraint?
    private var filterItems: [ConsultationFilterItemModel] = [] {
        didSet {
            updateFilteredItems()
            updateConstraints()
            filterCollectionView.reloadData()
        }
    }
    private var items: [DermatologistModel] = [
        .init(
            name: "Stanford", profession: "Dermatologist", rating: 4.2,
            patientCount: 100, price: 20, experience: 5, image: "youngMan"),
        .init(
            name: "Laura", profession: "Dermatologist", rating: 4.9,
            patientCount: 140, price: 18, experience: 3, image: "youngWoman"),
        .init(
            name: "Edwards", profession: "Dermatologist", rating: 4.5,
            patientCount: 230, price: 30, experience: 18, image: "oldMan")
    ]
    private var filteredItems: [DermatologistModel] = []
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(
            UIImage(named: "Search"), for: .search, state: .normal)
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .white

        if let searchTextField = searchBar.value(forKey: "searchField")
            as? UITextField
        {
            searchTextField.backgroundColor = .white
            searchTextField.layer.borderWidth = 1
            searchTextField.layer.borderColor = UIColor.customGray.cgColor
            searchTextField.layer.cornerRadius = 19
            searchTextField.placeholder = NSLocalizedString(
                "searchTextField", comment: "")

            let placeholderColor = UIColor.customGray
            let placeholderFont =
                UIFont(name: "Montserrat-Regular", size: 16)
                ?? UIFont.systemFont(ofSize: 16)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor,
                .font: placeholderFont,
            ]
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: searchTextField.placeholder ?? "",
                attributes: attributes)
        }

        searchBar.layer.backgroundColor = UIColor.white.cgColor
        return searchBar
    }()

    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.tintColor = .black
        button.addTarget(
            nil, action: #selector(didTapPresentFilter), for: .touchUpInside)
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
        return lb
    }()
    @objc
    private func didTapPresentFilter() {
        let vc = ConsultationFilterViewController()
        vc.onApplyFilters = { [weak self] filters in
            self?.filterItems = filters
            self?.filterCountLabel.text =
                filters.count == 0 ? "" : "\(filters.count)"
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
        cv.register(
            FilterItemCollectionViewCell.self,
            forCellWithReuseIdentifier: FilterItemCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    private let dermatologistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private func updateFilteredItems() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilterUpdate(_:)), name: .filterValuesDidUpdate, object: nil)
    }
    @objc
    private func handleFilterUpdate(_ notification: Notification) {
        // Filter by price
        var updatedItems = items

            // Qiymətə görə filterləmə
            if let userInfo = notification.userInfo,
               let minPrice = userInfo["minPrice"] as? Int,
               let maxPrice = userInfo["maxPrice"] as? Int {
                updatedItems = updatedItems.filter { $0.price >= minPrice && $0.price <= maxPrice }
            }

        // Apply selected filter options
        if let selectedFilter = filterItems.first?.title {
            switch selectedFilter {
            case NSLocalizedString("filterChoise1", comment: ""):
                updatedItems.sort { $0.experience > $1.experience }
            case NSLocalizedString("filterChoise2", comment: ""):
                updatedItems.sort { $0.rating > $1.rating }
            case NSLocalizedString("filterChoise3", comment: ""):
                updatedItems.sort { $0.price > $1.price }
            case NSLocalizedString("filterChoise4", comment: ""):
                updatedItems.sort { $0.price < $1.price }
            case NSLocalizedString("filterChoise5", comment: ""):
                updatedItems.sort { $0.patientCount > $1.patientCount }
            default:
                break
            }
        }

        // Reload collection view
        filteredItems = updatedItems
        dermatologistCollectionView.reloadData()
    }

        
    deinit {
        NotificationCenter.default.removeObserver(self, name: .filterValuesDidUpdate, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        searchBar.delegate = self

        filteredItems = items
        setupConstraints()
        setLeftAlignTitleView(
            font: UIFont(name: "Montserrat-SemiBold", size: 20)!,
            text: NSLocalizedString("consultationScreenTitle", comment: ""),
            textColor: .black)

        if let savedFilters = UserDefaults.standard.array(
            forKey: "selectedFilters") as? [String]
        {
            filterItems = savedFilters.map {
                ConsultationFilterItemModel(title: $0)
            }
            filterCountLabel.text =
                filterItems.count == 0 ? "" : "\(filterItems.count)"
        }

        updateConstraints()
    }

    func setLeftAlignTitleView(font: UIFont, text: String, textColor: UIColor) {
        guard let navFrame = navigationController?.navigationBar.frame else {
            return
        }

        let parentView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: navFrame.width * 2, height: navFrame.height))
        self.navigationItem.titleView = parentView

        let label = UILabel(
            frame: .init(
                x: parentView.frame.minX - 8, y: parentView.frame.minY,
                width: parentView.frame.width, height: parentView.frame.height))
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

        dermatologistCollectionView.register(
            ConsultationCollectionViewCell.self,
            forCellWithReuseIdentifier: "ConsultationCollectionViewCell")
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
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(
                -16)
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
            dermatologistCollectionViewTopConstraintWithFilter =
                make.top.equalTo(filterCollectionView.snp.bottom).offset(10)
                .constraint
            dermatologistCollectionViewTopConstraintWithoutFilter =
                make.top.equalTo(searchBar.snp.bottom).offset(10).constraint
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        dermatologistCollectionViewTopConstraintWithFilter?.activate()
        dermatologistCollectionViewTopConstraintWithoutFilter?.deactivate()
    }

    private func updateConstraints() {
        if filterItems.isEmpty {
            dermatologistCollectionViewTopConstraintWithFilter?.deactivate()
            dermatologistCollectionViewTopConstraintWithoutFilter?.activate()
            filterCollectionView.isHidden = true
        } else {
            dermatologistCollectionViewTopConstraintWithFilter?.activate()
            dermatologistCollectionViewTopConstraintWithoutFilter?.deactivate()
            filterCollectionView.isHidden = false
        }
        view.layoutIfNeeded()
    }
}

extension ConsultationViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == dermatologistCollectionView {
            return filteredItems.count
        }
        if collectionView == filterCollectionView {
            return filterItems.count
        }
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == dermatologistCollectionView {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ConsultationCollectionViewCell",
                    for: indexPath) as! ConsultationCollectionViewCell
            if !filteredItems[indexPath.row].isAnimatedDone {
                cell.alpha = 0
                UIView.animate(
                    withDuration: 0.3, delay: 0.3 * Double(indexPath.row),
                    animations: {
                        cell.alpha = 1
                    })
                filteredItems[indexPath.row].isAnimatedDone = true
            }
            cell.configure(filteredItems[indexPath.row])
            return cell
        }
        if collectionView == filterCollectionView {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: FilterItemCollectionViewCell
                        .identifier, for: indexPath)
                as! FilterItemCollectionViewCell
            cell.configure(filterItems[indexPath.row])
            cell.onRemoveFilter = { [weak self] in
                guard let self = self else { return }
                let removedFilter = self.filterItems.remove(at: indexPath.row)
                self.filterCountLabel.text =
                    self.filterItems.count == 0
                    ? "" : "\(self.filterItems.count)"
                if var savedFilters = UserDefaults.standard.array(
                    forKey: "selectedFilters") as? [String]
                {
                    savedFilters.removeAll { $0 == removedFilter.title }
                    UserDefaults.standard.set(
                        savedFilters, forKey: "selectedFilters")
                }

                self.filterCollectionView.reloadData()
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ConsultationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == dermatologistCollectionView {
            return CGSize(width: collectionView.frame.width - 15, height: 213)
        }
        return CGSize()
    }
}

extension ConsultationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            print(searchText, "hello")
            filteredItems = items.filter({ item in
                item.name.lowercased().contains(searchText.lowercased())
            })
        }
        dermatologistCollectionView.reloadData()
    }
}
