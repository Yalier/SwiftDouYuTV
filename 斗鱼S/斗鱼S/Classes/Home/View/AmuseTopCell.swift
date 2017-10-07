//
//  AmuseTopCell.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let amuseTopID = "amuseTopID"
private let kAmuseTopGameCellW : CGFloat = kScreenWidth / 4

class AmuseTopCell: UICollectionViewCell
{
    
    
    @IBOutlet weak var myAmuseTopCollec: UICollectionView!
    
    var amuseDatas : [AmuseModel]?
    {
        
        didSet
        {
            
            myAmuseTopCollec.reloadData()
            
        }
        
    }
    
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
       
        myAmuseTopCollec.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: amuseTopID)
       
    }
    
    
    override func layoutSubviews()
    {
        
        super.layoutSubviews()
        
        
        let layout = myAmuseTopCollec.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: kAmuseTopGameCellW, height: myAmuseTopCollec.frame.height / 2)
        
        
    }

}


extension AmuseTopCell : UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return amuseDatas?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseTopID, for: indexPath) as! GameCollectionViewCell
        
        cell.amuseModelTop = amuseDatas![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
        
    }
    
    
    
}
