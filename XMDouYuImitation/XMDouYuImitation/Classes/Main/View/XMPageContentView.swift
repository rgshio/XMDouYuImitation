//
//  XMPageContentView.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

class XMPageContentView: UIView {

    //MARK: 自定义属性
    private var childViewControllers: [UIViewController]
    private weak var parentViewController: UIViewController?
    
    //MARK: 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
        ///创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        ///创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        return collectionView
    }()
    
    //MARK: 自定义构造函数
    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        ///设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }

}

//MARK: 设置UI界面
extension XMPageContentView {
    private func setupUI() {
        ///将所有的子控制器添加到父控制器中
        for childViewController in childViewControllers {
         parentViewController?.addChildViewController(childViewController)
        }
        
        ///添加UICollectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: 遵守UICollectionViewDataSource
extension XMPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        ///移除cell中的view
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        cell.contentView.backgroundColor = UIColor.red
        ///设置内容
        let childViewController = childViewControllers[indexPath.item]
        childViewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childViewController.view)
        
        return cell
    }
}

//MARK: 对外暴漏的方法
extension XMPageContentView {
    func setCurrentIndex(currentIndex: Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
