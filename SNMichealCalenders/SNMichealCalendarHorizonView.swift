//
//  SNMichealCalendarHorizonView.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/17.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit



class SNMichealCalendarHorizonView: UIScrollView {
   
    let until = CalendarUntil.current

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(frame: CGRect, manager: SNMichealCalendarHorizonViewDelegate) {
        super.init(frame: frame)

        commonInit()
        
        horizonViewDelegate = manager
        manager.horizonView = self
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
    var horizonViewDelegate: SNMichealCalendarHorizonViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SNMichealCalendarHorizonView {
    
    
    func loadPreView() {
        self.contentOffset.x = contentX - width
        pageNum -= 1
        completePreAndArchiveData()
        updatePreAction()
    }
    
    func loadNextView() {
        contentOffset.x = contentX + width
        pageNum += 1
        completeNextAndArchiveData()
        updateNextAction()
    }
    
    /// 此方法必须在生成新数据之后调用
    func updatePreAction() {
        
        let tmpVa = centerView
        let tmpVb = rightView
        centerView = leftView
        rightView = tmpVa
        leftView = tmpVb
        
        leftView?.x = contentX - width
    }
    
    /// 此方法必须在生成新数据之后调用
    func updateNextAction() {
        
        let tmpVa = centerView
        let tmpVb = leftView
        centerView = rightView
        rightView = tmpVb
        leftView = tmpVa
        
        
        rightView?.x = contentX + width
    }
    
    
    func completePreAndArchiveData() {
        
        guard var month = showMonth else {
            return
        }
        
        guard var year = showYear else {
            return
        }
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
        showYear = year
        showMonth = month
        
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
        contentX = contentOffset.x
      let data = until.getDaysOfMonth(year: year, month: month)
        months.insert(data, at: 0)
        months.remove(at: 3)
    }
    
    func completeNextAndArchiveData() {
        guard var month = showMonth else {
            return
        }
        
        guard var year = showYear else {
            return
        }
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
        
        showMonth = month
        showYear = year
        
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }

        contentX = contentOffset.x
        let data = until.getDaysOfMonth(year: year, month: month)
        months.insert(data, at: 3)
        months.remove(at: 0)
    }
}

extension SNMichealCalendarHorizonView : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("gundong l ")
    }
    
    
}

extension SNMichealCalendarHorizonView {
    
    fileprivate func commonInit() {
        
        let year = until.comps.year!
        let mon = until.comps.month!
        
        self.showYear = year
        self.showMonth = mon
        
        let (oldyear, oldmonth) = until.fetchLastMonth(year: year, month: mon)
        let (nextyear, nextmonth) = until.fetchNextMonth(year: year, month: mon)
        let dates1 = until.getDaysOfMonth(year: oldyear, month: oldmonth)
        let dates2 = until.getDaysOfMonth(year: year, month: mon)
        let dates3 = until.getDaysOfMonth(year: nextyear, month: nextmonth)
        
        let view1 = SNMichealCalendarView(dates: dates1, frame: CGRect.zero)
        addSubview(view1)
        leftView = view1
        
        let view2 = SNMichealCalendarView(dates: dates2, frame: CGRect.zero)
        addSubview(view2)
        centerView = view2
        
        let view3 = SNMichealCalendarView(dates: dates3, frame: CGRect.zero)
        addSubview(view3)
        rightView = view3
        
        guard let height = view1.viewHeight else {
            return
        }
        
        self.viewHeight = height
        self.viewWidth = SN_ScreenW
        self.viewSize = CGSize(width: SN_ScreenW, height: height)
        
        setupView()
    }
    
    private func setupView() {
        
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
        
         let cData = cV.currentDays
        
        months.insert(cData, at: 0)
        
         let lData = lV.currentDays
            self.months.insert(lData, at: 0)
            self.currentIndex = 1
        
        
         let rData = rV.currentDays
            self.months.insert(rData, at: 2)
        
        
        
        
        self.contentSize = CGSize(width: 3*width, height: height)
        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        contentOffset.x = width
        contentX = width
        self.delegate = self
    }
}


