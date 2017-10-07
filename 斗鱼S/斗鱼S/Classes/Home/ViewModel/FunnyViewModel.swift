//
//  FunnyViewModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class FunnyViewModel: NSObject
{

    lazy var myFunnyModels : [FunnyModel] = [FunnyModel]()
    
}


extension FunnyViewModel
{
    
    func getFunnyData(back : @escaping () -> ())
    {
        
        NetworkTools.requestDataLP(.get, urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : "30", "offset" : "0"])
        { (result) in
            
            
            guard let myResult = result as? [String : Any] else {return}
            
            guard let myArray = myResult["data"] as? [[String : Any]] else {return}
            
            
            for dic in myArray
            {
                
               self.myFunnyModels.append(FunnyModel.init(dic: dic))
                
            }
            
            
            back()
            
        }
        
        
    }
    
    
}

