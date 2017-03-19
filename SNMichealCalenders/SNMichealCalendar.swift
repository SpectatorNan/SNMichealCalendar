//
//  SNMichealCalendar.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendar: UIView {
    
    
    let manger = SNMichealCalendarManger()
    
    var calendarUntil = CalendarUntil.current
    
    var selectedDate: Date?
    
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
        
//        let menuView = SNMichealCalendarMenuView(frame: CGRect.zero, year: showYear, month: showMonth)
        let menuView = SNMichealCalendarMenuView(frame: CGRect.zero, year: showYear, month: showMonth, manger: manger)
        contentView.addSubview(menuView)
        
//        let calendarHorizonView = SNMichealCalendarHorizonView(frame: CGRect.zero)
        let calendarHorizonView = SNMichealCalendarHorizonView(frame: CGRect.zero, manager: manger)
        contentView.addSubview(calendarHorizonView)
        
        menuView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(38))
            make.right.left.equalToSuperview()
            make.height.equalTo(SNMichealCalendar_adjustSizeAPP(54+38))
        }
        
        
        
        calendarHorizonView.snp.makeConstraints { (make) in
        make.top.equalTo(menuView.snp.bottom).offset(SNMichealCalendar_adjustSizeAPP(38.6))
            make.right.left.equalToSuperview()
           calendarHorizonView.heightLayout = make.height.equalTo(calendarHorizonView.viewHeight!).constraint
        }
        
//        calendarView.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview()
//            make.size.equalToSuperview()
//        }
        
        contentView.snp.makeConstraints { (layout) in
            layout.edges.equalToSuperview()
        }
        
//       manger.horizonViewDelegate = menuView
//        manger.menuViewDelegate = calendarHorizonView
    }
    

}


