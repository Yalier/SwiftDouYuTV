//
//  AmuseRoomListModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class AmuseRoomListModel: NSObject
{

    var vertical_src : String = ""
    var isVertical : Int = 0
    var room_name : String = ""
    var show_time : Int = 0
    var nickname : String = ""
    var online : Int = 0
    var game_name : String = ""
    var owner_uid : Int = 0
    var child_id : Int = 0
    
    
    init(dic : [String : Any])
    {
        
        super.init()
        setValuesForKeys(dic)
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
