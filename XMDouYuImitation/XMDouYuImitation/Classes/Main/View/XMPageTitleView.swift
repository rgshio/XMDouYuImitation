//
//  XMPageTitleView.swift
//  XMDouYuImitation
//
//  Created by rgshio on 2018/3/8.
//  Copyright © 2018年 rgshio. All rights reserved.
//

import UIKit

protocol XMPageTitleViewDelegate: class {
    func pageTitleView(titleView: XMPageTitleView, selectedIndex index: Int)
}

let kScrollLineHeight: CGFloat = 2

class XMPageTitleView: UIView {
    
    //MARK: 定义属性
    private var labelIndex: Int = 0
    private var titles: [String]
    weak var delegate: XMPageTitleViewDelegate?
    
    //MARK: 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()

    //MARK: 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        ///设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }

}

//MARK: 设置UI界面
extension XMPageTitleView {
    private func setupUI() {
        ///添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        ///添加title对应的label
        setupTitleLabels()
        
        ///设置scrollview底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        ///label确定的一些值可以提到for循环外面
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineHeight
        let labelY: CGFloat = 0

        for (index, title) in titles.enumerated() {
            ///创建UILabel
            let label = UILabel()
            
            ///设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            ///设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            ///将label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            ///label添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        ///添加bottomLine
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        ///添加scrollLine
        ///获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineHeight, width: firstLabel.frame.width, height: kScrollLineHeight)
    }
}

//MARK: 监听label的点击
extension XMPageTitleView {
    @objc private func titleLabelClick(tap: UITapGestureRecognizer) {
        ///获取当前label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        ///获取之前被选中的label
        let selectLabel = titleLabels[labelIndex]
        
        ///切换文字的颜色
        currentLabel.textColor = UIColor.orange
        selectLabel.textColor = UIColor.darkGray
        
        ///保存最新label的下标值
        labelIndex = currentLabel.tag
        
        ///scrollLine跟随变化
        let scrollLineX = CGFloat(labelIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        ///通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: labelIndex)
        
    }
}
