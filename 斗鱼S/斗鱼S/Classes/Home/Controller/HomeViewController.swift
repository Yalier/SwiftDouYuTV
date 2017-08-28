//
//  HomeViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/8/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let kTitleH: CGFloat = 40

class HomeViewController: UIViewController
{

    lazy var pageTitleViewL: PageTitleView =
    {[weak self] in
       
        let titleFrame = CGRect.init(x: 0, y: kStatusBarHeight + kNagationBarHeight, width: kScreenWidth, height: kTitleH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
        
        return titleView
        
    }()
    
    
    lazy var pageContenViewL: PageContentView =
    {[weak self] in
        
        
        let contentFrame = CGRect.init(x: 0, y: kStatusBarHeight + kNagationBarHeight + kTitleH, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight - kNagationBarHeight - kTitleH - kTabbarH)
        
        var myChildVcs = [UIViewController]()
        
        //添加推荐子控制器
        myChildVcs.append(RecommendViewController())
        for _ in 0..<3
        {
            
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)) , g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            myChildVcs.append(vc)
            
        }
        
        let contentV = PageContentView.init(frame: contentFrame, childVCS: myChildVcs, parentViewController: self)
        contentV.delegate = self
        
        return contentV
        
    }()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = "首页"
        
        setUpUI()
        
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK:- 设置UI界面
extension HomeViewController
{
    
    func setUpUI()
    {
        //取消ScrollView自动下滑44距离
        automaticallyAdjustsScrollViewInsets = false
        

        //设置导航栏
        setUpNaviBar()
        
        
        //添加titleView
        view.addSubview(pageTitleViewL)
        
        
        //添加contentView
        view.addSubview(pageContenViewL)
        pageContenViewL.backgroundColor = UIColor.cyan
    }
    
    func setUpNaviBar()
    {
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        

        //设置右侧item
        let size = CGSize.init(width: 40, height: 40)
        
       
        let historyItem = UIBarButtonItem.init(imageName: "历史 (1)", highImageName: "历史", size: size)
    
        let searchItem = UIBarButtonItem.init(imageName: "搜索 (1)", highImageName: "搜索", size: size)
        
        let qrcodeItem = UIBarButtonItem.init(imageName: "扫码 (1)", highImageName: "扫码", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
}


//MARK:- 遵守PageTitleView协议
extension HomeViewController: pageTitleViewDelegate
{
    
    func pageTitleView(_ titleView: PageTitleView, selected index: Int) {
        
        pageContenViewL.setCurrIndex(index)
        
    }
    
}

//MARK:- 遵守pageContentView协议
extension HomeViewController: pageContentViewDelegate
{
    
    func pageContentDelegate(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    {
        
        pageTitleViewL.setTitleView(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
}
