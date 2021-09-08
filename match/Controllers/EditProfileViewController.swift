//
//  EditProfileViewController.swift
//  match
//
//  Created by Rio Abe on 2021/08/22.
//

import UIKit
import Eureka
import Firebase

class EditProfileViewController: FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("名前")
            <<< TextRow("ニックネーム"){ row in
                row.title = "ニックネーム"
                row.placeholder = "ニックネームを入力"
            }.onChange{row in
            //            firebaseに該当する行の値を入れる
                
                self.saveUserInfo()
                        }
            +++ Section("自己紹介")
            <<< TextAreaRow("自己紹介"){ row in
                //                row.title = "自己紹介"
                row.placeholder = "こんにちは。"
            } //.onChange{row in
            //                self.userDefault.setValue(row.value, forKey: "Memo")
            //            }
            +++ Section("興味")
            <<< TextRow("興味"){ row in
                //                row.title = "自己紹介"
                row.placeholder = "ヒップホップ,ジム"
            }
            +++ Section("仕事")
            <<< TextRow("仕事"){ row in
                //                row.title = "自己紹介"
                row.placeholder = "仕事を追加"
            }
            +++ Section("")
            <<< ButtonRow("フォーム") {row in
                row.title = "完了"
            }
        saveUserInfo()
    }
    
    
     func saveUserInfo() {
        //        ユーザー取得
        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        
        let db = Firestore.firestore()
//        setData いけたけど既存データが消えたあああ
        db.collection("users").document(user.uid).setData([
            "displayName": "aa",
//            "introduction": "aa",
//            "hobby": "",
//            "work": "",
        ]) { error in
            if let error = error {
                // エラー処理
                print(error)
            }
          
        }
    }
}
