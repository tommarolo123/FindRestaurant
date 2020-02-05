//
//  DetailTableViewCell.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //レストランのリストのcセルに表示する要素
    @IBOutlet weak var Shop_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var access: UILabel!
    
    //ViewControllerんのtableViewから受け取ったPhraseをセルの要素に挿入する
    var phrase: PhraseModel? {
        didSet{
            name.text = (phrase?.name)!
            access.text = (phrase?.access)!
            let image = (phrase?.image)!
            Shop_image.downloaded(from: image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
