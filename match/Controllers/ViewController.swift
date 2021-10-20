//
//  ViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/04.
//

import UIKit
import Koloda
import Firebase
import Nuke

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet var batsuButton : UIButton!
    @IBOutlet var okButton : UIButton!
    
    private let cellId = "cellId"
    
    private var users = [User]()
    private var myData : User!
    
    
    var images = ["miria2.jpg","maiyan.png","nanase.jpg","nanami.jpeg","manatsu.jpg","yoda.jpg","kuro.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        
        self.batsuButton.layer.cornerRadius = 25.0
        self.okButton.layer.cornerRadius = 25.0
        
        fetchUserInfoFromFireStore()
    }
    
    private func fetchUserInfoFromFireStore(){
        Firestore.firestore().collection("users").getDocuments { (snapshots, err) in
            if let err = err{
                print("user情報の取得に失敗しました",err)
                return
            }
            
            snapshots?.documents.forEach({ (snapshot) in
                let dic = snapshot.data()
                let user = User.init(dic: dic)
                
                guard let uid = Auth.auth().currentUser?.uid else {return}
                
                
                if uid == snapshot.documentID{
                    self.myData = user
                    return
                    
                }
                
                self.users.append(user)
                self.kolodaView.reloadData()
            })
        }
    }
    
    
    
}


extension ViewController: KolodaViewDataSource {
    
    //枚数
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return users.count
    }
    
    //ドラッグのスピード
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
    //表示内容
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView(frame: koloda.bounds)
        imageView.contentMode = .scaleAspectFit
        
        if let url = URL(string: users[index].profileImageUrl ?? ""){
            Nuke.loadImage(with: url, into: imageView)
        }else{
            imageView.image = UIImage(named: "miria2.jpg")
        }
        
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
    
    // フリックできる方向を指定する
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up]
    }
    
    //    フリックし終わったら呼ばれる
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        if direction.rawValue == "right"{
            guard let likeUser = users[index] as? User else {return}
            guard let likeUserUid = likeUser.uid as? String else {return}
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            let docData = [
                "email":likeUser.email,
                "username":likeUser.username,
                "createDate":Timestamp(),
                "profileImageUrl": likeUser.profileImageUrl,
                "userId":likeUserUid
            ] as [String:Any]
            
            
            Firestore.firestore().collection("users").document(uid).collection("likeUsers").document(likeUserUid).setData(docData){ [self](err) in
                if let err = err{
                    print("ライクユーザーの保存に失敗しました", err)
                    return
                }
                
                print("ライクユーザーの保存に成功しました")
                
            }
            
            Firestore.firestore().collection("users").document(likeUserUid).collection("likeUsers").document(uid).getDocument { (snapshot, err) in
                if let err = err{
                    print("自分user情報の取得に失敗しました",err)
                    return
                }
                
                
                if snapshot?.data() == nil{
                    print("マッチしませんでした")
                    return
                }else{
                    
                    let alert: UIAlertController = UIAlertController(title: "マッチしました！！", message: "メッセージを送りましょう！", preferredStyle:  UIAlertController.Style.alert)
                    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                            // ボタンが押された時の処理を書く（クロージャ実装）
                            (action: UIAlertAction!) -> Void in
                            print("OK")
                        })

                        // ③ UIAlertControllerにActionを追加
                        alert.addAction(defaultAction)

                        // ④ Alertを表示
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    let memebers = [uid, likeUserUid]
                    let memberNames = [self.myData.username,likeUser.username]
                    let memberProfileImageUrl = [self.myData.profileImageUrl,likeUser.profileImageUrl]
                    
                    let docData = [
                        "memebers": memebers,
                        "memeberNames": memberNames,
                        "memebersProfileImages": memberProfileImageUrl,
                        "createdAt": Timestamp()
                    ] as [String : Any]
                    
                    
                    Firestore.firestore().collection("match").addDocument(data: docData) { (err) in
                        if let err = err {
                            print("match情報の保存に失敗しました。\(err)")
                            return
                        }
                        print("match情報の保存に成功しました。")
                        
                        
                    }
                }
                
            }
            
            
        }else if direction.rawValue == "left"{
            guard let likeUser = users[index] as? User else {return}
            guard let likeUserUid = likeUser.uid as? String else {return}
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            let docData = [
                "email":likeUser.email,
                "username":likeUser.username,
                "createDate":Timestamp(),
                "profileImageUrl": likeUser.profileImageUrl,
                "userId":likeUserUid
            ] as [String:Any]
            
            Firestore.firestore().collection("users").document(uid).collection("unlikeUsers").document(likeUserUid).setData(docData){ [self](err) in
                if let err = err{
                    print("ノンライクユーザーの保存に失敗しました", err)
                    return
                }
                
                print("ノンライクユーザーの保存に成功しました")
                
            }
            
        }else{
            
            
        }
        
    }
    
    
    
}


