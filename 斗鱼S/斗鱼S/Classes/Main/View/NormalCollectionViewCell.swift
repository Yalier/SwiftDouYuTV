//
//  NormalCollectionViewCell.swift
//  斗鱼S
//
//  Created by trident on 2017/8/23.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var roomName: UILabel!
    
    var roomModel : RoomModel?
    {
        
        didSet
        {
            
            var onLineStr : String = ""
            guard let norRoom = roomModel else {return}
            
            if norRoom.online >= 10000
            {
                onLineStr = "\(Int(norRoom.online/10000))万在线"
            }
            else
            {
                onLineStr = "\(norRoom.online)在线"
            }
            
            onLineBtn.setTitle(onLineStr, for: .normal)
            nickName.text = norRoom.nickname
            
            guard let url = URL.init(string: norRoom.vertical_src) else {return}
            let imageR : ImageResource = ImageResource.init(downloadURL: url)
            
            iconImageV.kf.setImage(with: imageR, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
            roomName.text = norRoom.room_name
            
            
        }
        
    }
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
    }

}
