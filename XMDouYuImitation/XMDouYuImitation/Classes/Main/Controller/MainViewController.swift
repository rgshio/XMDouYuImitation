//
//  MainViewController.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyname: "Home")
        addChildVC(storyname: "Live")
        addChildVC(storyname: "Follow")
        addChildVC(storyname: "Profile")
        
    }
    
    private func addChildVC(storyname: String) {
        ///通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyname, bundle: nil).instantiateInitialViewController()!
        
        ///将childVC作为子控制器
        addChildViewController(childVC)
    }

}
