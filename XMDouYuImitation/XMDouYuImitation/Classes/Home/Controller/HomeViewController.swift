//
//  HomeViewController.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

//MARK: 设置UI界面
extension HomeViewController {
    private func setupUI() {
        ///设置导航栏
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        ///设置左侧的navigation item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        ///设置右侧的navigation item
        let size = CGSize(width: 40, height: 40)
        
        ///创建历史记录item
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightImageName: "Image_my_history_click", size: size)
        
        ///创建搜索item
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)

        ///创建扫描item
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
