//
//  ViewController.swift
//  0909
//
//  Created by 松平礼史 on 2018/09/09.
//  Copyright © 2018年 松平礼史. All rights reserved.
//

import UIKit
import Social
import Alamofire
import Sketch


class ViewController: UIViewController {
    

    @IBOutlet weak var sketchView: SketchView!
    
    
    @IBAction func undo(_ sender: Any) {
        sketchView.undo()
    }
    
    @IBAction func redo(_ sender: Any) {
        sketchView.redo()
    }
    

    @IBAction func allClear(_ sender: Any) {
        sketchView.clear()
    }
    
    @IBAction func switchToPen(_ sender: Any) {
        sketchView.drawTool = SketchToolType.pen
    }
    
    @IBAction func switchToEraser(_ sender: Any) {
        sketchView.drawTool = SketchToolType.eraser
    }
    
    @IBAction func circle(_ sender: Any) {
        sketchView.drawTool = SketchToolType.ellipseStroke
    }
    
    @IBAction func square(_ sender: Any) {
        sketchView.drawTool = SketchToolType.rectangleStroke

    }
    
    @IBAction func arrow(_ sender: Any) {
        sketchView.drawTool = SketchToolType.arrow

    }
    
    @IBAction func switchToNeon(_ sender: Any) {
        sketchView.drawingPenType = PenType.neon
    }
    
    
    @IBAction func switchToBlur(_ sender: Any) {
        sketchView.drawingPenType = PenType.blur
    }
    
    @IBAction func save(_ sender: Any) {

        print(sketchView.GetImage())
        
//        hyojiView.image = sketchView.GetImage()
        
//        resizeImage(image :sketchView.GetImage(), w:375, h:375)
        
//        print(resizeImage(image :sketchView.GetImage(), w:375, h:375))
        
        UIImageWriteToSavedPhotosAlbum(sketchView.GetImage(), nil, nil, nil)
        
        displayAlert()
    }
    
//    func resizeImage(image :UIImage, w:Int, h:Int) ->UIImage
//    {
//        // アスペクト比を維持
//        let origRef    = image.cgImage
//        let origWidth  = Int(origRef!.width)
//        let origHeight = Int(origRef!.height)
//        var resizeWidth:Int = 0, resizeHeight:Int = 0
//        if (origWidth < origHeight) {
//            resizeWidth = w
//            resizeHeight = origHeight * resizeWidth / origWidth
//        } else {
//            resizeHeight = h
//            resizeWidth = origWidth * resizeHeight / origHeight
//        }
//
//        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
//
//        UIGraphicsBeginImageContextWithOptions(resizeSize, false, 0.0)
//
//        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
//
//        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return resizeImage!
//    }
    
    
    func displayAlert() {
        let title = "画像を保存しました"
        let message = ""
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
//    private func saveImage (image: UIImage, fileName: String ) -> Bool{
//        //pngで保存する場合
//        let pngImageData = UIImagePNGRepresentation(image)
//        // jpgで保存する場合
//        //    let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
//        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
//        let fileURL = documentsURL.appendingPathComponent(fileName)
//        do {
//            try pngImageData!.write(to: fileURL)
//        } catch {
//            //エラー処理
//            return false
//        }
//        return true
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SketchView {
    
    func GetImage() -> UIImage{
        
        // キャプチャする範囲を取得.
        let rect = self.bounds
        
        // ビットマップ画像のcontextを作成.
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 対象のview内の描画をcontextに複写する.
        self.layer.render(in: context)
        
        // 現在のcontextのビットマップをUIImageとして取得.
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // contextを閉じる.
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
}

