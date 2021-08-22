//
//  EditProfileViewController.swift
//  match
//
//  Created by Rio Abe on 2021/08/22.
//

import UIKit
import Eureka

class EditProfileViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("名前")
            <<< TextRow("ニックネーム"){ row in
                row.title = "ニックネーム"
                row.placeholder = "ニックネームを入力"
            }//.onChange{row in
            ///             firebaseに保存するコード
            //                self.userDefault.setValue(row.value, forKey: "Title")
            //            }
            +++ Section("自己紹介")
            <<< TextAreaRow("自己紹介"){ row in
//                row.title = "自己紹介"
                row.placeholder = "こんにちは。"
            } //.onChange{row in
//                self.userDefault.setValue(row.value, forKey: "Memo")
//            }
            +++ Section("興味")
            <<< TextAreaRow("興味"){ row in
//                row.title = "自己紹介"
                row.placeholder = "ヒップホップ,ジム"
            }
            +++ Section("")
                 <<< ButtonRow("フォーム") {row in
                     row.title = "完了"
//                     row.onCellSelection{[unowned self] ButtonCellOf, row in
//                         let object = NCMBObject(className: "Post")
//                         object?.setObject(NCMBUser.current(), forKey: "user")
//                         object?.setObject(self.userDefault.string(forKey: "Title"), forKey: "Title")
//                         object?.setObject(self.userDefault.string(forKey: "Memo"), forKey: "Memo")
//                         object?.setObject(self.userDefault.object(forKey: "Date")as! Date, forKey: "Date")
//                         object?.setObject(self.userDefault.string(forKey: "Satisfaction"), forKey: "Satisfaction")
//                         object?.saveInBackground({ (error) in
//                             if error != nil{
//                                 print(error)
//                             } else {
//                                 let alertController = UIAlertController(title: "投稿完了", message: "内容が投稿されました", preferredStyle: .alert)
//                                 let action = UIAlertAction(title: "確認", style: .default) { (action) in
//                                     self.navigationController?.popViewController(animated: true)
//                                 }
//                                 alertController.addAction(action)
//                                 self.present(alertController, animated: true, completion: nil)
//
//                             }
//                         })
//                         self.userDefault.removeAll()
//
//                     }
//             }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
}
