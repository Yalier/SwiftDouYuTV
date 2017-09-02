//
//  CycleCollectionViewCell.swift
//  斗鱼S
//
//  Created by trident on 2017/8/31.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    var cycleM : CycleModel?
    {
        
        didSet
        {
            
            
            titleLabel.text = cycleM?.title
            
            guard let url = URL.init(string: cycleM?.pic_url ?? "") else {return}
            let imageRes = ImageResource.init(downloadURL: url)
            iconIV.kf_setImage(with: imageRes, placeholder: UIImage.init(named: "default_group_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            
            
        }
        
    }
    
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
    
    }

}
