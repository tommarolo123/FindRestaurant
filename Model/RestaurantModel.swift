//
//  RestaurantModel.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import Foundation
import UIKit

//gnaviのアドレスに入れるパラメーターを保管するおNSObject
class PhraseApi: NSObject {
    var Range = 1
    var latitude = ""
    var longitude = ""
}
//ShopViewControllerのtableViewに使う情報
class PhraseModel: NSObject {
    var name = ""
    var access = ""
    var image = ""
    var address = ""
    var tel = ""
    var opentime = ""
    var holiday = ""
    var pr = ""
}

//APIから取り出した情報を以下の構造体に入れる
struct Json : Codable {
    let rest: [Data]?
}
struct Data: Codable {
    let name : String?
    let address : String?
    let tel: String?
    let opentime: String?
    let holiday: String?
    
    let pr: prData?
    let access: accessData?
    let image_url : imageData?
    
    struct prData: Codable {
        let pr_long: String?
    }
    struct accessData : Codable {
        let line : String?
        let station : String?
        let walk : String?
    }
    struct imageData : Codable {
        let shop_image1: String?
        let shop_image2: String?
    }
    
    
}

//imageのURLからImageViewにimageを表示させるオーバーライド
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        if(link == ""){
            self.image = UIImage(named: "defaultImage")
            return
        }
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

