//
//  UserListViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/09/17.
//

import UIKit
import Firebase
import Nuke

class UserListViewController: UIViewController {

    @IBOutlet weak var userListTableView: UITableView!


    @IBOutlet weak var startChatButton: UIButton!



    private let cellId = "cellId"

    private var matchs = [Match]()

    private var selectedMatch : Match!
    var users = [User]()
    var selectedUser : User!


    override func viewDidLoad() {
        super.viewDidLoad()

        userListTableView.delegate = self
        userListTableView.dataSource = self

//        startChatButton.layer.cornerRadius = 15
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

//        startChatButton.isEnabled = false
//        startChatButton.addTarget(self, action: #selector(tappedStartChatButton), for: .touchUpInside)

        fetchUserInfoFromFireStore()
    }


    @objc func tappedStartChatButton() {
            print("tappedStartChatButton")
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let partnerUid = self.selectedMatch?.documentId else { return }
            let memebers = [uid, partnerUid]

            let docData = [
                "memebers": memebers,
                "latestMessageId": "",
                "createdAt": Timestamp()
                ] as [String : Any]

            Firestore.firestore().collection("chatRooms").addDocument(data: docData) { (err) in
                if let err = err {
                    print("ChatRoom情報の保存に失敗しました。\(err)")
                    return
                }
                print("ChatRoom情報の保存に成功しました。")
                self.dismiss(animated: true, completion: nil)


            }

        }


    //    会員情報の取得
    private func fetchUserInfoFromFireStore(){
        Firestore.firestore().collection("match").whereField("memebers", arrayContains: Auth.auth().currentUser?.uid)
            .getDocuments { (snapshots, err) in
            if let err = err{
                print("user情報の取得に失敗しました",err)
                return
            }

            snapshots?.documents.forEach({ (snapshot) in
                let dic = snapshot.data()
                let match = Match.init(dic: dic)
                print(snapshot.documentID)
                guard let uid = Auth.auth().currentUser?.uid else {return}

                if match.members.contains(uid){

                    self.matchs.append(match)

                }


                self.userListTableView.reloadData()

            })


        }

    }

}



extension UserListViewController:UITableViewDelegate,UITableViewDataSource{




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchs.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = userListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserListTableViewCell
        cell


           return cell
       }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped table view")

        startChatButton.isEnabled = true
        let user = users[indexPath.row]

        print(user.username)
        self.selectedUser = user


    }




}



class UserListTableViewCell: UITableViewCell {

//    var match : Match?{
//        didSet{
//
//            userNameLabel.text = user?.username
//
//            if let url = URL(string: user?.profileImageUrl ?? ""){
//
//                Nuke.loadImage(with: url, into: userImageView)
//
//            }
//
//        }
//    }


    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 25


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
