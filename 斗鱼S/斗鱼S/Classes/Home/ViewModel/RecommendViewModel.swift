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
    
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    lazy var groupArray:[AnchorGroup] = [AnchorGroup]()
    lazy var recommendData: AnchorGroup = AnchorGroup()
    lazy var prottyData : AnchorGroup = AnchorGroup()
    
    
    //请求首页推荐数据
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
            self.recommendData.small_icon_url = "columnHotIcon"
            
            
            for dic in dataArr
            {
                
                let roomData = RoomModel.init(dic: dic)
                self.recommendData.roomModelArray.append(roomData)
                
            }

            
            dispatchG.leave()
            print("0组")
            
        }
        
        
        
      //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1504247848
        //2.颜值数据
        dispatchG.enter()
        NetworkTools.requestDataLP(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parametersStr) { (result) in
            
            guard let responseDic = result as? [String:NSObject] else {return}
            
            guard let dataArr = responseDic["data"] as? [[String:NSObject]] else {return}
            
            
            self.prottyData.tag_name = "颜值"
            self.prottyData.small_icon_url = "columnYanzhiIcon"
            
            for dic in dataArr
            {
                
                let roomData = RoomModel.init(dic: dic)
                self.prottyData.roomModelArray.append(roomData)
                
            }
            
            dispatchG.leave()
            print("1组")
            
        }
       
        
        
        //3.游戏数据(后面部分)
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1504247848
        dispatchG.enter()
        NetworkTools.requestDataLP(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parametersStr) { (response) in
            
    
            guard let responseDic = response as? [String:NSObject] else {return}
            
            guard let dataArr = responseDic["data"] as? [[String:NSObject]] else {return}
            
            for dic in dataArr
            {
                
                let group = AnchorGroup.init(dic: dic)
                
                self.groupArray.append(group)
                
            }
            
            
//            for oup in self.groupArray
//            {
//                
//                for dataM in oup.roomModelArray
//                {
//                    //print(dataM.nickname)
//                    
//                }
//                
//                //print("==================== \(oup.tag_name)")
//                
//            }
            
            dispatchG.leave()
            print("2-12组")
            
        }
        
        
        dispatchG.notify(queue: DispatchQueue.main) { 
            
            print("请求了所有推荐显示数据")
            self.groupArray.insert(self.prottyData, at: 0)
            self.groupArray.insert(self.recommendData, at: 0)
            
                
            callBack()
            
        }
        
    }
    
}


extension RecommendViewModel
{
    
    func requestCycleData(callBack:@escaping ()->())
    {
        
        NetworkTools.requestDataLP(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.540"]) { (result) in
            
            
            guard let resultDic = result as? [String:NSObject] else {return}
            
            guard let dataArr = resultDic["data"] as? [[String:NSObject]] else {return}
            
            
            for dic in dataArr
            {
                
                self.cycleModels.append(CycleModel.init(dic: dic))
                
            }
            
            
            callBack()
            
        }
        
        
    }
    
    
}


