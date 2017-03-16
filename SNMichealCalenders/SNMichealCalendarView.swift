//
//  SNMichealCalendarView.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/15.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit


enum SNMichealCalendarCover {
    case Exist
    case NotExist
}

let SNMichealCalendar_colCellID = "dayColCell"
let SNMichealCalendar_colHeader = "dayColHeader"

class SNMichealCalendarView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var viewHeight : CGFloat? = nil;
    var viewWidth : CGFloat? = nil;
    
    var numberOfDaysCurrentMonth: Int? //本月总天数
    var numberOfDaysLastMonth: Int?  //上月总天数 :
    var firstDayCurrentMonth: Int? //本月第一天周几：
    var firstDayNextMonth: Int?  //下月第一天周几：
    var lastDayLastMonth: Int?  // = fisrtWeekDay //显示上个月格子数：
    var numberOfDaysNextMonth: Int?  //= 7 - firstWeekDayNM;  //显示下个月格子数：
    var sumDays: Int?  //= totalDayThisMonth + nextSum + lastSum  显示总各自数
    
    var calendarUntil = CalendarUntil()
    
    
//    let comps = Calendar.current.component([.year,.month,.day], from: Data())
    let comps = Calendar.current.dateComponents([.year,.month,.day], from: Date())
    
    
    
    
    
    lazy var collectionView: UICollectionView = {
        
        
        
        var flowLayout = UICollectionViewFlowLayout()
        
        let cellW = SNMichealCalendar_adjustSizeAPP(54)
        let cellH = SNMichealCalendar_adjustSizeAPP(54)
        
        
        let headerW = SN_ScreenW - SNMichealCalendar_adjustSizeAPP(140)
        let headerH = SNMichealCalendar_adjustSizeAPP(54)
        
        // cell size
        flowLayout.itemSize = CGSize(width: cellW, height: cellH)
        // scroll direction
        flowLayout.scrollDirection = .vertical
        // header size
        flowLayout.headerReferenceSize = CGSize(width: headerW, height: headerH)
        
        flowLayout.minimumLineSpacing = SNMichealCalendar_adjustSizeAPP(38.6)
        flowLayout.minimumInteritemSpacing = SNMichealCalendar_adjustSizeAPP(38.6)
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        collection.backgroundColor = .clear
                            
        collection.register(SNMichealCalendarCell.classForCoder(), forCellWithReuseIdentifier: SNMichealCalendar_colCellID)
        collection.register(SNMichealCalendarWeekReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SNMichealCalendar_colHeader)
        
        collection.delegate = self
        collection.dataSource = self
        
        
        
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let currentMonth = comps.month
        let currentYear = comps.year
//        var currentDay = comps.day
        
        numberOfDaysCurrentMonth = calendarUntil.getCurrentMonthDaysNum(date: Date())
        numberOfDaysLastMonth = calendarUntil.getDaysNum(month: currentMonth! - 1, year: currentYear!)
        
        firstDayCurrentMonth = calendarUntil.getWeekDay(day: 1, month: currentMonth!, year: currentYear!)
        firstDayNextMonth = calendarUntil.getWeekDay(day: 1, month: currentMonth!+1, year: currentYear!)
        
        
        if firstDayCurrentMonth == 7 {
            lastDayLastMonth = 0
        } else {
            lastDayLastMonth = firstDayNextMonth
        }
        
        numberOfDaysNextMonth = 7 - firstDayNextMonth!
//        sumDays = (numberOfDaysCurrentMonth! + numberOfDaysNextMonth! + lastDayLastMonth!) as! Int
        guard let s1 = numberOfDaysCurrentMonth else {
            return
        }
        guard let s2 = numberOfDaysNextMonth else {
            return
        }
        guard let s3 = lastDayLastMonth else {
            return
        }
        sumDays = s1 + s2 + s3
        
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
        monthBtn.setTitle("2017年2月", for: .normal)
        monthBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        monthBtn.setTitleColor(.black, for: .normal)
        
        let lastBtn = UIButton()
        contentView.addSubview(lastBtn)
        lastBtn.setImage(UIImage(named:"leftArrow"), for: .normal)
        
        contentView.addSubview(collectionView)
        
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
        
        let row = CGFloat(sumDays!+6)/CGFloat(7)
//        let row = getWeekNumsOfMonth(date: Date())
        let colH = CGFloat(row)  * SNMichealCalendar_adjustSizeAPP(54+38.6) + SNMichealCalendar_adjustSizeAPP(40)
        collectionView.snp.makeConstraints { (layout) in
            layout.top.equalTo(monthBtn.snp.bottom).offset(SNMichealCalendar_adjustSizeAPP(52))
            layout.right.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(-70))
            layout.left.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(70))
            layout.height.equalTo(colH)
        }
        
        contentView.snp.makeConstraints { (layout) in
            layout.edges.equalToSuperview()
        }
    }
    
}

