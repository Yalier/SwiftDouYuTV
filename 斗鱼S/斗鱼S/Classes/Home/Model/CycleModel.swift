//
//  CycleModel.swift
//  斗鱼S
//
//  Created by trident on 2017/8/30.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class CycleModel: NSObject
{
    
    var id : Int = 0
    var title : String = ""
    var pic_url : String = ""
    var tv_pic_url : String = ""
    
    var room : [String : NSObject]?
    {
        
        didSet
        {
            
            guard let myRoom = room else{return}
            
            roomModel = RoomModel.init(dic: myRoom)
            
        }
        
    }
    
    var roomModel : RoomModel?
    
    
    init(dic:[String:NSObject])
    {
        
        super.init()
        
        setValuesForKeys(dic)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
    }
    
    
}
