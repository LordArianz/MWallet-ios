//
//  WTCardHeaderCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

enum WTCardCellMode {
    case cozy
    case compact
}

class WTCardHeaderCell: UITableViewCell {

    static let reuseIdentifier: String = "WTCardHeaderCell"
    
    var cozyView: UIView!
    var cozyButton: UIButton!
    var compactView: UIView!
    var compactButton: UIButton!
    var buttonAction: ((WTCardCellMode) -> ())?
    var selectedMode: WTCardCellMode = .cozy
    
    init() {
        super.init(style: .default, reuseIdentifier: WTCardHeaderCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear

        cozyView = UIView()
        compactView = UIView()
        cozyButton = UIButton()
        cozyButton.setImage(UIImage(named: "icon-cards-cozy")!
            .withRenderingMode(.alwaysTemplate), for: .normal)
        cozyButton.addTarget(self, action: #selector(btnAction(_ :)), for: .touchUpInside)
        compactButton = UIButton()
        compactButton.setImage(UIImage(named: "icon-cards-compact")!
            .withRenderingMode(.alwaysTemplate), for: .normal)
        compactButton.addTarget(self, action: #selector(btnAction(_ :)), for: .touchUpInside)
        cozyView.addSubview(cozyButton)
        compactView.addSubview(compactButton)
        self.addSubview(cozyView)
        self.addSubview(compactView)
        setColors()
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func btnAction(_ sender: UIButton) {
        print("avaz bas beshe")
        print(sender == cozyButton)
        self.selectedMode = sender == cozyButton ? .cozy : .compact
        self.buttonAction?(selectedMode)
        setColors()
    }
    func setColors() {
        if selectedMode == .cozy {
            cozyButton.tintColor = WTColor.wt_ToggleOn
            compactButton.tintColor = WTColor.wt_ToggleOff
        } else {
            cozyButton.tintColor = WTColor.wt_ToggleOff
            compactButton.tintColor = WTColor.wt_ToggleOn
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let paddingX: CGFloat = 20
        
        compactView.frame.size = CGSize(width: self.frame.size.height + 2, height: self.frame.size.height)
        compactView.frame.origin = CGPoint(x: self.frame.size.width - compactView.frame.size.width - paddingX, y: 0)
        
        cozyView.frame.size = CGSize(width: self.frame.size.height + 2, height: self.frame.size.height)
        cozyView.frame.origin = CGPoint(x: compactView.frame.origin.x - cozyView.frame.size.width - 0, y: 0)
        
        cozyView.center.y = self.center.y
        cozyButton.frame = cozyView.bounds
        compactView.center.y = self.center.y
        compactButton.frame = compactView.bounds
    }
}
