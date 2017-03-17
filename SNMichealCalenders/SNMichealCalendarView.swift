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
    
//    var numberOfDaysCurrentMonth: Int? //本月总天数
//    var numberOfDaysLastMonth: Int?  //上月总天数 :
    var firstWeekDay: Int? //本月第一天周几：
    var firstWeekDayOfNextMonth: Int?  //下月第一天周几：
    var weekdaysOfLastMonth: Int?  // = fisrtWeekDay //显示上个月格子数：
    var numberOfDaysNextMonth: Int?  //= 7 - firstWeekDayNM;  //显示下个月格子数：
    var sumDays: Int?  //= totalDayThisMonth + nextSum + lastSum  显示总各自数
    
    var calendarUntil = CalendarUntil.current
    
    
    let itemSpace = SNMichealCalendar_adjustSizeAPP(38.6)
    let itemSize = SNMichealCalendar_adjustSizeAPP(54)

    var selectedDate: Date?
    var currentYear: Int
    var currentMonth: Int
    var date: Date
    var currentDays: [Date]?
    
    
    func fetchDays() {
        
        currentDays = calendarUntil.getDaysOfMonth(year: currentYear, month: currentMonth)
       
    }
    
    init(date: Date, frame: CGRect) {
        
        let cs = date==>
        currentMonth = cs.month!
        currentYear = cs.year!
        self.date = date
        
        super.init(frame: frame)
        getCurrentMonth()
        setupView()
    }
    
//    var firstShow = true
//    var isClickReload = false
    
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

        fetchDays()
        
        guard let days = currentDays else {
            return
        }
        
//        numberOfDaysCurrentMonth = days.count
        
//        numberOfDaysLastMonth = calendarUntil.getDaysNum(month: currentMonth - 1, year: currentYear)
        
        firstWeekDay = calendarUntil.getWeekDay(day: 1, month: currentMonth, year: currentYear)
        firstWeekDayOfNextMonth = calendarUntil.getWeekDay(day: 1, month: currentMonth+1, year: currentYear)
        
        
        if firstWeekDay == 7 {
            weekdaysOfLastMonth = 0
        } else {
            weekdaysOfLastMonth = firstWeekDay
        }
        
        numberOfDaysNextMonth = 7 - firstWeekDayOfNextMonth!
        
       let s1 = days.count
        guard let s2 = numberOfDaysNextMonth else {
            return
        }
        guard let s3 = weekdaysOfLastMonth else {
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
        
        viewHeight = colH+SNMichealCalendar_adjustSizeAPP(40)
 
    }
    
}

extension SNMichealCalendarView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = sumDays else {
            return 0
        }
        return count
    }
    
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SNMichealCalendar_colCellID, for: indexPath) as! SNMichealCalendarCell
        
        guard let fd = firstWeekDay else {
            cell.empty()
            return cell
        }
        

        guard let days = currentDays,
            days.count != 0 else {
                cell.empty()
            return cell
        }
        
        
        
//        if indexPath.row < fd {} else
            if indexPath.row >= fd && indexPath.row < fd+days.count {
            let d = days[indexPath.row-fd]
                cell.date = d
                itemStyle( d ,  d |=== calendarUntil.date, cell)
        }
            else {
        
        cell.empty()
        }
    
        return cell
   
    }
    
    func itemStyle(_ showDay: Date,_ isCurrentMonth: Bool,_ cell: SNMichealCalendarCell) {
        let cd = calendarUntil.date
        guard let selD = selectedDate else {
            
            if  showDay |=== cd {
                
                cell.style = .select
                
            }  else if ( showDay >=== cd) {
                
                cell.style = .after
                
            } else if ( showDay <=== cd) {
                
                cell.style = .before
                
            } else {
                
                cell.style = .empty // 感觉这一步可以省略
            }
            
            return
        }
        
        
        if (selD |=== cd) && (showDay |=== cd) {
            
            cell.style = .select
            
        } else if  selD |=== showDay {
            
            cell.style = .select
            
        } else if  showDay |=== cd {
            
            cell.style = .current
            
        } else if ( showDay >=== cd) {
            
            cell.style = .after
            
        } else if ( showDay <=== cd) {
            
            cell.style = .before
            
        } else {
            
            cell.style = .empty // 感觉这一步可以省略
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
        let c = collectionView.cellForItem(at: indexPath) as! SNMichealCalendarCell
        guard let d = c.date else {
            return
        }
        selectedDate = d
        collectionView.reloadData()
    }
    
}
