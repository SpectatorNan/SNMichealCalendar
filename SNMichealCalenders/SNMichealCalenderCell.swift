//
//  SNMichealCalenderCell.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

enum SNMichealCalendarCellStyle {
    case after
    case select
    case current
    case before
    case empty
}

protocol SNMichealCalendarCellContent {
    var style: SNMichealCalendarCellStyle { get set }
    var date: Date? {set get }
}

class SNMichealCalendarCell: UICollectionViewCell, SNMichealCalendarCellContent {
    
    let selectColor = UIColor(netHex: 0x00a8c2)
    let grayColor = UIColor(netHex: 0xbdbdbd)
    let blackColor = UIColor(netHex: 0x565656)
    
    private var today: Date?
    private var showStyle : SNMichealCalendarCellStyle = .before
    fileprivate lazy var content : UILabel = {
       var content = UILabel(frame: CGRect(x: 0, y: 0, width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        
        content.font = UIFont.systemFont(ofSize: 15)
        content.textAlignment = .center
        
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
    
    var date: Date? {
        get {
            return today!
        }
        set {
            changeToday(date: newValue)
            today = newValue
        }
    }
    
    func empty() {
    changeToday(date: nil)
    style = .empty
    }
    
    private func changeToday(date: Date?) {
        
        guard let d = date else {
            content.text = ""
            return
        }
        
        let cs = d==>
        
        content.text = String(format: "%ld", cs.day!)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
   
}

fileprivate extension SNMichealCalendarCell {
    func changeCellStyle(newStyle: SNMichealCalendarCellStyle) {
        
        switch newStyle {
        case .current:
            borderStyle()
        case .select:
            overallStyle()
        case .after:
            grayStyle()
        case .before:
            noneStyle()
        
        default:
            emptyStyle()
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
        content.layer.borderColor = UIColor.clear.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.backgroundColor = .white
        content.clipsToBounds = true
        content.textColor = blackColor
    }
    
    func grayStyle() {
        content.layer.borderColor = UIColor.clear.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.backgroundColor = .white
        content.clipsToBounds = true
        content.textColor = grayColor
    }
    
    func emptyStyle() {
        content.layer.borderColor = UIColor.clear.cgColor
        content.layer.cornerRadius = SNMichealCalendar_adjustSizeAPP(27)
        content.layer.borderWidth = 2
        content.backgroundColor = .clear
        content.clipsToBounds = true
        content.textColor = .clear
    }
}
