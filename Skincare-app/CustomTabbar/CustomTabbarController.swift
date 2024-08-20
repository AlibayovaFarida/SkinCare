//
//  CustomTabbarController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    private let homeNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: HomeViewController())
        vc.tabBarItem.image = UIImage(named: "Home")
        vc.tabBarItem.selectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("home", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    private let therapyNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: TherapyViewController())
        vc.tabBarItem.image = UIImage(named: "Therapy")
        vc.tabBarItem.selectedImage = UIImage(named: "TherapySelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("therapy", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    private let searchNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: SearchViewController())
        vc.tabBarItem.image = UIImage(named: "Search")
        vc.tabBarItem.selectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("search", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    private let consultationNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: ConsultationViewController())
        vc.tabBarItem.image = UIImage(named: "Consultation")
        vc.tabBarItem.selectedImage = UIImage(named: "ConsultationSelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("consultation", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([homeNavVc, therapyNavVc,searchNavVc,consultationNavVc], animated: true)
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 16)
        }
    }
}
