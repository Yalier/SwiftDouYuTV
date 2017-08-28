//
//  PageContentView.swift
//  斗鱼S
//
//  Created by trident on 2017/8/21.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let cellID = "CellID"

protocol pageContentViewDelegate: class
{
    
    func pageContentDelegate(_ contentView:PageContentView, progress:CGFloat, sourceIndex:Int, targetIndex:Int)
    
}



class PageContentView: UIView
{

   
    //MARK:- 定义属性
    var childVcs: [UIViewController]
    weak var parentVC: UIViewController?
    var StartOffSetX: CGFloat = 0
    weak var delegate:pageContentViewDelegate?
    var isForbidScroll: Bool = false
    
    //MARK:- 懒加载CollectionView
    lazy var myCollectionView:UICollectionView =
    {[weak self] in
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collection
        
    }()
    
    
    //MARK:- 自定义构造函数
     init(frame: CGRect, childVCS: [UIViewController], parentViewController:UIViewController?)
    {
        
        self.childVcs = childVCS
        self.parentVC = parentViewController
        
        super.init(frame: frame)
        
        
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK:- UI布局
extension PageContentView
{

    func setUI()
    {
        //将所有子控制器添加到父控制器中
        for child in childVcs
        {
            parentVC?.addChildViewController(child)

        }
        
        //添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(myCollectionView)
        myCollectionView.frame = bounds
    
        
    }
    
}


//MARK:- collectionView协议 dataSource
extension PageContentView:UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        
        for child in cell.contentView.subviews
        {
            child.removeFromSuperview()
        }
        
        let childVC = childVcs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
        
    }
    
    
}


//MARK:- UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate
{
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        
        
        isForbidScroll = false
        
        StartOffSetX = scrollView.contentOffset.x
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        if isForbidScroll
        {
            return
        }
        
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > StartOffSetX //左滑
        {
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count
            {
                
                targetIndex = childVcs.count - 1
                
            }
            
            if currentOffsetX - StartOffSetX == scrollViewW
            {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        }
        else//右滑
        {
            
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count
            {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //将progress sourceIndex targetIndex 传递给pageTitleView
        delegate?.pageContentDelegate(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
    
}



//MARK:- 对外暴露的方法
extension PageContentView
{
    func setCurrIndex(_ currentInt:Int)
    {
        
        
        isForbidScroll = true
        
        let OffSetX = CGFloat(currentInt) * myCollectionView.frame.width
        myCollectionView.setContentOffset(CGPoint.init(x: OffSetX, y: 0), animated: false)
    
    }
    
}









