//
//  GameViewVCTopView.swift
//  斗鱼S
//
//  Created by trident on 2017/9/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class GameViewVCTopView: UICollectionReusableView
{
    
    @IBOutlet weak var IV: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    

}


extension GameViewVCTopView
{
    
    class func getGameTopView() -> GameViewVCTopView
    {
        
        return Bundle.main.loadNibNamed("GameViewVCTopView", owner: nil, options: nil)?.first as! GameViewVCTopView
        
    }
    
    
}
