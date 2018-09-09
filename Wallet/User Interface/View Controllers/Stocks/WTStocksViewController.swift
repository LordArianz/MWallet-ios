//
//  WTStocksViewController.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/9/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTStocksViewController: WTViewController, UITableViewDelegate, UITableViewDataSource {

    let selector: WTSelector = WTSelector()
    let tableView: UITableView = UITableView()
    let chartView: UIView = UIView()
    let gradientLayer: CAGradientLayer = CAGradientLayer()

    var stocks: [String]?
    
    var currentIndex: Int = 0 {
        didSet {
            //print(currentIndex)
        }
    }

    override func loadView() {
        super.loadView()
        selector.items = [WTSelectorItem(image: nil, title: String.localized("WT.Stocks.Overview")),
                          WTSelectorItem(image: nil, title: String.localized("WT.Stocks.Mine"))]
        selector.onSelect = { [unowned self] (index) in
            self.currentIndex = index
        }
        selector.setCorner(radius: 5)
        selector.layer.borderColor = WTColor.wt_selectorBorder.cgColor
        selector.layer.borderWidth = 1
        selector.clipsToBounds = true
        
        tableView.backgroundColor = WTColor.wt_DarkCardText
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0, y: -1)
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [WTColor.wt_stocksChartTop.cgColor, WTColor.wt_stocksChartBottom.cgColor]

        chartView.layer.addSublayer(gradientLayer)
        self.view.addSubview(selector)
        self.view.addSubview(tableView)
        self.view.addSubview(chartView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(String.localized("WT.Tab.Stocks"))
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let selectorMargin: CGFloat = 10
        let chartHeight: CGFloat = self.view.frame.size.width * 0.488
        selector.frame = CGRect(x: selectorMargin, y: selectorMargin, width: self.view.frame.size.width - 2 * selectorMargin, height: 50)
        chartView.frame = CGRect(x: 0, y: self.view.frame.size.height - chartHeight, width: self.view.frame.size.width, height: chartHeight)
        tableView.frame = CGRect(x: 0, y: selector.frame.size.height + selector.frame.origin.y + selectorMargin, width: self.view.frame.size.width, height: chartView.frame.origin.y - (selector.frame.size.height + selector.frame.origin.y + selectorMargin))
        gradientLayer.frame = chartView.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: WTStockCell? = tableView.dequeueReusableCell(withIdentifier: WTStockCell.reuseIdentifier) as? WTStockCell
        if cell == nil {
            cell = WTStockCell((indexPath.row > 0 && indexPath.row < 4) ? .positive : .negative)
        }
        switch indexPath.row {
        case 0:
            cell?.titleLabel.text = "AAPL"
            cell?.changeLabel.text = "-۵۶.۳۳"
            cell?.idkLabel.text = "۰.۲۱٪"
            cell?.valueLabel.text = "۶,۳۷۰.۵۹"
        case 1:
            cell?.titleLabel.text = "SBUX"
            cell?.changeLabel.text = "+۲۳.۱۴"
            cell?.idkLabel.text = "۰.۲۱٪"
            cell?.valueLabel.text = "۵۴.۵۵"
        case 2:
            cell?.titleLabel.text = "YHOO"
            cell?.changeLabel.text = "+۲.۰۲"
            cell?.idkLabel.text = "۰.۲۱٪"
            cell?.valueLabel.text = "۴۱.۵۵"
        case 3:
            cell?.titleLabel.text = "NKE"
            cell?.changeLabel.text = "+۲۱.۲۳"
            cell?.idkLabel.text = "۰.۲۱٪"
            cell?.valueLabel.text = "۵۳.۲۳"
        case 4:
            cell?.titleLabel.text = "DOW J"
            cell?.changeLabel.text = "-۴۹.۴۲"
            cell?.idkLabel.text = "۰.۲۱٪"
            cell?.valueLabel.text = "۲۲,۲۹۶.۰۶"
        default:
            break
        }
        
        return cell!
    }
}
