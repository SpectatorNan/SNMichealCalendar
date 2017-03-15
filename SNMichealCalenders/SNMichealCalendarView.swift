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
    
    var numberOfDaysCurrentMonth: Int?
    var numberOfDaysLastMonth: Int?
    var firstDayCurrentMonth: Int?
    var firstDayNextMonth: Int?
    var lastDayLastMonth: Int?
    var numberOfDaysNextMonth: Int?
    
    
     override init(frame: CGRect) {
        super.init(frame: frame)
  
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
        
        contentView.snp.makeConstraints { (layout) in
            layout.edges.equalToSuperview()
        }
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
