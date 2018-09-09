//
//  WTCardsViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTCardsViewController: WTViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {

    var tableView: UITableView!
    var cards: [String]?//[WTCard]?
    var mode: WTCardCellMode = .cozy {
        didSet { /*tableView.reloadData()*/ modeChanged() }
    }
    var headerCell: WTCardHeaderCell?
    var addVC: WTAddCardViewController = WTAddCardViewController()

    var parentVCBG: UIView!
    
    override func loadView() {
        super.loadView()
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        parentVCBG = UIView()
        parentVCBG.backgroundColor = WTColor.wt_ParentVCBackground
        self.view.addSubview(tableView)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(String.localized("WT.Tab.Cards"))
        self.setRightItem(icon: "icon-bar-add") { [unowned self] (addButton) in
            print("addesh kon")
            //var vc = UIViewController()
            //vc.view.backgroundColor = WTColor.wt_ParentVCBackground
            //self.present(vc, animated: true, completion: {})
//            if let window: UIWindow = UIApplication.shared.keyWindow {
//                self.parentVCBG.frame = window.bounds
//                window.subviews[0].addSubview(self.parentVCBG)
//            }
            self.present(self.addVC, animated: false, completion: nil)

        }
        tableView.delegate = self
        tableView.dataSource = self
        addVC.modalPresentationStyle = .custom
        //addVC.transitioningDelegate = self
        //addVC.view.backgroundColor = WTColor.wt_BarBackground
        //addVC.view.setCorner(radius: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    func modeChanged() {
        tableView.beginUpdates()
        var indexPaths: [IndexPath] = []
        for i in 0..<self.tableView(tableView, numberOfRowsInSection: 1) {
            indexPaths.append(IndexPath.init(row: i, section: 1))
        }
        tableView.reloadRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cards?.count ?? 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 30
        case 1:
            return mode == .cozy ? 165 : 70
        default:
            return 0
        }
    }
    
    var animating: Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if !animating {
            if y > 30 {
                if headerCell?.cozyView.superview is WTCardHeaderCell {
                    animating = true
                    UIView.animate(withDuration: 0.1, animations: { [unowned self] () in
                        self.headerCell?.cozyButton.alpha = 0
                        self.headerCell?.compactButton.alpha = 0
                    }, completion: { [unowned self] (true) in
                        self.navigationItem.leftBarButtonItems =
                            [UIBarButtonItem.init(customView: self.headerCell!.cozyView),
                             UIBarButtonItem.init(customView: self.headerCell!.compactView)]
                        self.headerCell?.cozyView.transform = .init(translationX: 0, y: 7)
                        self.headerCell?.compactView.transform = .init(translationX: 0, y: 7)
                        UIView.animate(withDuration: 0.2, animations: { [unowned self] () in
                            self.headerCell?.cozyView.alpha = 1
                            self.headerCell?.compactView.alpha = 1
                            self.headerCell?.cozyView.transform = .identity
                            self.headerCell?.compactView.transform = .identity
                        }) { [unowned self] (true) in
                            self.animating = false
                        }
                    })
                }
            } else {
                if !(headerCell?.cozyView.superview is WTCardHeaderCell) {
                    animating = true
                    UIView.animate(withDuration: 0.2, animations: { [unowned self] () in
                        self.headerCell?.cozyButton.alpha = 0
                        self.headerCell?.compactButton.alpha = 0
                        self.headerCell?.cozyView.transform = .init(translationX: 0, y: 7)
                        self.headerCell?.compactView.transform = .init(translationX: 0, y: 7)
                        }, completion: { [unowned self] (true) in
                            self.navigationItem.leftBarButtonItems = []
                            self.headerCell?.addSubview(self.headerCell!.cozyButton)
                            self.headerCell?.addSubview(self.headerCell!.compactButton)
                            UIView.animate(withDuration: 0.1, animations: { [unowned self] () in
                                self.headerCell?.cozyButton.alpha = 1
                                self.headerCell?.compactButton.alpha = 1
                            }) { [unowned self] (true) in
                                self.animating = false
                            }
                    })
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell: WTCardHeaderCell? = tableView.dequeueReusableCell(withIdentifier: WTCardHeaderCell.reuseIdentifier) as? WTCardHeaderCell
            if cell == nil {
                cell = WTCardHeaderCell()
                cell?.buttonAction = { [unowned self] (mode) in
                    self.mode = mode
                }
            }
            if self.mode == .cozy {
                
            } else {
                
            }
            return cell!
        } else {
            if mode == .cozy {
                var cell: WTCardCozyCell? = tableView.dequeueReusableCell(withIdentifier: WTCardCozyCell.reuseIdentifier) as? WTCardCozyCell
                if cell == nil {
                    cell = WTCardCozyCell(indexPath.row % 3 == 0 ? .saderat : (indexPath.row % 3 == 1 ? .mellat : .parsian))
                }
                cell?.valueLabel.text = Int("435353")?.priceFormat
                cell?.numLabel.text = "****  ****  ***4  3257".localizedFormat
                return cell!
            } else {
                var cell: WTCardCompactCell? = tableView.dequeueReusableCell(withIdentifier: WTCardCompactCell.reuseIdentifier) as? WTCardCompactCell
                if cell == nil {
                    cell = WTCardCompactCell(indexPath.row % 3 == 0 ? .saderat : (indexPath.row % 3 == 1 ? .mellat : .parsian))
                }
                cell?.numLabel.text = "****  ****  ***4  3259".localizedFormat
                return cell!
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}

class CustomSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let marginTop: CGFloat = 80
        return CGRect(x: 0, y: marginTop, width: containerView!.bounds.width, height: containerView!.bounds.height - marginTop)
    }
}
