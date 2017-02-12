//
//  PreViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/02/12.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit

class PreViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // スクロールビューの設定
        self.previewScroll.delegate = self
        self.previewScroll.minimumZoomScale = 1 // 最小　１倍
        self.previewScroll.maximumZoomScale = 8 // 最大　8倍
        self.previewScroll.isScrollEnabled = true // スクロールを許可
        // 縦方向と、横方向のスクロール状態のバーの表示・非表示
        self.previewScroll.showsVerticalScrollIndicator = true
        self.previewScroll.showsHorizontalScrollIndicator = true
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2 // タップを二回
        self.previewImage.addGestureRecognizer(doubleTapGesture)
        
        let personImg = UIImage(named: "jobs.jpg")
        self.previewImage.image = personImg
        //UIImageの画像サイズに自動的に合わせてくれる
        //previewImage = UIImageView(image: personImg)
        previewImage.contentMode = UIViewContentMode.center
        
        self.previewScroll.addSubview(previewImage)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ズーム中のビューを返す
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //print("pinch")
        return self.previewImage
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        print("doubleTap")
        if self.previewScroll.zoomScale < self.previewScroll.maximumZoomScale {
            let newScale = self.previewScroll.zoomScale * 3
            let zoomRect = self.zoomRectForSacle(scale: newScale, center: gesture.location(in: gesture.view))
            self.previewScroll.zoom(to: zoomRect, animated: true)
        } else {
            self.previewScroll.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRectForSacle(scale: CGFloat, center: CGPoint) -> CGRect {
        print("doubleTap")
        let size = CGSize(
            width: self.previewScroll.frame.size.width / scale,
            height: self.previewScroll.frame.size.height / scale
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
