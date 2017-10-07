//
//  AmuseViewModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject
{
    
    lazy var MyAmuseDataArr : [AmuseModel] = [AmuseModel]()

}

extension AmuseViewModel
{
    
    
    func LPLoadAmuseData(backData : @escaping () -> ())
    {
        
        NetworkTools.requestDataLP(.get, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in
            
            guard let resultDic = result as? [String : Any] else
            {
                return
            }
            
            guard let resultArr = resultDic["data"] as? [[String :  Any]] else
            {
                return
            }
            
            
            for dic in resultArr
            {
                
                self.MyAmuseDataArr.append(AmuseModel.init(dic: dic))
                
            }
            
            
            backData()
            
            
        }
        
        
    }
    
    
    
}
