//
//  ShopTableViewCell.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    //選択されたレストランの画面のtableViewcセルに表示する要素
    @IBOutlet weak var shopIcon: UIImageView!
    @IBOutlet weak var textShop: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
