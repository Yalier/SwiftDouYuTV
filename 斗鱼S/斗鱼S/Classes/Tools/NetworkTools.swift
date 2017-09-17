//
//  NetworkTools.swift
//  斗鱼S
//
//  Created by trident on 2017/8/25.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Alamofire

enum typeMothed
{
    case get
    case post
}


class NetworkTools: NSObject
{
    
    
    class func requestDataLP(_ type: typeMothed, urlString: String, parameters: [String:String]? = nil, finishedBack: @escaping (_ result:AnyObject) -> ())
    {
        
        
       let mothed = type == typeMothed.get ? HTTPMethod.get : HTTPMethod.post
  
    
        Alamofire.request(urlString, method: mothed, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let res = response.result.value else
            {
                
                print("请求失败:\(response.result.error!)")
                return
                
            }
            
            finishedBack(res as AnyObject)
            
            
        }
        
    }
    
    

}
