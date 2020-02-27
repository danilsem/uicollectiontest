//
//  ViewController.swift
//  CollectionView
//
//  Created by Admin on 26/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var doorCollection: UICollectionView!
    
    let data: String = "{\"data\":[{\"id\":1,\"title\":\"DELTA-M 10 COMBO\",\"price\":13800,\"images\":[\"https://190601.selcdn.ru/torex.ru/iblock/103/1031387b5aa055bec9753d972fc3861a/9cd72ae6e39a5550aa12416ce755b221_outside.png\",\"https://190601.selcdn.ru/torex.ru/iblock/947/947eee537598a6dc4f8cb368f7e9e0ef/d934de7c349ba95b51c4906435ddb951_inside.png\"],\"description\":\"Серия Delta M - это все основные составляющие, благодаря которым дверь получается надежной в эксплуатации: качественные материалы, замки, фурнитура. Delta M - это базовые защитные свойства и доступная цена.\",\"weight\":71},{\"id\":2,\"title\":\"SNEGIR 55\",\"price\":13800,\"images\":[\"https://190601.selcdn.ru/torex.ru/iblock/68f/68fc51f612e0ef512b4b767409a3c8ae/20ecac19da59fa4d388d8c6099e64048_outside.png\",\"https://190601.selcdn.ru/torex.ru/iblock/28f/28f2fa3504c2b4531f474d09d4142002/cb7314bdb1c0036f4826db13cac3eccd_inside.png\"],\"description\":\"Snegir 55 - всепогодная дверь с терморазрывами в коробе и полотне. В дождь, снег и зной она будет сохранять в Вашем доме комфорт и уют, благодаря трехкомпонентному заполнению полотна, тройному контуру уплотнителей и отсутствие мостиков холода.\",\"weight\":120},{\"id\":3,\"title\":\"SNEGIR 55\",\"price\":13800,\"images\":[\"https://190601.selcdn.ru/torex.ru/iblock/68f/68fc51f612e0ef512b4b767409a3c8ae/20ecac19da59fa4d388d8c6099e64048_outside.png\",\"https://190601.selcdn.ru/torex.ru/iblock/28f/28f2fa3504c2b4531f474d09d4142002/cb7314bdb1c0036f4826db13cac3eccd_inside.png\"],\"description\":\"Snegir 55 - всепогодная дверь с терморазрывами в коробе и полотне. В дождь, снег и зной она будет сохранять в Вашем доме комфорт и уют, благодаря трехкомпонентному заполнению полотна, тройному контуру уплотнителей и отсутствие мостиков холода.\",\"weight\":120}, ],\"isSuccess\":true}"
    
    var doors: Array<Door>? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            let json = JSON.init(parseJSON: data)
            
            for item in json["data"].array! {
                
                let door = Door(id: item["id"].int!, title: item["title"].string!, price: item["price"].int!, images: item["images"].arrayObject!, description: item["description"].string!, weight: item["weight"].int!)
                
                doors?.append(door)
                
            }
            
            self.doorCollection.dataSource = self
            self.doorCollection.delegate = self
            
        }
        catch  {
            print("Can't read json data")
        }
        
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doors!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        do {
            let door = doors![indexPath.row]
            
            let str = door.imageUrls[0] as! String
            let url = URL(string: str)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doorViewCell", for: indexPath) as! DoorViewCell
            
            cell.image.image = try UIImage(data: Data(contentsOf: url!))
            cell.titleLabel.text = door.title
            cell.priceLabel.text = "от \(door.price) руб."
            
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.3
            cell.layer.cornerRadius = 3
            
            return cell
        }
        catch {
            print("Error to load image")
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let door = doors?[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(identifier: "DoorViewController") as! DoorViewController
        
        vc.door = door
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

class Door {
    let id: Int
    let title: String
    let price: Int
    let imageUrls: Array<Any>
    let description: String
    let weight: Int
    
    init(id: Int, title: String, price: Int, images: Array<Any>, description: String, weight: Int) {
        self.id = id
        self.title = title
        self.price = price
        self.imageUrls = images
        self.description = description
        self.weight = weight
    }
}
