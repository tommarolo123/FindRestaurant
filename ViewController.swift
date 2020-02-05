//
//  ViewController.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //APIから受け取った情報を編集して、ShopViewControllerのtableViewに使う情報に使う
    var Phrase = [PhraseModel]()
    //レストランリストを表示するtableView
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableViewのUITableViewDelegate, UITableViewDataSourceを宣言する
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableViewのセルの高さを初期化し、自動的に調整するようにする
        tableView.estimatedRowHeight = 130.0
        tableView.rowHeight = UITableView.automaticDimension
        
        //APIから情報を取り出して編集してPhrase NSObjectに入れるメソッドの呼び出し
        getAPI(lat: ApiKey.latitude, long: ApiKey.longitude, ran: ApiKey.Range)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableViewのSectionsの宣言
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //tableViewのセルの数を宣言する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Phrase.count
    }
    //tableViewのセルを宣言して、セルの要素に値を入れる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) as! DetailTableViewCell
        cell.phrase = Phrase[indexPath.row]
        return cell
    }
    //tableViewのセルの高さを自動調整にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //セルを選択した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //グローバル変数SearchResultを選択されたセルの情報に更新する
        SearchResult = Phrase[indexPath.row]
        //選択されたレストランの詳しい情報を表示する画面に移る
        let des1 = storyboard?.instantiateViewController(withIdentifier: "ShopViewController")
        navigationController?.pushViewController(des1!, animated: true)
    }
    
    //APIから情報を取り出して編集してPhrase NSObjectに入れるメソッド
    func getAPI(lat:String,long:String,ran:Int){
        
        //SessionConfigを生成する
        let config: URLSessionConfiguration =  URLSessionConfiguration.default
        
        // Sessionを生成.
        let session: URLSession = URLSession(configuration: config, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        // 通信先のURLを生成.
        let url_string = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=b38e6dc2687c9e0f4f3f091d914c9f8d&latitude=\(lat)&longitude=\(long)&range=\(ran)"
        
        //url_stringのString型からURL型に変換する
        let url = URL(string: url_string)!
        
        // タスクの生成.
        let task: URLSessionDataTask = session.dataTask(with: url, completionHandler: { (data, response, err) -> Void in
            //APIから受け取ったデータ
            if data != nil {
                do {
                    //受け取ったデータを構造体Jsonに入れる
                    let array = try JSONDecoder().decode(Json.self, from: data!)
                    //以下は構造体に入れた情報を編集して、PhraseModel NSObjectに入れる
                    let count = array.rest?.count ?? 1
                    for i in 0..<(count){
                        let phrase = PhraseModel()
                        phrase.name = array.rest?[i].name ?? ""
                        let line = array.rest?[i].access?.line ?? ""
                        let station = array.rest?[i].access?.station ?? ""
                        let walk = array.rest?[i].access?.walk ?? ""
                        phrase.access = line + " [" + station + "] からおよそ" + walk + "分"
                        phrase.image = array.rest?[i].image_url?.shop_image1 ?? ""
                        if (phrase.image == ""){
                            phrase.image = array.rest?[i].image_url?.shop_image2 ?? ""
                        }
                        phrase.address = array.rest?[i].address ?? ""
                        phrase.tel = array.rest?[i].tel ?? ""
                        phrase.opentime = array.rest?[i].opentime ?? ""
                        phrase.holiday = array.rest?[i].holiday ?? ""
                        phrase.pr = array.rest?[i].pr?.pr_long ?? ""
                        
                        self.Phrase.append(phrase)
                        //tableViewのリードロードする
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch  {
                    
                }
                
            }
        })
        // タスクの実行
        task.resume()
    }
    
}

