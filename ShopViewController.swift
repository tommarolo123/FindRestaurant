//
//  ShopViewController.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //店の写真、名前、詳細情報入れのtableViewの宣言
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //tableViewのセルの情報を配列で宣言し、初期化する
    var iconList = ["address","access"]
    var textList = [SearchResult.address,SearchResult.access]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //選択されたレストランんの詳細情報を基づいて、tableViewのセルの情報を配列に追加するメソッドの呼び出す
        getList()
        //店の写真、名前を要素に入れるメソッドの呼び出し
        getDetail()
        
        //tableViewのdataSource,delegateの宣言
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableViewのセルの高さを初期化し、自動的に調整するようにする
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    //店の写真、名前を要素に入れるメソッド
    func getDetail(){
        shopImage.downloaded(from: SearchResult.image)
        shopName.text = SearchResult.name
        //shopAccess.text = SearchResult.access
    }
    
    //選択されたレストランんの詳細情報を基づいて、tableViewのセルの情報を配列に追加する
    func getList(){
        if(SearchResult.opentime != ""){
            iconList.append("opentime")
            textList.append("営業時間：" + SearchResult.opentime)
        }
        if(SearchResult.tel != ""){
            iconList.append("tel")
            textList.append("tel：" + SearchResult.tel)
        }
        if(SearchResult.holiday != ""){
            iconList.append("holiday")
            textList.append("定休日：" + SearchResult.holiday)
        }
        if(SearchResult.pr != ""){
            iconList.append("pr")
            textList.append("本店では：" + SearchResult.pr)
        }
        
    }
    
    //tableViewのSectionsの宣言
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //tableViewのセルの数を宣言する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconList.count
    }
    
    //tableViewのセルを宣言して、セルの要素に値を入れる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableViewのセルを宣言
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath) as! ShopTableViewCell
        //cellの要素に値を入れる
        cell.shopIcon.image = UIImage(named: iconList[indexPath.row])
        cell.textShop.text = textList[indexPath.row]
        return cell
    }
    
    //tableViewのセルの高さを自動調整にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
