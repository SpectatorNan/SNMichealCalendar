//
//  SNMichealCalendarHorizonView.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/17.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendarHorizonView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let until = CalendarUntil.current
        let year = until.comps.year!
        let mon = until.comps.month!
        let currdate = until.date
        let olddate = until.getDate(year: year, month: mon-1, day: 1)
        let nextdate = until.getDate(year: year, month: mon+1, day: 1)
    
        
        let view1 = SNMichealCalendarView(date: olddate, frame: CGRect.zero)
        addSubview(view1)
        leftView = view1
        
        let view2 = SNMichealCalendarView(date: currdate, frame: CGRect.zero)
        addSubview(view2)
        centerView = view2
        
        let view3 = SNMichealCalendarView(date: nextdate, frame: CGRect.zero)
        addSubview(view3)
        rightView = view3
        
        guard let height = view1.viewHeight else {
            return
        }
        
        self.viewHeight = height
        self.viewWidth = SN_ScreenW
        self.viewSize = CGSize(width: SN_ScreenW, height: height)
        self.showYear = year
        self.showMonth = mon
        
        
        setupView()
    }
    
    var viewSize : CGSize?
    var viewHeight: CGFloat?
    var viewWidth : CGFloat?
    
    var leftView: SNMichealCalendarView?
    var centerView: SNMichealCalendarView?
    var rightView: SNMichealCalendarView?
    
    var showYear: Int?
    var showMonth: Int?
    
    var months = [[Date]]()
    var currentIndex = 0
    var pageNum = 0
    var contentX : CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
        self.isPagingEnabled = true
        
        guard let rV = rightView else {
            return
        }
    
        guard let cV = centerView else {
            return
        }
        
        guard let lV = leftView else {
            return
        }
        
        guard let size = self.viewSize else {
            return
        }
        
        guard let width = self.viewWidth else {
            return
        }
        
        guard let height = self.viewHeight else {
            return
        }
        
        lV.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        
        cV.frame = CGRect(origin: CGPoint(x: width, y: 0), size: size)
        
        
        rV.frame = CGRect(origin: CGPoint(x: width*2, y: 0), size: size)
        
        guard let cData = cV.currentDays else {
            return
        }
  
        self.months.insert(cData, at: self.currentIndex)
        
        if let lData = lV.currentDays {
            self.months.insert(lData, at: 0)
            self.currentIndex = 1
        }
        
        if let rData = rV.currentDays {
            self.months.insert(rData, at: self.currentIndex+1)
        }
        
        
        
        self.contentSize = CGSize(width: 3*width, height: height)
        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        contentOffset.x = width*2
        contentX = width
        self.delegate = self
    }
    
    
    
    
    override func layoutSubviews() {
        let width = self.frame.size.width
        print("")
    }
    
}

extension SNMichealCalendarHorizonView : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("gundong l ")
    }
    
    
}


