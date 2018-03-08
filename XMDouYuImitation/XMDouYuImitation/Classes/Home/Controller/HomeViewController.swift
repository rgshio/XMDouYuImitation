//
//  HomeViewController.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {
    //MARK: 懒加载属性
    private lazy var pageTitleView : XMPageTitleView = {
        let titleViewFrame = CGRect(x: 0, y: kStatusBarHeight+kNavigationBarHeight, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = XMPageTitleView(frame: titleViewFrame, titles: titles)
        
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

//MARK: 设置UI界面
extension HomeViewController {
    private func setupUI() {
        ///不需要设置scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        ///设置导航栏
        setNavigationBar()
        
        ///添加titleView
        view.addSubview(pageTitleView)
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
