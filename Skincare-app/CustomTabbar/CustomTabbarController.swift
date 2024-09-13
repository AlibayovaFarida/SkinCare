//
//  CustomTabbarController.swift
//  Skincare-app
//
//  Created by Apple on 13.08.24.
//

import UIKit

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate, UIGestureRecognizerDelegate {
    
    private var currentlySelectedItem: UITabBarItem?
    private var lastTappedImageView: UIImageView?
    
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
    
//    private let searchNavVc: UINavigationController = {
//        let vc = UINavigationController(rootViewController: SearchViewController())
//        vc.tabBarItem.image = UIImage(named: "Search")
//        vc.tabBarItem.selectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
//        vc.tabBarItem.title = NSLocalizedString("search", comment: "")
//        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        return vc
//    }()
    
    private let consultationNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: ConsultationViewController())
        vc.tabBarItem.image = UIImage(named: "Consultation")
        vc.tabBarItem.selectedImage = UIImage(named: "ConsultationSelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("consultation", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()
    
    
    private let profileNavVc: UINavigationController = {
        let vc = UINavigationController(rootViewController: ProfileViewController())
        vc.tabBarItem.image = UIImage(named: "Profile")
        vc.tabBarItem.selectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = NSLocalizedString("profile", comment: "")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setViewControllers([homeNavVc, therapyNavVc, consultationNavVc, profileNavVc], animated: true)
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 16)
            addGestures(to: item)
        }
    }
    
    private func addGestures(to item: UITabBarItem) {
        guard let itemView = item.value(forKey: "view") as? UIView else { return }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self
        itemView.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.delegate = self
        itemView.addGestureRecognizer(longPressGesture)
        
        itemView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let itemView = gesture.view else { return }
        
        if let item = tabBar.items?.first(where: { $0.value(forKey: "view") as? UIView == itemView }) {
            self.selectedIndex = tabBar.items?.firstIndex(of: item) ?? 0
            currentlySelectedItem = item
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let itemView = item.value(forKey: "view") as? UIView,
                   let imageView = itemView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                    
                    UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
                        imageView.alpha = 0.8
                        imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    }) { _ in
                        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
                            imageView.alpha = 1.0
                            imageView.transform = CGAffineTransform.identity
                        })
                    }
                }
            }
        }
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let itemView = gesture.view else { return }
        
        if (tabBar.items?.first(where: { $0.value(forKey: "view") as? UIView == itemView })) != nil {
            if gesture.state == .began {
                if let imageView = itemView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0.8
                    }
                }
            }
            else if gesture.state == .ended || gesture.state == .cancelled {
                if let imageView = itemView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 1.0
                    }
                }
            }
        }
    }
}
