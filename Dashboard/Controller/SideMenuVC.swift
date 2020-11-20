//
//  SideMenuVC.swift
//  Dashboard
//
//  Created by Xanthus Software Solutions on 31/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuVC: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!
    let titles = ["Revenue", "Production", "Add Package", "Customer Package", "Assign Widget", "Assign Role", "Configuration API", "Customer Overview", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuTableView.reloadData()
//        SideMenuManager.default.menuPushStyle = .popWhenPossible
    }

}

extension SideMenuVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "SideMenuToRevenue", sender: self)
            break
        case 1:
            performSegue(withIdentifier: "SideMenuToProduction", sender: self)
            break
        default:
            break
        }
    }
}
