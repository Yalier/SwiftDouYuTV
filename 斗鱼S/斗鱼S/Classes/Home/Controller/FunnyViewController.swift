//
//  FunnyViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let kFunnyItemW : CGFloat = (kScreenWidth - 30) / 2
private let kFunnyItemH : CGFloat = kFunnyItemW * 3 / 4

private let kFunnyCellID = "kFunnyCellID"


class FunnyViewController: HomeBaseViewController
{

    
    lazy var funnyViewModel : FunnyViewModel = FunnyViewModel()
    
    lazy var myFunnyCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize.init(width: kFunnyItemW, height: kFunnyItemH)
        
        let colle = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        
        colle.backgroundColor = UIColor.white
        colle.register(UINib.init(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kFunnyCellID)
        colle.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colle.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        colle.delegate = self
        colle.dataSource = self
        
        return colle
        
    }()
    
    
    override func viewDidLoad()
    {
        
        contentView = myFunnyCollectionView
        
        setUI()
        
        super.viewDidLoad()
        
        loadFunnyData()
        
    }
    
 
}

//设置UI
extension FunnyViewController
{
    
    func setUI()
    {
        
        view.addSubview(myFunnyCollectionView)
        
        
    }
    
    
}

//网络请求
extension FunnyViewController
{
    
    func loadFunnyData()
    {
        
        funnyViewModel.getFunnyData { 
            
            self.myFunnyCollectionView.reloadData()
            
            self.amationFinish()
            
        }
        
    }
    
}

extension FunnyViewController : UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return funnyViewModel.myFunnyModels.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFunnyCellID, for: indexPath) as! NormalCollectionViewCell
        
        cell.funnyModel = funnyViewModel.myFunnyModels[indexPath.item]
        
        return cell
        
    }
    
}

extension FunnyViewController : UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let data = funnyViewModel.myFunnyModels[indexPath.item]
        
        data.isVertical == 0 ? normalRoom() : showRoom()
        
    }
    
    func normalRoom()
    {
        
        navigationController?.pushViewController(NormalRoomViewController(), animated: true)
        
    }
    
    func showRoom()
    {
        
        present(ShowRoomViewController(), animated: true, completion: nil)
        
    }
    
    
}




