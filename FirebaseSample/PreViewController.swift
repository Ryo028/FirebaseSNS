//
//  PreViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/02/12.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
//import Material

class PreViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var previewScrollView: UIScrollView!
    @IBOutlet weak var previewQuo: UITextView!
    @IBOutlet weak var previewName: UILabel!
    
    public var formDataDic: [String: Any]! = [:]
    private var myRightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myRightButton = UIBarButtonItem(title: "投稿", style: .plain, target: self, action: #selector(PreViewController.onClick(sender:)))
        self.navigationItem.rightBarButtonItem = myRightButton

        
        // プレビューの画面設定
        self.setPreviewScroll()
        
        print(self.formDataDic)
        
        let name = (self.formDataDic["Name"] as! String)
        let quo = (self.formDataDic["Quo"] as! String)
        let imageData = self.formDataDic["Pic"] as? UIImage
        self.previewQuo.text = quo
        self.previewName.text = name
        
        // 画像に名言を埋め込み
        let quoImage = drawText(image: imageData!, quoText: quo)
        self.previewImageView.image = quoImage
        self.formDataDic["Pic"] = quoImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // スクロールビューの設定
    private func setPreviewScroll() {
        self.previewScrollView.delegate = self
        self.previewScrollView.minimumZoomScale = 1 // 最小　１倍
        self.previewScrollView.maximumZoomScale = 8 // 最大　8倍
        self.previewScrollView.isScrollEnabled = true // スクロールを許可
        // 縦方向と、横方向のスクロール状態のバーの表示・非表示
        self.previewScrollView.showsVerticalScrollIndicator = true
        self.previewScrollView.showsHorizontalScrollIndicator = true
        
        //UIImageの画像サイズに自動的に合わせてくれる
        self.previewImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        // 角丸を設定
        self.previewImageView.layer.cornerRadius = 5
        self.previewImageView.layer.masksToBounds = true

        
        //        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
        //        doubleTapGesture.numberOfTapsRequired = 2 // タップを二回
        //        self.previewImage.addGestureRecognizer(doubleTapGesture)

    }
    
    // 投稿処理
    internal func onClick(sender: UIButton) {
        let fireAccess = FireAccess()

        // ekurakaのformの値を取得
        //let formValue = form.values()
        //print(String(describing: type(of: formValue)))
        
        // 投稿するデータをfirebaseに送信
        fireAccess.sentFormData(formValueDic: self.formDataDic)
    }
    
    // 画像に名言と名前を埋め込む処理
    private func drawText(image: UIImage, quoText: String) -> UIImage {
        
        // 文字の太さを指定
        let font = UIFont.boldSystemFont(ofSize: 25)
        // 描画領域を生成
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        // 画像をPDFに変換
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: imageRect)
        
        let quoRect = CGRect(x: 0, y: CGFloat(image.size.height / 2), width: image.size.width - 5 , height: image.size.height)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.white,
            NSParagraphStyleAttributeName: textStyle
        ]
        quoText.draw(in: quoRect, withAttributes: textFontAttributes)
        
        //self.previewQuo.draw(imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
    // ズーム中のビューを返す
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //print("pinch")
        return self.previewImageView
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        print("doubleTap")
        if self.previewScrollView.zoomScale < self.previewScrollView.maximumZoomScale {
            let newScale = self.previewScrollView.zoomScale * 3
            let zoomRect = self.zoomRectForSacle(scale: newScale, center: gesture.location(in: gesture.view))
            self.previewScrollView.zoom(to: zoomRect, animated: true)
        } else {
            self.previewScrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRectForSacle(scale: CGFloat, center: CGPoint) -> CGRect {
        print("doubleTap")
        let size = CGSize(
            width: self.previewScrollView.frame.size.width / scale,
            height: self.previewScrollView.frame.size.height / scale
        )
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
}