extension SNMichealCalendarView : UICollectionViewDataSource {
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sumDays!
    }
    
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SNMichealCalendar_colCellID, for: indexPath) as! SNMichealCalendarCell
        
        // show last month day 
        if indexPath.row < lastDayLastMonth! {
            cell.cell(string: String(format: "%ld", numberOfDaysLastMonth! - firstDayCurrentMonth! + 1 + indexPath.row))
            cell.style = .none
        } else if indexPath.row < numberOfDaysCurrentMonth!+lastDayLastMonth!{
            // select month show
            cell.cell(string: String(format: "%ld", indexPath.row + 1 - lastDayLastMonth!))
            cell.style = .border
        } else {
            cell.cell(string: String(format: "%ld", indexPath.row + 1 - numberOfDaysCurrentMonth! - lastDayLastMonth!))
            cell.style = .overall
        }
        
        
        
        return cell
        
        
    }
    
     public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header = SNMichealCalendarWeekReusableView()
        
        if kind == UICollectionElementKindSectionHeader {
            
             header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SNMichealCalendar_colHeader, for: indexPath) as! SNMichealCalendarWeekReusableView
            
            
        }
        
        return header
    }
}


extension SNMichealCalendarView : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click itme \(indexPath.row)")
    }
    
}



class CalendarUntil {
    
    
    lazy var calendar : Calendar = {
        var c = Calendar.current
        c.timeZone = TimeZone.current
        c.locale = Locale.current
       return c
    }()
    
    
    lazy var dateFormatter : DateFormatter = {
        var dfm = DateFormatter()
        dfm.timeZone = self.calendar.timeZone
        dfm.locale = self.calendar.locale
        return dfm
    }()
    
    }

// get message
extension CalendarUntil {
    // 当月总共天数
     func getCurrentMonthDaysNum(date: Date) -> Int {
        
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return (range?.count)!
    }
    
     func getDaysNum(month: Int, year: Int) -> Int {
        var comps = DateComponents()
        comps.month = month
        comps.year = year
        
        let gregorian = Calendar(identifier: .gregorian)
        let date = gregorian.date(from: comps)
        let days = gregorian.range(of: .day, in: .month, for: date!)
        
        return (days?.count)!
    }
    
    //返回1--周一，7--周日
     func getWeekDay(day: Int, month: Int, year: Int) -> Int {
        var comps = DateComponents()
        comps.month = month
        comps.year = year
        comps.day = day
        
        let date = calendar.date(from: comps)
        let weekdayComps = calendar.dateComponents([.weekday], from: date!)
        
        var weekDayNum = weekdayComps.weekday! - 1
        
        if weekDayNum == 0 {
            weekDayNum = 7
        }
        
        return weekDayNum
    }
    
    //  貌似都是一个结果
     func getNumberOfWeeks(date: Date) -> Int {
        
        let firstD = getFirstDayOfMonth(date: date)
        let lastD = getLastDayOfMonth(date: date)
        
        let csf = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: firstD)
        let csl = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: lastD)
        
        let result = (csl.year! - csf.year! + 52 + 1) % 52
        
        return  result
    }
    
//    本月的第一天
     func getFirstDayOfMonth(date: Date) -> Date {
        
        let compCurrDate = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: date)
        
        var compNewDate = DateComponents()
        compNewDate.year = compCurrDate.year
        compNewDate.month = compCurrDate.month
        compNewDate.weekOfMonth = 1
        compNewDate.day = 1
        
        return calendar.date(from: compNewDate)!
    }
    
//     本月的最后一天
     func getLastDayOfMonth(date: Date) -> Date {
        
        let compCurrDate = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: date)
        
        var compNewDate = DateComponents()
        compNewDate.year = compCurrDate.year
        compNewDate.month = compCurrDate.month! + 1
        compNewDate.day = 0
        
        return calendar.date(from: compNewDate)!
    }
    
    // 本月一共多少周
    func getWeekNumsOfMonth(date: Date) -> Int {
        
      let d = getLastDayOfMonth(date: date)
        let cs = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: d)
        return cs.weekOfMonth!
    }

    
    //本期第一个周日是哪天(含上月)(国外周日为每周第一天)
    func getFirstWeekDayOfMonth(date: Date) -> Date {
        
        let d = getFirstDayOfMonth(date: date)
        let wd = getFirstWeekDayOfWeek(date: d)
        
        return wd
        
    }
    
    //本周第一个周日是哪天
    func getFirstWeekDayOfWeek(date: Date) -> Date {
        
        let cs = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: date)
        
        var ncs = DateComponents()
        ncs.year = cs.year
        ncs.month = cs.month
        ncs.weekOfMonth = cs.weekOfMonth
        ncs.weekday = calendar.firstWeekday
        
        let weekD = calendar.date(from: ncs)
        
        return weekD!
    }
}

// make compare
extension CalendarUntil {
    // 是否同一个月
    func compareIsSameMonth(dateA: Date, dateB: Date) -> Bool {
        
        let csA = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: dateA)
        let csB = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: dateB)
        
        let compare = csA.year == csB.year && csA.month == csB.month
        
        return compare
    }
    
