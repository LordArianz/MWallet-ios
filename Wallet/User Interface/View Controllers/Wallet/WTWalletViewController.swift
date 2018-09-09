//
//  WTWalletViewController.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTWalletViewController: WTViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var factors: [String]?
    var services: [String]?
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(String.localized("WT.Tab.Wallet"))
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return factors?.count ?? 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            let rows = ((services?.count ?? 4) / 2 + (services?.count ?? 4) % 2)
            return CGFloat(CGFloat(rows) * (self.view.frame.size.width * 0.325))
        case 2:
            return 50
        case 3:
            return 76
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell: WTBalanceCell? = tableView.dequeueReusableCell(withIdentifier: WTBalanceCell.reuseIdentifier) as? WTBalanceCell
            if cell == nil {
                cell = WTBalanceCell()
            }
            cell?.valueLabel.text = Int("175000")?.priceFormat
            return cell!
        } else if indexPath.section == 1 {
            var cell: WTWalletServicesCell? = tableView.dequeueReusableCell(withIdentifier: WTWalletServicesCell.reuseIdentifier) as? WTWalletServicesCell
            if cell == nil {
                cell = WTWalletServicesCell()
            }
            return cell!
        } else if indexPath.section == 2 {
            var cell: WTFactorsHeaderCell? = tableView.dequeueReusableCell(withIdentifier: WTFactorsHeaderCell.reuseIdentifier) as? WTFactorsHeaderCell
            if cell == nil {
                cell = WTFactorsHeaderCell()
            }
            return cell!
        } else {
            var cell: WTSimpleFactorCell? = tableView.dequeueReusableCell(withIdentifier: WTSimpleFactorCell.reuseIdentifier) as? WTSimpleFactorCell
            if cell == nil {
                cell = WTSimpleFactorCell()
            }
            cell?.titleLabel.text = "آسیاتک"
            cell?.valueLabel.text = "۲۷۰,۰۰۰ تومان"
            cell?.detailLabel.text = "تمدید قرارداد اینترنت"
            cell?.dateLabel.text = "۱۳۹۷/۳/۱۵"
            return cell!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

}
