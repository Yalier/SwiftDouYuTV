//
//  GameCollectionViewCell.swift
//  斗鱼S
//
//  Created by trident on 2017/9/1.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myIcon: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    
    

    var myGroup : AnchorGroup?
    {
        didSet
        {
            
            myTitleLabel.text = myGroup?.tag_name
            
            
            if myGroup?.icon_url == ""
            {
                myIcon.image = UIImage.init(named: "dyla_image_moreBtn")
                return
            }
            
            guard let url = URL.init(string: (myGroup?.icon_url)!) else {return}
            let imageRes = ImageResource.init(downloadURL: url)
            myIcon.kf.setImage(with: imageRes)
            
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        
    }

}
