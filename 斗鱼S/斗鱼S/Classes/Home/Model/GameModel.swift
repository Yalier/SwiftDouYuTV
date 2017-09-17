//
//  GameModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/8.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class GameModel: NSObject
{
    
    var tag_name : String  = ""
    var icon_url : String = ""
    
    init(dic : [String : Any])
    {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
