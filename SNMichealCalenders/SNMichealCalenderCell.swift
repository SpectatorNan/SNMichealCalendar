//
//  SNMichealCalenderCell.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

enum SNMichealCalendarCellStyle {
    case border
    case overall
    case none
}

class SNMichealCalendarCell: UICollectionViewCell {
    
    let selectColor = UIColor(netHex: 0x00a8c2)
    
    private var showStyle : SNMichealCalendarCellStyle = .none
    private lazy var content : UILabel = {
       var content = UILabel(frame: CGRect(x: 0, y: 0, width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        
        content.font = UIFont.systemFont(ofSize: 15)
        
        return content
    }()
    
    var style: SNMichealCalendarCellStyle {
        get {
            return showStyle
        }
        set {
            showStyle = newValue
            changeCellStyle(newStyle: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        
        contentView.addSubview(content)
        
        
        
    }
    
    func changeCellStyle(newStyle: SNMichealCalendarCellStyle) {
        
        switch newStyle {
        case .border:
            borderStyle()
        case .overall:
            overallStyle()
        default:
            noneStyle()
        }
    }
    
    func borderStyle() {
        content.layer.borderColor = selectColor.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.clipsToBounds = true
        content.textColor = selectColor
        content.backgroundColor = .white
    }
    
    func overallStyle() {
        content.layer.borderColor = selectColor.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.backgroundColor = selectColor
        content.clipsToBounds = true
        content.textColor = .white
    }
    
    func noneStyle() {
        content.layer.borderColor = UIColor.white.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.backgroundColor = .white
        content.clipsToBounds = true
        content.textColor = .black
    }
    
    func cell(string: String) {
        content.text = string
    }
}
