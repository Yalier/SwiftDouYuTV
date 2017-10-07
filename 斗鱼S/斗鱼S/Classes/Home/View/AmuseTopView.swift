//
//  AmuseTopView.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let amuseCellID = "amuseCellID"

class AmuseTopView: UIView
{

    @IBOutlet weak var myAmuseCollectionTopView: UICollectionView!
    @IBOutlet weak var myAmusePageControl: UIPageControl!

    
    var amuseModels : [AmuseModel]?
    {
        didSet
        {
            
            myAmuseCollectionTopView.reloadData()
            
        }
        
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        myAmuseCollectionTopView.register(UINib.init(nibName: "AmuseTopCell", bundle: nil), forCellWithReuseIdentifier: amuseCellID)
        
    }
    

    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let layout = myAmuseCollectionTopView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = myAmuseCollectionTopView.bounds.size
        
    }

}


extension AmuseTopView
{
    
    class func getAmuseTopView() -> AmuseTopView
    {
        
        return Bundle.main.loadNibNamed("AmuseTopView", owner: nil, options: nil)?.first as! AmuseTopView
        
    }
    
    
}

extension AmuseTopView : UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if amuseModels == nil
        {
            return 0
        }
        
        let pageNum = (amuseModels!.count - 1) / 8 + 1
        myAmusePageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseCellID, for: indexPath) as! AmuseTopCell
        
        cellForIndex(Cell: cell, indexPathLP: indexPath)
        
        return cell
        
    }
    
    
    func cellForIndex(Cell : AmuseTopCell, indexPathLP : IndexPath)
    {
        
        let startIndex = indexPathLP.item * 8
        var endIndex = (indexPathLP.item + 1) * 8 - 1
        
        if endIndex > amuseModels!.count - 1
        {
            endIndex = amuseModels!.count - 1
        }
        
        Cell.amuseDatas = Array(amuseModels![startIndex...endIndex])
        
        
    }
    
    
}

extension AmuseTopView : UICollectionViewDelegate
{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        myAmusePageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
    }
    
    
}



