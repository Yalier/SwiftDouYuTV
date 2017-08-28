//
//  AnchorGroup.swift
//  斗鱼S
//
//  Created by trident on 2017/8/25.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject
{
    
    var room_list: [[String:NSObject]]?
    //第二种方法
    {
        didSet
        {
            
            guard let rooms = room_list else{return}
            
            for dic in rooms
            {
                roomModelArray.append(RoomModel.init(dic: dic))
            }
            
        }
    }
    
    var tag_name: String = ""
    var icon_name: String = "discovery_hotVideo"
    lazy var roomModelArray:[RoomModel] = [RoomModel]()
    
    override init() {
        
        
    }
    
    init(dic:[String:NSObject])
    {
        
        super.init()

        setValuesForKeys(dic)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
        
    }
    
    //第一种方法
//    override func setValue(_ value: Any?, forKey key: String)
//    {
//        
//        if key == "room_list"
//        {
//            
//            if let roomDataArr = value as? [[String:NSObject]]
//            {
//                
//                for dic in roomDataArr
//                {
//                    
//                    let model = RoomModel.init(dic: dic)
//                    roomModelArray.append(model)
//                    
//                }
//                
//            }
//            
//            
//        }
//        
//    }

}
