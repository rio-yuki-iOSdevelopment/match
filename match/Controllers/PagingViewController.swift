//
//  TabmanViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/11/15.
//

import UIKit
import Tabman
import Pageboy

class PagingViewController: TabmanViewController ,TMBarDataSource {
    
    let bar = TMBar.ButtonBar()
    
    
    private lazy var viewControllers: [UIViewController] = {
        [
            storyboard!.instantiateViewController(withIdentifier: "UserListViewController"),
            storyboard!.instantiateViewController(withIdentifier: "ChatListViewController")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        bar.layout.transitionStyle = .snap
        
        addBar(bar.systemBar(), dataSource: self, at: .top)
        bar.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 70.0, bottom: 0.0, right: 70.0)
        
        bar.buttons.customize { (button) in
            button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.selectedTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        bar.indicator.overscrollBehavior = .compress
        bar.indicator.weight = .light
        

        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
           let titilename = ["マッチリスト","チャットリスト"]
           var items = [TMBarItem]()

           for i in titilename {
               let title = TMBarItem(title: i)
               items.append(title)
           }
           return items[index]
       }
    

}

extension PagingViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
}
