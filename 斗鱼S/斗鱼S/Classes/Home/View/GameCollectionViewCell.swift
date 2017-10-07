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
    
    
    var myGameModel : GameModel?
    {
        
        didSet
        {
            
            myTitleLabel.text = myGameModel?.tag_name
            
            if myGameModel?.icon_url == ""
            {
                myIcon.image = UIImage.init(named: "default_group_icon")
            }
            else
            {
                
                let url = URL.init(string: myGameModel?.icon_url ?? "")
                myIcon.kf.setImage(with: url)
                
            }
            
        }
        
    }
    
    
    var amuseModelTop : AmuseModel?
    {
        
        didSet
        {
            
            myTitleLabel.text = amuseModelTop?.tag_name
            
            if amuseModelTop?.icon_url == ""
            {
                myIcon.image = UIImage.init(named: "default_group_icon")
                return
            }
            
            guard let urlStr = amuseModelTop?.icon_url else
            {
                return
            }
            
            let url = URL.init(string: urlStr)
            myIcon.kf.setImage(with: url)
            
    
        }
        
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        
    }

}
