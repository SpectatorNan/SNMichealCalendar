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
        view = CalendarUntil()
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
        let cs = Calendar.current.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: d!)
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
        let cs = Calendar.current.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: d!)
        print("=========================")
        print("the year - \(cs.year) , the month - \(cs.month) , the day - \(cs.day) , the weekday - \(cs.weekday) , the weekofmonth - \(cs.weekOfMonth)")
        print("=========================")
        
        let d2 = view?.getFirstWeekDayOfWeek(date: Date())
        let cs2 = Calendar.current.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: d2!)
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
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