//    是否同一周
    func compareIsSameWeek(dateA: Date, dateB: Date) -> Bool {
        
        let csA = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: dateA)
        let csB = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth,.weekOfYear], from: dateB)
        
        let compare = csA.year == csB.year && csA.weekOfYear == csB.weekOfYear
        
        return compare
    }
    
//    是否同一天
    func compareIsSameDay(dateA: Date, dateB: Date) -> Bool {
        
        let csA = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: dateA)
        let csB = calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth,.weekOfYear], from: dateB)
        
        let compare = csA.year == csB.year && csA.month == csB.month && csA.day == csB.year
        
        return compare
    }
    
//    是否在某天之后(含当天)
    func compare(dateA: Date, isAfter dateB: Date) -> Bool {
        
        let compare = dateA.compare(dateB) == .orderedDescending || compareIsSameDay(dateA: dateA, dateB: dateB)
        
        return compare
    }
    
//    是否在某天之前(含当天)
    func compare(dateA: Date, isBefore dateB: Date) -> Bool {
        
        let compare = dateA.compare(dateB) == .orderedAscending || compareIsSameDay(dateA: dateA, dateB: dateB)
        
        return compare
    }
    
//    是否在某段时间之间
    func compare(date:Date,between startDate: Date, and endDate: Date) -> Bool {
        
        let compare1 = compare(dateA: date, isAfter: startDate) && compare(dateA: date, isBefore: endDate)
        
        return compare1
    }
}






extension SNMichealCalendarView {
    
    
    private func productView() {
        
        /*
         guard let h = viewHeight, h > 0  else {
         print("CalendarView is not set height or height is zero")
         return
         }
         
         guard let w = viewWidth, w > 0  else {
         print("CalendarView is not set width or width is zero")
         return
         }
         */
        
        let contentView = UIView()
        
        // temporary demand
        let confirmBtnSize = textSizeFromTextString(text: "确定", textW: SN_ScreenW, textH: 54, fontSize: 18, isBold: true)
        let confirmBtnX = SN_ScreenW - confirmBtnSize.width - SNMichealCalendar_adjustSizeAPP(50)
        
        
        let confirmBtn = UIButton(frame: CGRect(
            x: SNMichealCalendar_adjustSizeAPP(confirmBtnX),
            y: SNMichealCalendar_adjustSizeAPP(38),
            width: SNMichealCalendar_adjustSizeAPP(confirmBtnSize.width),
            height: SNMichealCalendar_adjustSizeAPP(confirmBtnSize.height)))
        contentView.addSubview(confirmBtn)
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmBtn.setTitleColor(UIColor(netHex: 0x00a8c2), for: .normal)
        
        let currentCenter = CGPoint(x: SN_ScreenW/2, y: SNMichealCalendar_adjustSizeAPP(38)+(SNMichealCalendar_adjustSizeAPP(54)/2))
        let currentSize = CGSize(width: SNMichealCalendar_adjustSizeAPP(132), height: SNMichealCalendar_adjustSizeAPP(54))
        
        let currentMonthBtn = UIButton(frame: CGRect(origin: currentCenter, size: currentSize))
        contentView.addSubview(currentMonthBtn)
        currentMonthBtn.setTitle("2017年2月", for: .normal)
        currentMonthBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        let lastX = currentMonthBtn.frame.minX - SNMichealCalendar_adjustSizeAPP(40)
        
        let lastBtn = UIButton(frame: CGRect(
            x: lastX,
            y: SNMichealCalendar_adjustSizeAPP(38),
            width: SNMichealCalendar_adjustSizeAPP(54),
            height: SNMichealCalendar_adjustSizeAPP(54)))
        contentView.addSubview(lastBtn)
        
        let nextX = currentMonthBtn.frame.minX - SNMichealCalendar_adjustSizeAPP(40)
        let nextMonthBtn = UIButton(frame: CGRect(
            x: nextX,
            y: SNMichealCalendar_adjustSizeAPP(38),
            width: SNMichealCalendar_adjustSizeAPP(54),
            height: SNMichealCalendar_adjustSizeAPP(54)))
        contentView.addSubview(nextMonthBtn)
        
        for i in 0 ..< 7 {
            let labX = SNMichealCalendar_adjustSizeAPP(70) + (SNMichealCalendar_adjustSizeAPP(38.6)*CGFloat(i)) + (SNMichealCalendar_adjustSizeAPP(54)*CGFloat(i))
            
            let r = (i + 6) / 7
            let labY = SNMichealCalendar_adjustSizeAPP(90) + (SNMichealCalendar_adjustSizeAPP(38.6)*CGFloat(i))  + (SNMichealCalendar_adjustSizeAPP(54)*CGFloat(i))
        }
        
        contentView.frame = CGRect(x: 0, y: 0, width: SN_ScreenW, height: 500)
        addSubview(contentView)
    }
}
