//
//  ViewController.swift
//  Skincare-app
//
//  Created by Apple on 05.08.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let testLabel: UILabel = {
        let lb = UILabel()
        lb.text = NSLocalizedString("test", comment: "")
        lb.font = UIFont(name: "Sacramento-Regular", size: 36)
        return lb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(testLabel)
        
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

