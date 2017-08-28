//
//  RecommendViewModel.swift
//  斗鱼S
//
//  Created by trident on 2017/8/25.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject
{
    
    lazy var groupArray:[AnchorGroup] = [AnchorGroup]()
    lazy var recommendData: AnchorGroup = AnchorGroup()
    lazy var prottyData : AnchorGroup = AnchorGroup()
    
    
    func requestData(callBack:@escaping () -> ())
    {
      
        let parametersStr = ["limit":"4", "offset":"0", "time":NSDate.getCurrentTime()]
        
        let dispatchG = DispatchGroup()
        
        //1.推荐数据
        dispatchG.enter()
        NetworkTools.requestDataLP(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            
            guard let responseDic = result as? [String:NSObject] else {return}
            
            guard let dataArr = responseDic["data"] as? [[String:NSObject]] else {return}
            
            
            self.recommendData.tag_name = "热门"
            self.recommendData.icon_name = "columnHotIcon"
            
            for dic in dataArr
            {
                
                let roomData = RoomModel.init(dic: dic)
                self.recommendData.roomModelArray.append(roomData)
                
            }

            
            dispatchG.leave()
            print("0组")
            
        }
        
        
        
      //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1503906640
        //2.颜值数据
        dispatchG.enter()
        NetworkTools.requestDataLP(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parametersStr) { (result) in
            
            guard let responseDic = result as? [String:NSObject] else {return}
            
            guard let dataArr = responseDic["data"] as? [[String:NSObject]] else {return}
            
            
            self.prottyData.tag_name = "颜值"
            self.prottyData.icon_name = "columnYanzhiIcon"
            
            for dic in dataArr
            {
                
                let roomData = RoomModel.init(dic: dic)
                self.prottyData.roomModelArray.append(roomData)
                
            }
            
            dispatchG.leave()
            print("1组")
            
        }
       
        
        
        //3.游戏数据(后面部分)
        dispatchG.enter()
        NetworkTools.requestDataLP(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parametersStr) { (response) in
            
    
            guard let responseDic = response as? [String:NSObject] else {return}
            
            guard let dataArr = responseDic["data"] as? [[String:NSObject]] else {return}
            
            for dic in dataArr
            {
                
                let group = AnchorGroup.init(dic: dic)
                
                self.groupArray.append(group)
                
            }
            
            
            for oup in self.groupArray
            {
                
                for dataM in oup.roomModelArray
                {
                    //print(dataM.nickname)
                    
                }
                
                //print("==================== \(oup.tag_name)")
                
            }
            
            dispatchG.leave()
            print("2-12组")
            
        }
        
        
        dispatchG.notify(queue: DispatchQueue.main) { 
            
            print("请求了所有数据")
            self.groupArray.insert(self.prottyData, at: 0)
            self.groupArray.insert(self.recommendData, at: 0)
            
            callBack()
            
        }
        
    }
    
}
