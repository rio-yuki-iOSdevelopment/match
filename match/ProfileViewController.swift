//
//  ProfileViewController.swift
//  match
//
//  Created by Rio Abe on 2021/08/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageViewを丸くする
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
        profileData()
        
        
       
    }
    //    プロフィール読み込み
    func profileData() {
        
        //Firebaseから現在ログインしているユーザーのuidを取得
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        print(uid)
        
        //特定のドキュメントのデータ、ここを現在ログイン中のIDにする
               Firestore.firestore().collection("users").document("73cBoLrwf0dekXF1GVerrM22MOw2").getDocument { (snap, error) in
//                   if let error = error {
//                       print(error)
//                   }
                guard let data = snap?.data() else { return }
                   print(data)
               
                let text = document.data()["text"] as! String
                let title = document.data()["title"] as! String

                print("text: \(text)")
                print("title: \(title)"

               )}
               }
               }
        
//       1, let docRef = db.collection("users").document("uid")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let property = document.get("email")
//                print(property)
//            } else {
//                print("error")
//            }
//        }
        
//        ！2、特定のドキュメントのデータ、ここを現在ログイン中のIDにする
//        Firestore.firestore().collection("users").document("73cBoLrwf0dekXF1GVerrM22MOw2").getDocument { (snap, error) in
//            if let error = error {
//                print(error)
//            }
//            guard let data = snap?.data() else { return }
//            print(data)
//
//        }
        
//       3, db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print(error)
//            }
//            if let document = querySnapshot?.documents.first {
//                self.userNameLabel.text = uid
////                self.userNameLabel.text = document.data()["username"] as? String ?? ""
//                print(uid)
//            }
//        }


