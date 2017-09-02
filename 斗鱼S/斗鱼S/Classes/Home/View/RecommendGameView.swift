//
//  RecommendGameView.swift
//  斗鱼S
//
//  Created by trident on 2017/9/1.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

let gameCellStr = "gameCellStr"



class RecommendGameView: UIView
{
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    //数据源数组
    var anchorGroups : [AnchorGroup]?
    {
        didSet
        {
            
            //移除前两个数据
            anchorGroups?.removeFirst()
            anchorGroups?.removeFirst()
            
            //添加“更多”数据
            let more = AnchorGroup()
            more.tag_name = "更多"
            anchorGroups?.append(more)
            
            
            myCollection.reloadData()
            
        }
        
    }
    
    
    override func awakeFromNib()
    {
        
        super.awakeFromNib()
        
        myCollection.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCellStr)
        
        myCollection.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
    }
    
    
    override func layoutSubviews()
    {
        
        
        myCollection.frame = self.bounds
        
        let myLayout = myCollection.collectionViewLayout as! UICollectionViewFlowLayout
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 0
        myLayout.minimumInteritemSpacing = 0
        myLayout.itemSize = CGSize.init(width: 80, height: 90)
        
        myCollection.showsHorizontalScrollIndicator = false
        
        
    }
    

}


extension RecommendGameView
{
    
  
    class func getRecommendGameView() -> RecommendGameView
    {
        
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        
    }
    
    
}



extension RecommendGameView:UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellStr, for: indexPath) as! GameCollectionViewCell
        
        let data = anchorGroups?[indexPath.item]
        cell.myGroup = data
        
        
        return cell
        
    }
    
    
    
}


