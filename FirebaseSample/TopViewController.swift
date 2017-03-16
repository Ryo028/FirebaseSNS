//
//  TopViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/15.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Material
import Firebase
import FirebaseStorageUI

class TopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var CardCollectionView: UICollectionView!
    
    // fetchしたデータを入れておく配列
    var contentArray: [FIRDataSnapshot] = []
    let ref = FIRDatabase.database().reference()
    let userID = (FIRAuth.auth()?.currentUser?.uid)!
    
    
//    let storage = FIRStorage.storage()
    let storageRef = FIRStorage.storage().reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
    
    var ciContext: CIContext!
    // 個別のデータ
    var topContentDic: [String: Any]! = [:]
    var imageArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // データの読み込み処理
        self.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = contentArray[indexPath.row]
        let itemImage = imageArray[indexPath.row]
        topContentDic = item.value as! Dictionary<String, AnyObject>
        topContentDic["Image"] = itemImage
        self.performSegue(withIdentifier: "ToSubView", sender: self)
        
        print(topContentDic)
        
//        print("Num: \(indexPath.row)")
//        print("Value:\(collectionView)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSubView" {
            let subViewController = segue.destination as! SubViewController
            // フォームのデータを次の画面に渡す
            subViewController.contentDic = self.topContentDic
        }
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
    
        let topViewLogic = TopViewLogic()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // テキストビューのスタイルを設定
        topViewLogic.setQuoTextViewStyle(cell: cell)
        
        let item = contentArray[indexPath.row]
        let content = item.value as! Dictionary<String, AnyObject>
        let personImgNo = (content["PersonImg"] as! String)
        // 名言を表示
        cell.quoTextView.text = (content["Quotation"] as! String)
        
        let imageRef = storageRef.child("images/" + userID + "/" + personImgNo)
        imageRef.downloadURL { (URL, error) -> Void in
            if (error != nil) {
                // Handle any errors
            } else {
                // 画像のダウンロード、キャッシュ
                cell.normalImage.sd_setImage(with: URL, placeholderImage: nil)
            }
        }
        
//        imageRef.data(withMaxSize: 20 * 1024 * 1024) { (data, error) in
//            if error == nil {
//                //                cell.cardView.contentView = cell.cardImage
//                //                cell.cardView.image = UIImage.init(data: data!)
//                self.imageArray.append(UIImage.init(data: data!)!)
//                //cell.normalImage.image = UIImage.init(data: data!)
//                cell.normalImage.image = UIImage.init(data: data!)
//                //cell.normalImage.
//            } else {
//                print(error as Any)
//            }
//        }
        
        return cell
    }

//    // 背景画像の名前を取得
//    func getImage(number: String) -> UIImage {
//        var iamge: UIImage
//    }
    
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
            contentArray.removeAll()
            
            // 一つになっているFIRDataSnapShotsを分割し、配列へ
            for item in snap.children {
                contentArray.append(item as! FIRDataSnapshot)
            }
            
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
    
    
//    fileprivate func setMaterial() {
//        let card = CardCollectionViewCell()
//        card.cardView.bottomBar = card.bottomBar
//    }
    
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

