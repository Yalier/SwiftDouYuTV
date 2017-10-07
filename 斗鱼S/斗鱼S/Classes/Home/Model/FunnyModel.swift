//
//  FunnyModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class FunnyModel: NSObject
{
    
    var room_id : Int = 0
    var room_name : String = ""
    var owner_uid : Int = 0
    var nickname : String = ""
    var vertical_src : String = ""
    var isVertical : Int = 0
    var avatar : String = ""
    var show_time : Int = 0
    var online : Int = 0
    var url : String = ""
    var game_url : String = ""
    var game_name : String = ""
    var avatar_small : String = ""
    var anchor_city : String = ""
    
    
    init(dic : [String : Any])
    {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
    }
    
    
}
