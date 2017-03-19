//
//  SNMichealCalendarManger.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/18.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendarManger: NSObject {
    
    var menu: SNMichealCalendarMenuView?
    var calendarView: SNMichealCalendarHorizonView?
    
    
}

extension SNMichealCalendarManger: SNMichealCalendarMenuViewDelegate {
    internal var menuView: SNMichealCalendarMenuView {
        get {
            return self.menu!
        }
        set {
            self.menu = newValue
        }
    }

    
    func preMenuView() {
        calendarView?.loadPreView()
    }
    
    func nextMenuView() {
        calendarView?.loadNextView()
    }
}


extension SNMichealCalendarManger : SNMichealCalendarHorizonViewDelegate {
    internal var horizonView: SNMichealCalendarHorizonView {
        get {
           return calendarView!
        }
        set {
            calendarView = newValue
        }
    }

    func preHoriView() {
        menuView.loadPreView()
    }
    
    func nextHoriView() {
        menuView.loadNextView()
    }
    
    
}

@objc protocol SNMichealCalendarMenuViewDelegate {
    @objc optional func preMenuView()
    
    @objc optional func nextMenuView()
    
    var menuView: SNMichealCalendarMenuView { set get }
}


@objc protocol SNMichealCalendarHorizonViewDelegate {
    
    @objc optional func preHoriView()
    
    @objc optional func nextHoriView()
    
    var horizonView : SNMichealCalendarHorizonView { set get }
}
