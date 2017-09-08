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
let kCycleViewH = kScreenWidth * 3/8
let kGameViewH:CGFloat = 90

class RecommendViewController: UIViewController
{

    
    lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
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
    
    lazy var cycleView:RecommendCycleView = {
        
        let cycle = RecommendCycleView.getRecommendCycleView()
        
        cycle.frame = CGRect.init(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenWidth, height: kCycleViewH)
        
        return cycle
        
    }()
    
    lazy var recommendGameV:RecommendGameView = {
        
        let recommGame = RecommendGameView.getRecommendGameView()
        recommGame.frame = CGRect.init(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        
        return recommGame
        
    }()
    
    //MARK:-系统回调函数
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        
        //添加子控件
        setUPUI()
        
        
        //网络请求
        loadData()
    
        
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

//MARK:- 网络请求
extension RecommendViewController
{
    
    func loadData()
    {
     
        recommendVM.requestData {
            
            self.collectionView.reloadData()
            
            self.recommendGameV.anchorGroups = self.recommendVM.groupArray
            
        }
        
        
        recommendVM.requestCycleData {
            
            
            self.cycleView.cycleDatas = self.recommendVM.cycleModels
            
        }
        
        
    }
    
    
}

//MARK:- 添加子控件
extension RecommendViewController
{
    
    func setUPUI()
    {
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(recommendGameV)
        
        //设置collectionView的内边距 显示出滚动视图
        collectionView.contentInset = UIEdgeInsets.init(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
    
}

//MARK:- UICollectionView数据源协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        
        return recommendVM.groupArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        
        let groupCount = recommendVM.groupArray[section]
        return groupCount.roomModelArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let group = recommendVM.groupArray[indexPath.section]
        let cellData = group.roomModelArray[indexPath.item]
        
        
        if indexPath.section == 1
        {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell
            
            cell.roomModel = cellData
            
            return cell
        }
        else
        {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
            
            cell.roomModel = cellData
            
            return cell
        }
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HeaderCollectionReusableView
        
        headerView.group = recommendVM.groupArray[indexPath.section]
        
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





