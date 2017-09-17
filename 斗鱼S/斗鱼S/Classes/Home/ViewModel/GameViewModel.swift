//
//  GameViewModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/8.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class GameViewModel: NSObject
{

    lazy var gameArr : [GameModel] = [GameModel]()
    
    
}

extension GameViewModel
{
    
    func loadGameData(backData : @escaping () -> ())
    {
        
        NetworkTools.requestDataLP(.get, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            
            //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
            
            guard let resultDic = result as? [String : Any] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            
            for dic in dataArray
            {
                
                self.gameArr.append(GameModel.init(dic: dic))
                
            }
            
            //完成回调
            backData()
            
        }
        
    }
    
    
}
