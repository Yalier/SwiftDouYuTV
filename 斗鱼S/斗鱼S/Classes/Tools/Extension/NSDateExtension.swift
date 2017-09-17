//
//  NSDateExtension.swift
//  斗鱼S
//
//  Created by trident on 2017/8/25.
//  Copyright © 2017年 trident. All rights reserved.
//

import Foundation

extension Date
{
    
    static func getCurrentTime() -> String
    {
        
        let nowTime = Date.init()

        let interval = Int(nowTime.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
    
    
}
