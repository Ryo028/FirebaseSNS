//
//  FirstViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/15.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Material
import Firebase

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var CardCollectionView: UICollectionView!
        
    // fetchしたデータを入れておく配列
    var contentArray: [FIRDataSnapshot] = []
    let ref = FIRDatabase.database().reference()
    let userID = (FIRAuth.auth()?.currentUser?.uid)!
    
     var ciContext: CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // データの読み込み処理
        self.read()
        //setMaterial()
//        let cardMaterial = CardCollectionViewCell()
//        cardMaterial.setMaterialCell()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("Value:\(collectionView)")
        
    }
    
    /*
     Cellの総数を返す
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    /*
     Cellに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        let item = contentArray[indexPath.row]
        let content = item.value as! Dictionary<String, AnyObject>
        
        // optinal型をunwrap
        cell.cardLable.text = (content["Quotation"] as! String)
        //cell.cardView.bottomBar = cell.bottomBar
        
        let personImgNo = (content["PersonImg"] as! String)
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
        let riversRef = storageRef.child("images/" + userID + "/" + personImgNo)
        riversRef.data(withMaxSize: 20 * 1024 * 1024) { (data, error) in
            if error == nil {
//                cell.cardView.contentView = cell.cardImage
//                cell.cardView.image = UIImage.init(data: data!)
                cell.normalImage.image = UIImage.init(data: data!)
                //cell.normalImage.image = outputImage

                cell.normalImage.layer.cornerRadius = 5
                cell.normalImage.layer.masksToBounds = true

                
            } else {
                print(error as Any)
            }
        }
        return cell
    }
    
    // データの読み込み処理
    func read() {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる        
        print("ユーザーID : \(userID)")
        ref.child(userID).observe(.value, with: { (snapShots: FIRDataSnapshot) in
            if snapShots.children.allObjects is [FIRDataSnapshot] {
                //print("snapShots.children...\(snapShots.childrenCount)") //いくつのデータがあるかプリント
                
                //print("snapShot...\(snapShots)") //読み込んだデータをプリント
            }
            
            self.reload(snap: snapShots)
            
        })
    }

    func reload(snap: FIRDataSnapshot) {
        if snap.exists() {
            // FIRDataSnapShotsが存在するか確認
            //print(snap)
            contentArray.removeAll()
            
            // 一つになっているFIRDataSnapShotsを分割し、配列へ
            for item in snap.children {
                contentArray.append(item as! FIRDataSnapshot)
            }
                        
            //print(contentArray[0])
            
            // ローカルデータベースを更新
            ref.child(userID).keepSynced(true)
            self.CardCollectionView.reloadData()
        }
    }

    // タイムスタンプを整形
    func getDate(number: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: number)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
    
    
    fileprivate func setMaterial() {
        let card = CardCollectionViewCell()
        card.cardView.bottomBar = card.bottomBar
    }
    
    fileprivate func setFilter(cell: UICollectionViewCell) {
//        // UIImageをCIImageにキャスト
//        let filterImage = CIImage(image: cell.normalImage.image!)
//        // フィルターを選ぶ
//        let filter = CIFilter(name: "CIVignette")
//        //イメージをセット
//        filter?.setValue(filterImage, forKey: "inputImage")
//        filter!.setValue(NSNumber(value: 5.0), forKey: "inputIntensity")
//        
//        self.ciContext = CIContext(options: nil)
//        let imageRef = self.ciContext.createCGImage((filter?.outputImage)!, from: (filter?.outputImage!.extent)!)
//        let outputImage = UIImage(cgImage: imageRef!)
    }
    
}

