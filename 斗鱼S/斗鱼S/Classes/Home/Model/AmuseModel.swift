//
//  AmuseModel.swift
//  斗鱼S
//
//  Created by trident on 2017/9/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class AmuseModel: NSObject
{
    
    var tag_name : String = ""
    var count : Int = 0
    var count_ios : Int = 0
    var icon_url : String = ""
    var small_icon_url : String = ""
    
    lazy var roomListArray : [AmuseRoomListModel] = [AmuseRoomListModel]()
    
    var room_list : [[String : Any]]?
    {
        
        didSet
        {
            
            guard let rooms = room_list else
            {
                return
            }
            
            for roomDic in rooms
            {
                
                self.roomListArray.append(AmuseRoomListModel.init(dic: roomDic))
                
            }
           
            
        }
        
    }
    
    
    init(dic : [String : Any])
    {
        
        super.init()
        setValuesForKeys(dic)

    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
