//
//  UIBarButtonItem-Extension.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func setupItem (imageName: String, highlightImageName: String, size: CGSize) -> UIBarButtonItem {
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName) , for: .normal)
        button.setImage(UIImage(named: highlightImageName), for: .highlighted)
        button.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: button)
    }
 */
    
    ///官方推荐使用构造函数
    ///便利构造函数必须以convenience开头
    ///在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highlightImageName: String = "", size: CGSize = CGSize.zero) {
        ///创建button
        let button = UIButton()
        
        ///设置button的图片
        button.setImage(UIImage(named: imageName) , for: .normal)
        
        ///设置button的高亮图片
        if highlightImageName != "" {
            button.setImage(UIImage(named: highlightImageName), for: .highlighted)
        }
        
        ///设置button的尺寸
        if size == CGSize.zero {
            button.sizeToFit()
        }else {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        ///创建UIBarButtonItem
        self.init(customView: button)
    }
}
