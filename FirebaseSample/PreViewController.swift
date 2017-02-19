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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // プレビューの画面設定
        self.setPreviewScroll()
        
        print(self.formDataDic)
        
        let name = (self.formDataDic["Name"] as! String)
        let quo = (self.formDataDic["Quo"] as! String)
        let imageData = self.formDataDic["Pic"]
        print(name)
        self.previewQuo.text = quo
        self.previewName.text = name
        self.previewImageView.image = imageData as? UIImage
        
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
