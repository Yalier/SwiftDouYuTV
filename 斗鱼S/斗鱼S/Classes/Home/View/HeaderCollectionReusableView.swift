//
//  HeaderCollectionReusableView.swift
//  斗鱼S
//
//  Created by trident on 2017/8/23.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var group : AnchorGroup?
    {
        didSet
        {
            
            iconIV.image = UIImage.init(named: group?.icon_name ?? "discovery_wolfmanKill")
            titleLabel.text = group?.tag_name
            
        }
        
    }
    
    
    
    override func awakeFromNib()
    {
       
        super.awakeFromNib()
        
    }
    
}
