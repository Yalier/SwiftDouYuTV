//
//  PageTitleView.swift
//  斗鱼S
//
//  Created by trident on 2017/8/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

protocol pageTitleViewDelegate: class
{
    
    func pageTitleView(_ titleView:PageTitleView, selected index:Int)
    
}


let kScrollLineH: CGFloat = 2
let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView
{

    var delegate:pageTitleViewDelegate?
    
    var oldIndex: Int = 0
    var myTitles: [String]
    lazy var labels: [UILabel] = [UILabel]()
    
    lazy var myScrollView: UIScrollView = {
    
        let scrollV = UIScrollView()
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.scrollsToTop = false
        scrollV.bounces = false
        
        return scrollV
    }()
    
    
    lazy var scrollLine: UIView = {
        
        let scrollL = UIView()
        scrollL.backgroundColor = UIColor.init(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        return scrollL
        
    }()
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String])
    {
        
        self.myTitles = titles
        
        super.init(frame: frame)
        
        stepUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK:- 设置UI控件
extension PageTitleView
{
    func stepUI()
    {
        
        addSubview(myScrollView)
        myScrollView.frame = bounds
        
        
        addTitlesLabel()
        
        addBottomLineAndScrollLine()
        
    }
    
    
    func addBottomLineAndScrollLine()
    {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let BottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y: frame.height-BottomLineH, width: frame.width, height: BottomLineH)
        
        addSubview(bottomLine)
        
        
        
        myScrollView.addSubview(scrollLine)
        
        //验证是否存在
        guard let scrollL = labels.first else
        {
            return
        }
        
        scrollL.textColor = UIColor.init(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        scrollLine.frame = CGRect.init(x: scrollL.frame.origin.x, y: frame.height-kScrollLineH, width: scrollL.frame.width, height: kScrollLineH)
        
        
    }
    
    
    
    
    func addTitlesLabel()
    {
        
        let labelW: CGFloat = frame.width / CGFloat(myTitles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in myTitles.enumerated()
        {
            
            let myLabel = UILabel()
            myLabel.text = title
            myLabel.tag = index
            myLabel.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            myLabel.font = UIFont.systemFont(ofSize: 16.0)
            myLabel.textAlignment = NSTextAlignment.center
            
            
            let labelX: CGFloat = labelW * CGFloat(index)
           
            myLabel.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            myScrollView.addSubview(myLabel)
            
            labels.append(myLabel)
            
            
            //给label添加手势
            myLabel.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleClicked(_:)))
            myLabel.addGestureRecognizer(tapGes)
            
        }
        
    }
    
}


//MARK:- 监听label点击
extension PageTitleView
{
    
    @objc func titleClicked(_ tapGes:UITapGestureRecognizer)
    {
        
        guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = labels[oldIndex]
        
        currentLabel.textColor = UIColor.init(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        oldIndex = currentLabel.tag
        
        
        UIView.animate(withDuration: 0.2)
        {
            
            self.scrollLine.frame = CGRect.init(x: currentLabel.frame.origin.x, y: self.frame.height - kScrollLineH, width: currentLabel.frame.width, height: kScrollLineH)
            
        }
        
        //通知代理做事情
        delegate?.pageTitleView(self, selected: currentLabel.tag)
        
    }
    
}


// 对外暴露的方法
extension PageTitleView
{
    
    func setTitleView(_ progress:CGFloat, sourceIndex:Int, targetIndex:Int)
    {
    
        oldIndex = targetIndex
        
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor.init(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor.init(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
    }
    
    
}



