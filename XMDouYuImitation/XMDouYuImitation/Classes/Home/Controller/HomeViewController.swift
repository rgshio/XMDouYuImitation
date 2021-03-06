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
    private lazy var pageTitleView: XMPageTitleView = {[weak self] in
        let titleViewFrame = CGRect(x: 0, y: kStatusBarHeight+kNavigationBarHeight, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = XMPageTitleView(frame: titleViewFrame, titles: titles)
        
        titleView.delegate = self;
        
        return titleView
    }()
    
    private lazy var pageContentView: XMPageContentView = {[weak self] in
        ///设置frame
        let contentViewHeight = kScreenHeight-kStatusBarHeight-kNavigationBarHeight-kTitleViewHeight
        let contentViewFrame = CGRect(x: 0, y: kStatusBarHeight+kNavigationBarHeight+kTitleViewHeight, width: kScreenWidth, height: contentViewHeight)
        
        ///设置所有的子控制器
        var childViewControllers = [UIViewController]()
        for _ in 0..<4 {
            let viewController = UIViewController()
            if childViewControllers.count%2 == 0 {
                viewController.view.backgroundColor = UIColor.red
            }else {
                viewController.view.backgroundColor = UIColor.green
            }
            childViewControllers.append(viewController)
        }
        
        let contentView = XMPageContentView(frame: contentViewFrame, childViewControllers: childViewControllers, parentViewController: self!)
        
        return contentView
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
        
        ///添加contentView
        view.addSubview(pageContentView)
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

//MARK: 遵守XMPageTitleViewDelegate协议
extension HomeViewController: XMPageTitleViewDelegate {
    func pageTitleView(titleView: XMPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
