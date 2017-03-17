//
//  SNOperator.swift
//  SNMichealCalendar
//
//  Created by Spectator on 2017/3/17.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import Foundation


postfix operator ==>
postfix func ==>(date:Date) -> DateComponents {
    let cs = Calendar.current.dateComponents([.day,.era,.year,.month,.hour,.minute,.second,.weekday,.weekdayOrdinal,.quarter,.weekOfMonth,.weekOfYear,.yearForWeekOfYear,.nanosecond,.calendar,.timeZone], from: date)
    
    return cs
}


