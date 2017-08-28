//
//  RoomModel.swift
//  斗鱼S
//
//  Created by trident on 2017/8/25.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class RoomModel: NSObject
{
    
    var vertical_src: String = ""
    var owner_uid: Int = 0
    var nickname: String = ""
    var game_name: String = ""
    var online: Int = 0
    var room_name: String = ""
    var room_id: Int = 0
    var show_time: Int = 0
    var isVertical:Int = 0
    var show_status: Int = 0
    
    var anchor_city: String = ""
    

    init(dic:[String:NSObject])
    {
        super.init()
        setValuesForKeys(dic)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
        
    }
    

    
}
