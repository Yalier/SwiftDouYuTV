//
//  HeaderCollectionReusableView.swift
//  斗鱼S
//
//  Created by trident on 2017/8/23.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class HeaderCollectionReusableView: UICollectionReusableView
{
    
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup?
    {
        didSet
        {
            
            //iconIV.image = UIImage.init(named: group?.icon_name ?? "discovery_wolfmanKill")
            titleLabel.text = group?.tag_name
            
            if group?.small_icon_url == "columnHotIcon" || group?.small_icon_url == "columnYanzhiIcon"
            {
                
                iconIV.image = UIImage.init(named: (group?.small_icon_url)!)
                return
                
            }
            
            
            if group?.small_icon_url == ""
            {
                
                iconIV.image = UIImage.init(named: "discovery_wolfmanKill")
                return
                
            }
            
            guard let myUrl = URL.init(string: (group?.small_icon_url)!) else {return}
            let imageRes : ImageResource = ImageResource.init(downloadURL: myUrl)
            iconIV.kf.setImage(with: imageRes)
            
            
        }
        
    }
    
    
    var amuseModel : AmuseModel?
    {
        
        didSet
        {
            
            //iconIV.image = UIImage.init(named: group?.icon_name ?? "discovery_wolfmanKill")
            titleLabel.text = amuseModel?.tag_name
            
            if amuseModel?.icon_url == "columnHotIcon" || amuseModel?.icon_url == "columnYanzhiIcon"
            {
                
                iconIV.image = UIImage.init(named: (amuseModel?.icon_url)!)
                return
                
            }
            
            
            if amuseModel?.icon_url == ""
            {
                
                iconIV.image = UIImage.init(named: "discovery_wolfmanKill")
                return
                
            }
            
            guard let myUrl = URL.init(string: (amuseModel?.icon_url)!) else {return}
            let imageRes : ImageResource = ImageResource.init(downloadURL: myUrl)
            iconIV.kf.setImage(with: imageRes)
            
            
        }

        
        
    }
    
    
    
    override func awakeFromNib()
    {
       
        super.awakeFromNib()
        
    }
    
}



extension HeaderCollectionReusableView
{
    
    class func getHeaderView() -> HeaderCollectionReusableView
    {
        
        return Bundle.main.loadNibNamed("HeaderCollectionReusableView", owner: nil, options: nil)?.first as! HeaderCollectionReusableView
        
    }
    
    
}
