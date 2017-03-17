//
//  SNCalendarUntil.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class CalendarUntil {
    
    let date = Date()
    
    lazy var comps : DateComponents = {
        let comps = self.date==>
        return comps
    }()
    
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

enum CalendarMethod {
    
    enum convert {
        case date
    }
}

extension CalendarUntil {
    
    
    
}

// get message
extension CalendarUntil {
    
    /// 当月总共天数
    func getCurrentMonthDaysNum(date: Date) -> Int {
        
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return (range?.count)!
    }
    /// 某年某月多少天
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
        let weekdayComps =  date!==>
        
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
        
        let csf =  firstD==>
        let csl =  lastD==>
        
        let result = (csl.year! - csf.year! + 52 + 1) % 52
        
        return  result
    }
    
    //    本月的第一天
    func getFirstDayOfMonth(date: Date) -> Date {
        
        let compCurrDate =  date==>
        
        var compNewDate = DateComponents()
        compNewDate.year = compCurrDate.year
        compNewDate.month = compCurrDate.month
        compNewDate.weekOfMonth = 1
        compNewDate.day = 1
        
        return calendar.date(from: compNewDate)!
    }
    
    //     本月的最后一天
    func getLastDayOfMonth(date: Date) -> Date {
        
        let compCurrDate =  date==>
        
        var compNewDate = DateComponents()
        compNewDate.year = compCurrDate.year
        compNewDate.month = compCurrDate.month! + 1
        compNewDate.day = 0
        
        return calendar.date(from: compNewDate)!
    }
    
    // 本月一共多少周
    func getWeekNumsOfMonth(date: Date) -> Int {
        
        let d = getLastDayOfMonth(date: date)
        let cs =  d==>
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
        
        let cs =  date==>
        
        var ncs = DateComponents()
        ncs.year = cs.year
        ncs.month = cs.month
        ncs.weekOfMonth = cs.weekOfMonth
        ncs.weekday = calendar.firstWeekday
        
        let weekD = calendar.date(from: ncs)
        
        return weekD!
    }
    
    // 指定年月日获取date
    func getDate(year: Int, month: Int, day: Int) -> Date {
        
        var cs = DateComponents()
        cs.year = year
        cs.month = month
        cs.day = day
        
        let d = calendar.date(from: cs)
        
        return d!
    }
    
    /// 获取本月日期数组
    func getDaysOfMonth(year: Int, month: Int) -> Array<Date> {
        let dayNum = getDaysNum(month: month, year: year)
        
        var a = [Date]()
        for i in 0..<dayNum {
            let d = getDate(year: year, month: month, day: i+1)
            a.append(d)
        }
        return a
    }
}

// make compare
extension CalendarUntil {
    // 是否同一个月
    func compareIsSameMonth(dateA: Date, dateB: Date) -> Bool {
        
        let csA =  dateA==>
        let csB =  dateB==>
        
        let compare = csA.year == csB.year && csA.month == csB.month
        
        return compare
    }
    
    //    是否同一周
    func compareIsSameWeek(dateA: Date, dateB: Date) -> Bool {
        
        let csA =  dateA==>
        let csB =  dateB==>
        
        let compare = csA.year == csB.year && csA.weekOfYear == csB.weekOfYear
        
        return compare
    }
    
    //    是否同一天
    func compareIsSameDay(dateA: Date, dateB: Date) -> Bool {
        
        let csA =  dateA==>
        let csB =  dateB==>
        
        let compare = csA.year == csB.year && csA.month == csB.month && csA.day == csB.day
        
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

