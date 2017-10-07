//
//  AmuseViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let LPitemW : CGFloat = (kScreenWidth - 30) / 2
private let LPitemH : CGFloat = LPitemW * 3 / 4

private let kAmuseCellID = "hahaha"
private let kAmuseHeaderID = "AmuseHeaderCellID"

class AmuseViewController: HomeBaseViewController {

    
    lazy var AmuseViewM : AmuseViewModel = AmuseViewModel()
    
    lazy var myAmuseTopView : AmuseTopView = {
        
        let amuseV = AmuseTopView.getAmuseTopView()
        
        amuseV.frame = CGRect.init(x: 0, y: -200, width: kScreenWidth, height: 200)
        
        
        return amuseV
        
    }()
    

    lazy var myCollectionView : UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: LPitemW, height: LPitemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 50)
    
        let collec = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        
        collec.delegate = self
        collec.dataSource = self
        collec.backgroundColor = UIColor.white
        
        collec.register(UINib.init(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseCellID)
        collec.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kAmuseHeaderID)
        
        collec.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return collec
        
    }()
    

    override func viewDidLoad()
    {
        
        contentView = myCollectionView
        
        setUI()
        
        super.viewDidLoad()
        
        loadAmuseData()
        
    
    }

}

//UI设置
extension AmuseViewController
{
    
    func setUI()
    {
        
        view.addSubview(myCollectionView)
        
        myCollectionView.addSubview(myAmuseTopView)
        
        myCollectionView.contentInset = UIEdgeInsets.init(top: 200, left: 0, bottom: 0, right: 0)
        
    }
    
    
}

//网络请求
extension AmuseViewController
{
    
    func loadAmuseData()
    {
        
        self.AmuseViewM.LPLoadAmuseData {
            
            self.myCollectionView.reloadData()
            
            var arrayData = self.AmuseViewM.MyAmuseDataArr
            arrayData.removeFirst()
            
            self.myAmuseTopView.amuseModels = arrayData
            
            self.amationFinish()
            
        }
        
        
    }
    
}

extension AmuseViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        
        return self.AmuseViewM.MyAmuseDataArr.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return self.AmuseViewM.MyAmuseDataArr[section].roomListArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseCellID, for: indexPath) as! NormalCollectionViewCell
        
        cell.AmuseListModel = self.AmuseViewM.MyAmuseDataArr[indexPath.section].roomListArray[indexPath.item]
        
        
        return  cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kAmuseHeaderID, for: indexPath) as! HeaderCollectionReusableView
        
        headerView.amuseModel = self.AmuseViewM.MyAmuseDataArr[indexPath.section]
        
        
        return headerView
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let data = self.AmuseViewM.MyAmuseDataArr[indexPath.section].roomListArray[indexPath.item]
        data.isVertical == 0 ? presentNormal() : presentShow()
        
    }
    
    func presentNormal()
    {
    
        navigationController?.pushViewController(NormalRoomViewController(), animated: true)
    
    }
    
    func presentShow()
    {
        present(ShowRoomViewController(), animated: true, completion: nil)
        
    }
    
    
}


