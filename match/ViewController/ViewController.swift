//
//  ViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/04.
//

import UIKit
import Koloda
import pop

private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.4

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    @IBOutlet var batsuButton : UIButton!
    @IBOutlet var okButton : UIButton!
    
    var images = ["miria2.jpg","maiyan.png","nanase.jpg","nanami.jpeg","manatsu.jpg","yoda.jpg","kuro.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        最初のカードの後ろの背景にあるカードの透明度の設定
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        
//        デフォルトで表示されるカード枚数
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        
//        背景のアニメーション適用
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        
        self.batsuButton.layer.cornerRadius = 25.0
        self.okButton.layer.cornerRadius = 25.0
        
        
        
    }
    
    
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
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
        
        //        カードの画像のUI
        let imageView = UIImageView(frame: koloda.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: images[index])
        
        imageView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
//        影
        imageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        koloda.addSubview(imageView)
        return imageView
    }
    
    
//    背景のカスタム設定・スワイプ時のカスタムアクションもoverlayStateプロパティのdidSetで設定可能(?)
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
            return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
        }
    
}


extension ViewController: KolodaViewDelegate {
    
    // カードを全て消費したときの処理を定義する
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        dataSourceからすべてのKolodaViewアイテムビューを再読み込みし、表示を更新
        koloda.reloadData()
    }
    
    //カードをタップした時に呼ばれる
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
        //        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    //    //dragやめたら呼ばれる
    //    func kolodaDidResetCard(_ koloda: KolodaView) {
    //        print("reset")
    //    }
    //
    //
    //    //darag中に呼ばれる
    //    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
    //        print(index, "drag")
    //        return true
    //    }
    
//    カードが表示されているときにリロード時に発生。コロダは表示アニメーションを適用させる
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
//    フロントカードのスワイプの開始時に発生。フロントカードをドラッグしてバックグラウンドカードを移動させる
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
//    コロダのレイアウトとスワイプ後に実行。コロダはフロントカードの下の次のカードを透過的にする。
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
//    POPAnimationが作成され、kolodaに渡され、スワイプ後のフレーム変更をアニメーション化
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
}


