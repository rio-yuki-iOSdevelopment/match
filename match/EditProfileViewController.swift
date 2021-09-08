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
                self.userDefault.setValue(row.value, forKey: "displayName")
            }
            +++ Section("自己紹介")
            <<< TextAreaRow("自己紹介"){ row in
                //                row.title = "自己紹介"
                row.placeholder = "こんにちは。"
            } .onChange{row in
                self.userDefault.setValue(row.value, forKey: "selfIntroduction")
            }
            +++ Section("興味")
            <<< TextRow("興味"){ row in
                //  row.title = "自己紹介"
                row.placeholder = "ヒップホップ,ジム"
            }.onChange{row in
                self.userDefault.setValue(row.value, forKey: "selfIntroduction")
            }
            
            +++ Section("仕事")
            <<< TextRow("仕事"){ row in
                //  row.title = "自己紹介"
                row.placeholder = "仕事を追加"
            }.onChange{row in
                self.userDefault.setValue(row.value, forKey: "work")
                
            }
            
            
            +++ Section("")
            <<< ButtonRow("フォーム") {row in
                
                row.title = "完了"
                
                row.onCellSelection{[unowned self] ButtonCellOf, row in
                    
                    // ユーザー取得
                    guard let user = Auth.auth().currentUser else {
                        // サインインしていない場合の処理をするなど
                        return
                    }
                    let db = Firestore.firestore()
                    //        setData いけたけど既存データが消えたあああ
                    db.collection("users").document(user.uid).setData([
                        "displayName": "",
                        "selfIntroduction": "",
                        "hobby": "",
                        "work": "",
                    ]) { error in
                        if let error = error {
                            // エラー処理
                            print(error)
                        }
                    }
                    self.userDefault.removeAll()
                }
            }
    }
}
