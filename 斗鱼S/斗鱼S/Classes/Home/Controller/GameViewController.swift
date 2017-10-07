//
//  GameViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/8.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

private let CellSTR = "CellStr"
private let HeaderID = "headerStr"

class GameViewController: HomeBaseViewController
{

    
    lazy var gameVM : GameViewModel = GameViewModel()
    
    lazy var topView :GameViewVCTopView = {
        
        let headerV = GameViewVCTopView.getGameTopView()
        
        headerV.frame = CGRect.init(x: 0, y: -(50 + 90), width: kScreenWidth, height: 50)
        headerV.IV.image = UIImage.init(named: "101010")
        headerV.myTitleLabel.text = "常用"
        
        return headerV
        
    }()
    
    
    lazy var recommendV : RecommendGameView = {
        
        let recomm = RecommendGameView.getRecommendGameView()
        
        recomm.frame = CGRect.init(x: 0, y: -90, width: kScreenWidth, height: 90)
        
        
        return recomm
        
    }()

    
    lazy var myGameCollectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: (kScreenWidth - 2 * 10) / 3, height: (kScreenWidth - 2 * 10) / 3 * 6 / 5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        //headerView
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 50)
        
        let collec = UICollectionView.init(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collec.dataSource = self
        collec.delegate = self
        collec.backgroundColor = UIColor.white
        collec.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return collec
        
    }()
    
    override func viewDidLoad()
    {
        
        contentView = myGameCollectionView
        
        //布局
        setupUI()
        
        super.viewDidLoad()
        
        //网络请求
        loadGameData()
        
        //注册Cell
        myGameCollectionView.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellSTR)
        
        //注册headerID
        myGameCollectionView.register(UINib.init(nibName: "GameViewVCTopView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderID)
    
    }

   
}

//UICollectionVIewDataSource
extension GameViewController : UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return gameVM.gameArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSTR, for: indexPath) as! GameCollectionViewCell
        
        
        cell.myGameModel = gameVM.gameArr[indexPath.item]
    
    
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderID, for: indexPath) as! GameViewVCTopView
        
        headerView.myTitleLabel.text = "全部"
        headerView.IV.image = UIImage.init(named: "101010")

        
        return headerView
        
    }
    
}


//UICollectionViewDelegate
extension GameViewController : UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        print(indexPath.section, indexPath.item)
        
    }
    
}


//布局
extension GameViewController
{
    
    func setupUI()
    {
        
        //添加collectionView
        view.addSubview(myGameCollectionView)
        
        //添加topView
        myGameCollectionView.addSubview(topView)
        
        //添加recommendView 
        myGameCollectionView.addSubview(recommendV)
        
        //设置内边距 显示出topView
        myGameCollectionView.contentInset = UIEdgeInsets.init(top: 50 + 90, left: 0, bottom: 0, right: 0)
        
        
    }
    
}

//网络请求
extension GameViewController
{
    
    func loadGameData()
    {
        
        gameVM.loadGameData {
            
            //刷新collectionView
            self.myGameCollectionView.reloadData()
            
//            var gameModelArr = [GameModel]()
//            
//            for i in 0..<10
//            {
//                
//                gameModelArr.append(self.gameVM.gameArr[i])
//                
//            }
//            
//            self.recommendV.gameModes = gameModelArr
            
            self.recommendV.gameModes = Array(self.gameVM.gameArr[0..<10])
            
            self.amationFinish()
            
        }
        
    }
    
    
}

