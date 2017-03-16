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
    
    
    let itemSpace = SNMichealCalendar_adjustSizeAPP(38.6)
    let itemSize = SNMichealCalendar_adjustSizeAPP(54)

    
    var currentYear: Int
    var currentMonth: Int
    var date: Date
    init(date: Date, frame: CGRect) {
        
        let cs = calendarUntil.calendar.dateComponents([.month,.year], from: date)
        currentMonth = cs.month!
        currentYear = cs.year!
        self.date = date
        
        super.init(frame: frame)
        getCurrentMonth()
        setupView()
    }
    
    var firstShow = true
    var isClickReload = false
    
    lazy var collectionView: UICollectionView = {
        
        
        
        var flowLayout = UICollectionViewFlowLayout()
        
        let cellW = self.itemSize
        let cellH = self.itemSize
        
        
        let headerW = SN_ScreenW - SNMichealCalendar_adjustSizeAPP(140)
        let headerH = self.itemSize
        
        // cell size
        flowLayout.itemSize = CGSize(width: cellW, height: cellH)
        // scroll direction
        flowLayout.scrollDirection = .vertical
        // header size
        flowLayout.headerReferenceSize = CGSize(width: headerW, height: headerH)
        
        flowLayout.minimumLineSpacing = self.itemSpace
        flowLayout.minimumInteritemSpacing = self.itemSpace
        
        flowLayout.sectionInset = UIEdgeInsetsMake(self.itemSpace, 0, 0, 0)
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        collection.backgroundColor = .clear
                            
        collection.register(SNMichealCalendarCell.classForCoder(), forCellWithReuseIdentifier: SNMichealCalendar_colCellID)
        collection.register(SNMichealCalendarWeekReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SNMichealCalendar_colHeader)
        
        collection.delegate = self
        collection.dataSource = self
        
        
        
        return collection
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCurrentMonth() {

        
        
        numberOfDaysCurrentMonth = calendarUntil.getCurrentMonthDaysNum(date: date)
        
        numberOfDaysLastMonth = calendarUntil.getDaysNum(month: currentMonth - 1, year: currentYear)
        
        firstDayCurrentMonth = calendarUntil.getWeekDay(day: 1, month: currentMonth, year: currentYear)
        firstDayNextMonth = calendarUntil.getWeekDay(day: 1, month: currentMonth+1, year: currentYear)
        
        
        if firstDayCurrentMonth == 7 {
            lastDayLastMonth = 0
        } else {
            lastDayLastMonth = firstDayCurrentMonth
        }
        
        numberOfDaysNextMonth = 7 - firstDayNextMonth!
        
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
    }
    
    func setupView() {
        
        
        
        addSubview(collectionView)
        
        let row = (sumDays!+6)/(7)
//        let row = getWeekNumsOfMonth(date: Date())
        let colH = CGFloat(row)  * SNMichealCalendar_adjustSizeAPP(54+38.6) + SNMichealCalendar_adjustSizeAPP(40) + SNMichealCalendar_adjustSizeAPP(54)
        collectionView.snp.makeConstraints { (layout) in
            layout.top.equalToSuperview()
            layout.right.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(-70))
            layout.left.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(70))
            layout.height.equalTo(colH)
            layout.bottom.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(-40))
        }
        
 
    }
    
}

//extension SNMichealCalendarView : UICollectionViewDelegateFlowLayout {
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let headerW = SN_ScreenW - SNMichealCalendar_adjustSizeAPP(140)
//        let headerH = self.itemSize
//        return CGSize(width: headerW, height: headerH)
//    }
//}

extension SNMichealCalendarView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sumDays!
    }
    
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SNMichealCalendar_colCellID, for: indexPath) as! SNMichealCalendarCell
        

        
        // show last month day 
      if indexPath.row < lastDayLastMonth! {
            let n = numberOfDaysLastMonth! - firstDayCurrentMonth! + 1 + indexPath.row
            cell.text = String(format: "%ld", n)
//            cell.style = .none
//            cell.isHidden = true
        } else if indexPath.row < numberOfDaysCurrentMonth!+lastDayLastMonth!{
            // select month show
            let n = indexPath.row + 1 - lastDayLastMonth!
            cell.text = String(format: "%ld", n)
            
            let sd = calendarUntil.getDate(year: currentYear, month: currentMonth, day: n)
            itemStyle( sd , calendarUntil.compareIsSameMonth(dateA: sd, dateB: Date()), cell)
//            cell.style = .border
        } else {
            let n = indexPath.row + 1 - numberOfDaysCurrentMonth! - lastDayLastMonth!
            cell.text = String(format: "%ld", n)
//            cell.style = .overall
//            cell.isHidden = true
        }
        
        
        
        return cell
        
        
    }
    
    func itemStyle(_ showDay: Date,_ isCurrentMonth: Bool,_ cell: SNMichealCalendarCell) {
    
        if isCurrentMonth {
            let cs = calendarUntil.calendar.dateComponents([.day], from: showDay)
            itemStyle(cs.day! , cell)
        } else {
            cell.style = .before
        }
    }
    
    func itemStyle(_ showDay: Int, _ cell: SNMichealCalendarCell) {
        if showDay < calendarUntil.comps.day! {
            cell.style = .before
        } else if showDay == calendarUntil.comps.day! {
            if firstShow {
            cell.style = .select
            } else {
                cell.style = .current
            }
        } else {
            cell.style = .after
        }
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
        collectionView.reloadData()
    }
    
}
