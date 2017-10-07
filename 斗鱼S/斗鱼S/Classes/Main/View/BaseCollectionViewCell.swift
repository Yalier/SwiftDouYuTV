//
//  BaseCollectionViewCell.swift
//  斗鱼S
//
//  Created by trident on 2017/8/29.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell
{
    
    
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var onLineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    
    var roomModel : RoomModel?
    {
        
        didSet
        {
            
            //校验
            guard let room = roomModel else {return}
            
            var onLineStr : String = ""
            if room.online >= 10000
            {
                onLineStr = "\(Int(room.online/10000))万在线"
            }
            else
            {
                onLineStr = "\(room.online)在线"
            }
            
            onLineButton.setTitle(onLineStr, for: .normal)
            nickNameLabel.text = room.nickname
            
            guard let url = URL.init(string: room.vertical_src) else{return}
            let imageResource : ImageResource = ImageResource.init(downloadURL: url)
            
            iconImageV.kf.setImage(with: imageResource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
            
        }
        
    }
    
    
}
