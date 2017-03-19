//
//  SNCalendarUntil.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class CalendarUntil {
    
   static let current = CalendarUntil()
    private init() {

    }
    
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

// 占位
enum CalendarMethod {

    case assignDateToDate //指定年月日，获取某天(Date)
    
    enum Day {
        case weekDayAtDay //指定年月日，获取周几(1--周一，7--周日)
        case firstWeekday //给定日期，获取本月第一天
        case lastWeekday //给定日期，获取本月最后一天
        case assignWeekdayByDate //给定日期和指定周几，获取周几是某天
    }
    
    enum Month {
        case fetchDates // 指定年月，获取该月日期(Date数组)
        case daysByDate // 指定日期，获取当月天数
        case daysAtMonth // 指定年月，获取当月天数
        case weeksCount // 指定日期，获取当月周数
        case firstWeekdayOfMonth //指定日期，获取当期第一个周日是某天(第一行第一天，很有可能是上个月最后一个周日)
    }
    
    enum compare {
        case samemonth  //比较是不是同一月
        case sameweek //比较是不是同一周
        case sameday //比较是不是同一天
        case after // 是不是在某天(后面的Date)之后
        case before //是不是在某天(后面的Date)之前
        case between //是不是在A天(date)在B天(startDate)和C天(endDate)之间
    }
    
}

// MARK: get some info
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
    
    // 本月一共多少周(2017.4这个月份有问题)
    func getWeekNumsOfMonth(date: Date) -> Int {
        
        let d = getLastDayOfMonth(date: date)
        let cs =  d==>
        return cs.weekOfMonth!
    }
    
    //  计算本月几周(结果貌似有问题)(2017.4这个月份有问题)
    func getNumberOfWeeks(date: Date) -> Int {
        
        let firstD = getFirstDayOfMonth(date: date)
        let lastD = getLastDayOfMonth(date: date)
        
        let csf =  firstD==>
        let csl =  lastD==>
        
        let result = (csl.weekOfYear! - csf.weekOfYear! + 52 + 1) % 52
        
        return  result
    }
    
    
    //本期第一个周日是哪天(含上月)(国外周日为每周第一天)
    func getFirstWeekDayOfMonth(date: Date) -> Date {
        
        let d = getFirstDayOfMonth(date: date)
        let wd = getWeekDayOfWeek(date: d,weekDay: 1)
        
        return wd
        
    }
    
    //根据某天获取当周的周几 // 1.周日 2.周一 3.周二  4.周三 5.周四 6.周五 7.周六
    func getWeekDayOfWeek(date: Date, weekDay: Int) -> Date {
        
        let cs =  date==>
        
        var ncs = DateComponents()
        ncs.year = cs.year
        ncs.month = cs.month
        ncs.weekOfMonth = cs.weekOfMonth
        ncs.weekday = weekDay
        
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


// MARK: compare date
//    是否同一天
infix operator |===
func |===(dateA: Date, dateB: Date) -> Bool {
    let csA =  dateA==>
    let csB =  dateB==>
    
    let compare = csA.year == csB.year && csA.month == csB.month && csA.day == csB.day
    
    return compare
}

//    是否同一周
infix operator ||==
func ||==(dateA: Date, dateB: Date) -> Bool {
    let csA =  dateA==>
    let csB =  dateB==>
    
    let compare = csA.year == csB.year && csA.weekOfYear == csB.weekOfYear
    
    return compare
}


// 是否同一个月
infix operator |||=
func |||=(dateA: Date, dateB: Date) -> Bool {
    let csA =  dateA==>
    let csB =  dateB==>
    
    let compare = csA.year == csB.year && csA.month == csB.month
    
    return compare
}

//    是否在某天之后(含当天)
infix operator >===
func >===(dateA: Date, dateB: Date) -> Bool {
    
    let compare = dateA.compare(dateB) == .orderedDescending || ( dateA |=== dateB)
    
    return compare
}

//    是否在某天之前(含当天)
infix operator <===
func <===(dateA: Date, dateB: Date) -> Bool {
    
    let compare = dateA.compare(dateB) == .orderedAscending || ( dateA |=== dateB)
    
    return compare
}

// make compare
 extension CalendarUntil {
    //    是否在某段时间之间
    func compare(date:Date,between startDate: Date, and endDate: Date) -> Bool {
        
        let compare1 =  (date >=== startDate) && (dateA: date <=== endDate)
        
        return compare1
    }
}

// MARK: Calendar calculate
extension CalendarUntil {
    
    func fetchLastMonth( year: Int, month: Int) -> (Int, Int) {
    
        var year = year
        var month = month
        
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
        return (year, month)
    }
    
    func fetchNextMonth( year: Int, month: Int) -> (Int, Int) {
        
        var year = year
        var month = month
        
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
        
        return (year, month)
    }
    
    func backAMonth( year: inout Int, month: inout Int) {

        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
    }
    
    func nextAMonth( year: inout Int, month: inout Int) {
        
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
    }
    
    
    
}



