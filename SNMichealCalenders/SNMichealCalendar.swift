//
//  SNMichealCalendar.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendar: UIView {
    
    var calendarUntil = CalendarUntil()
    
    lazy var showYear : Int = {
        
        return self.calendarUntil.comps.year!
        
    }()
    
    lazy var showMonth : Int = {
        
        return self.calendarUntil.comps.month!
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupView() {
        
        let contentView = UIView()
        addSubview(contentView)
        
        let confirBtn = UIButton()
        contentView.addSubview(confirBtn)
        confirBtn.setTitle("确定", for: .normal)
        confirBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirBtn.setTitleColor(UIColor(netHex: 0x00a8c2), for: .normal)
        
        let nextBtn = UIButton()
        contentView.addSubview(nextBtn)
        nextBtn.setImage(UIImage(named:"rightArrow"), for: .normal)
        
        let monthBtn = UIButton()
        contentView.addSubview(monthBtn)
        monthBtn.setTitle("\(showYear)年\(showMonth)月", for: .normal)
        monthBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        monthBtn.setTitleColor(.black, for: .normal)
        
        let lastBtn = UIButton()
        contentView.addSubview(lastBtn)
        lastBtn.setImage(UIImage(named:"leftArrow"), for: .normal)
        
        let calendarView = SNMichealCalendarView(date: Date(), frame: CGRect.zero)
        contentView.addSubview(calendarView)
        confirBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(38))
            make.right.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(-50))
            
        }
        
        monthBtn.snp.makeConstraints { (layout) in
            layout.centerX.equalToSuperview()
            layout.top.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(38))
        }
        
        nextBtn.snp.makeConstraints { (layout) in
            
            layout.left.equalTo(monthBtn.snp.right).offset(SNMichealCalendar_adjustSizeAPP(40))
            layout.top.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(38))
            layout.size.equalTo(CGSize(width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        }
        
        lastBtn.snp.makeConstraints { (layout) in
            layout.top.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(38))
            layout.right.equalTo(monthBtn.snp.left).offset(SNMichealCalendar_adjustSizeAPP(-40))
            layout.size.equalTo(CGSize(width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        }
        
        calendarView.snp.makeConstraints { (make) in
        make.top.equalTo(monthBtn.snp.bottom).offset(SNMichealCalendar_adjustSizeAPP(38.6))
            make.right.left.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (layout) in
            layout.edges.equalToSuperview()
        }
    }
    

}
