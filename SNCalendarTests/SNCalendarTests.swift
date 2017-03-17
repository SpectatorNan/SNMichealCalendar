//
//  SNCalendarTests.swift
//  SNCalendarTests
//
//  Created by Spectator on 2017/3/16.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import XCTest
@testable import SNMichealCalendar
class SNCalendarTests: XCTestCase {
    
    var view : CalendarUntil?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = CalendarUntil.current
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        view = nil
    }
    
    func testGetLastDayOfMonth() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let d = view?.getLastDayOfMonth(date: Date())
        let cs = d!==>
        print("=========================")
        print("the year - \(cs.year) , the month - \(cs.month) , the day - \(cs.day) , the weekday - \(cs.weekday) , the weekofmonth - \(cs.weekOfMonth)")
        print("=========================")
    }
    
    func testGetWeeksOfMonth() {
        
        let num = view?.getWeekNumsOfMonth(date: Date())
        print("=========================")
        print("weeks - \(num)")
        print("=========================")
    }
    
    func testGetNumberOfWeeks() {
        
        let num = view?.getNumberOfWeeks(date: Date())
        print("=========================")
        print("getNumberOfWeeks - \(num)")
        print("=========================")
    }
    
    func testGetFirstWeekdayOfMonth() {
        
        let d = view?.getFirstWeekDayOfMonth(date: Date())
        let cs =  d!==>
        print("=========================")
        print("the year - \(cs.year) , the month - \(cs.month) , the day - \(cs.day) , the weekday - \(cs.weekday) , the weekofmonth - \(cs.weekOfMonth)")
        print("=========================")
        
        let d2 = view?.getWeekDayOfWeek(date: Date(),weekDay: 1)
        let cs2 =  d2!==>
        print("=========================")
        print("the year - \(cs2.year) , the month - \(cs2.month) , the day - \(cs2.day) , the weekday - \(cs2.weekday) , the weekofmonth - \(cs2.weekOfMonth)")
        print("=========================")
    }
    
    func testTotalDayNums() {
        let n = view?.getCurrentMonthDaysNum(date: Date())
        print("=========================")
        print("total days count - \(n)")
        print("=========================")
    }
    
    func testDaysNum() {
        let n = view?.getDaysNum(month: 2, year: 2017)
        print("=========================")
        print("total days count - \(n)")
        print("=========================")
    }

    func testGetWeekDay() {
        
        let n = view?.getWeekDay(day: 16, month: 3, year: 2017)
        print("=========================")
        print("total days count - \(n)")
        print("=========================")
    }
    
    func testExample() {
        let dayNum = view?.getDaysNum(month: 3, year: 2017)
        
        var a = [Date]()
        for i in 0..<dayNum! {
            let d = view?.getDate(year: 2017, month: 3, day: i+1)
            let cs = d!==>
            print("=========================")
            print(" \(cs.year!)  - \(cs.month!)  - \(cs.day!)")
            print("=========================")
            a.append(d!)
        }
    }
    
    func testOP() {
        var a = 8
        var b = 8
        
        a -= 1
        
        b += 1
        
        print("=========================")
        print("a - \(a) , b - \(b)")
        print("=========================")
    }

    
    func testOper() {
        let cs2 = Date()==>
        
        print("=========================")
        print("the year - \(cs2.year) , the month - \(cs2.month) , the day - \(cs2.day) , the weekday - \(cs2.weekday) , the weekofmonth - \(cs2.weekOfMonth)")
        print("=========================")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
