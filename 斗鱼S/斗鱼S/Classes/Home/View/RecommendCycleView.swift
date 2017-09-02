//
//  RecommendCycleView.swift
//  斗鱼S
//
//  Created by trident on 2017/8/29.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

let cellString = "cellID"
let scrollCount = 1000000

class RecommendCycleView: UIView
{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    var myTimer:Timer?
    
    var cycleDatas : [CycleModel]?
    {
        
        didSet
        {
            
            myCollectionView.reloadData()
            myPageControl.numberOfPages = cycleDatas?.count ?? 0
            
            let indexPath = IndexPath.init(item: (cycleDatas?.count ?? 0)*2000, section: 0)
            myCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            removeTimer()
            addTimer()
            
        }
        
    }
    

    override func awakeFromNib()
    {
        
        super.awakeFromNib()
        
        //autoresizingMask = .flexibleBottomMargin
        
        //注册cell
        myCollectionView.register(UINib.init(nibName: "CycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellString)
    
    }
    
    //布局子控件
    override func layoutSubviews()
    {
        
        super.layoutSubviews()
        
        myCollectionView.frame = self.bounds
        
        let layout = myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = myCollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        myCollectionView.isPagingEnabled = true
        myCollectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    

    
    class func getRecommendCycleView() -> RecommendCycleView
    {
        
        
       return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        
    }

}


extension RecommendCycleView:UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return (cycleDatas?.count ?? 0) * scrollCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellString, for: indexPath) as! CycleCollectionViewCell
        
        
        let cellData = cycleDatas?[indexPath.item % cycleDatas!.count]
        cell.cycleM = cellData
        
        
        return cell
        
    }
    
}


extension RecommendCycleView:UICollectionViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        myPageControl.currentPage = Int(offset / scrollView.bounds.width) % (cycleDatas?.count ?? 1)
        
    
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        
        removeTimer()
        
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        
        addTimer()
        
    }
    
    

}


extension RecommendCycleView
{
    
    func addTimer()
    {
        
        myTimer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        
        RunLoop.main.add(myTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func removeTimer()
    {
        
        myTimer?.invalidate()
        myTimer = nil
        
    }
    
    
    func startTimer()
    {
        
        let offSetX = myCollectionView.contentOffset.x + myCollectionView.bounds.width
        myCollectionView.setContentOffset(CGPoint.init(x: offSetX, y: 0), animated: true)
        
    }
    
    
}

