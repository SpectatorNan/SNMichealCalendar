//
//  SNMichealCalendarWeekReusableView.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendarWeekReusableView: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        let strs = ["日","一","二","三","四","五","六"]
        var lastV : UILabel? = nil
        for i in 0..<7 {
        
            let lab = UILabel()
            addSubview(lab)
            lab.text = strs[i]
            lab.textColor = UIColor(netHex: 0x565656)
            lab.font = UIFont.systemFont(ofSize: 13)
            lab.textAlignment = .center

            
            lab.snp.makeConstraints({ (layout) in
                layout.left.equalTo(lastV == nil ? self : lastV!.snp.right).offset(lastV == nil ? 0 : SNMichealCalendar_adjustSizeAPP(38.6))
                layout.top.equalToSuperview()
                layout.size.equalTo(CGSize(width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
            })
            
            lastV = lab
        }
        
    }
    
}
