//
//  ViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/04.
//

import UIKit
import Koloda

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet var batsuButton : UIButton!
    @IBOutlet var okButton : UIButton!
    
    var images = ["miria2.jpg","maiyan.png","nanase.jpg","nanami.jpeg","manatsu.jpg","yoda.jpg","kuro.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        
        self.batsuButton.layer.cornerRadius = 25.0
        self.okButton.layer.cornerRadius = 25.0
        
        
    }
    
    
}


extension ViewController: KolodaViewDataSource {
    
    //枚数
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    //ドラッグのスピード
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
    //表示内容
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView(frame: koloda.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: images[index])
        koloda.addSubview(imageView)
        return imageView
    }
    
    
}


extension ViewController: KolodaViewDelegate {
    
    // カードを全て消費したときの処理を定義する
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    //カードをタップした時に呼ばれる
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    //dragやめたら呼ばれる
    func kolodaDidResetCard(_ koloda: KolodaView) {
        print("reset")
    }
    
    
    //darag中に呼ばれる
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
        print(index, "drag")
        return true
    }
    
    
}


