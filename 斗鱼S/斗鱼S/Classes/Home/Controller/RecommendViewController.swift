//
//  RecommendViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/8/23.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

let kItemMargin: CGFloat = 10
let kItemW = (kScreenWidth-3*kItemMargin)/2
let kNormalItemH = kItemW*3/4
let kPrettyItemH = kItemW*4/3
let kNormalCellID = "NormalCell"
let kPrettyCellID = "kPrettyCellID"
let kHeaderViewH: CGFloat = 50
let kHeaderID = "kHeaderID"

class RecommendViewController: UIViewController
{

    lazy var collectionView: UICollectionView =
    {[unowned self] in
       
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        let myCollectionV = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        myCollectionV.backgroundColor = UIColor.white
        myCollectionV.dataSource = self
        myCollectionV.delegate = self
        
        return myCollectionV
        
    }()
    
    
    //MARK:-系统回调函数
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        
        setUPUI()
    
        
        collectionView.register(UINib.init(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        
        collectionView.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }

    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}

extension RecommendViewController
{
    
    func setUPUI()
    {
        
        view.addSubview(collectionView)
        
    }
    
}

//MARK:- UICollectionView数据源协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        
        return 12
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if section == 0
        {
            return 8
        }
        
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        var cell: UICollectionViewCell!
        
        if indexPath.section == 1
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
    
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        
        
        return headerView
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if indexPath.section == 1
        {
         
            return CGSize.init(width: kItemW, height: kPrettyItemH)
            
        }
        else
        {
            return CGSize.init(width: kItemW, height: kNormalItemH)
        }
        
        
    }
    
    
}





