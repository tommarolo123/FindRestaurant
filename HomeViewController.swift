//
//  HomeViewController.swift
//  findRestaurant
//
//  Created by Son on 2019/03/21.
//  Copyright © 2019 com.is151050. All rights reserved.
//

import UIKit
import MapKit

var ApiKey = PhraseApi()
var SearchResult = PhraseModel()

class HomeViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    //mapView、locationManagerとpickerViewの宣言
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pickerView: UIPickerView!
    var locationManager: CLLocationManager!
    //pickerViewに表示するデータの配列
    let list: [String] = ["300m", "500m", "1000m", "2000m", "3000m"]
    
    //検索ボタンをクリックした時の処理
    @IBAction func searchButton(_ sender: Any) {
        changeViewControl(range: ApiKey.Range)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocation()
        setRange()
    }
    
    //location機能の起動、許可を求める
    func myLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        //mapViewの設定
        mapView.setRegion(region,animated:true)
        mapView.mapType = MKMapType.standard
        mapView.userTrackingMode = MKUserTrackingMode.follow
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
    }
    
    // ピッカー設定
    func setRange(){
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
    }
    //画面を変換するメソッド
    func changeViewControl(range:Int){
        let des1 = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(des1!, animated: true)
    }
    //Location機能を求める
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    //locationが変更された時の処理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                return
        }
        //グローバル変数ApiKeyのlatitude、longitudeを変える
        ApiKey.latitude = "\(newLocation.coordinate.latitude)"
        ApiKey.longitude = "\(newLocation.coordinate.longitude)"
    }
    
    
    
}

extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    //ドラムロールのタイトルを選択した時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ApiKey.Range = row + 1
    }
    
}
