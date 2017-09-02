//
//  PrettyCollectionViewCell.swift
//  斗鱼S
//
//  Created by trident on 2017/8/23.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: BaseCollectionViewCell {

    
    @IBOutlet weak var CityButton: UIButton!
    
    
    override var roomModel : RoomModel?
    {
        didSet
        {
            
            super.roomModel = roomModel
            CityButton.setTitle(roomModel?.anchor_city, for: .normal)
            
        }
        
    }
    
    
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

}
