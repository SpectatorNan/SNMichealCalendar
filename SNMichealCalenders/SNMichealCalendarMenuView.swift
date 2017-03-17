//
//  SNMichealCalendarMenuView.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/17.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNMichealCalendarMenuView: UIView {
    
    var showYear: Int
    var showMonth: Int

     init(frame: CGRect, year: Int, month: Int) {
        
        self.showYear = year
        self.showMonth = month
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var monthBtn: UIButton?
    private var lastBtn: UIButton?
    private var nextBtn: UIButton?
    
    func setupView() {
    
        let confirBtn = UIButton()
        addSubview(confirBtn)
        confirBtn.setTitle("确定", for: .normal)
        confirBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirBtn.setTitleColor(UIColor(netHex: 0x00a8c2), for: .normal)
        
        let nextBtn = UIButton()
        addSubview(nextBtn)
        nextBtn.setImage(UIImage(named:"rightArrow"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        self.nextBtn = nextBtn
        
        let monthBtn = UIButton()
        addSubview(monthBtn)
        monthBtn.setTitle("\(showYear)年\(showMonth)月", for: .normal)
        monthBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        monthBtn.setTitleColor(.black, for: .normal)
        monthBtn.addTarget(self, action: #selector(selectMonth), for: .touchUpInside)
        self.monthBtn = monthBtn
        
        let lastBtn = UIButton()
        addSubview(lastBtn)
        lastBtn.setImage(UIImage(named:"leftArrow"), for: .normal)
        lastBtn.addTarget(self, action: #selector(lastMonth), for: .touchUpInside)
        self.lastBtn = lastBtn
        
        confirBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
        make.right.equalToSuperview().offset(SNMichealCalendar_adjustSizeAPP(-50))
            
        }
        
        
        
        monthBtn.snp.makeConstraints { (layout) in
            layout.centerX.equalToSuperview()
            layout.top.equalToSuperview()
        }
        
        nextBtn.snp.makeConstraints { (layout) in
            
            layout.left.equalTo(monthBtn.snp.right).offset(SNMichealCalendar_adjustSizeAPP(40))
            layout.top.equalToSuperview()
            layout.size.equalTo(CGSize(width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        }
        
        lastBtn.snp.makeConstraints { (layout) in
            layout.top.equalToSuperview()
            layout.right.equalTo(monthBtn.snp.left).offset(SNMichealCalendar_adjustSizeAPP(-40))
            layout.size.equalTo(CGSize(width: SNMichealCalendar_adjustSizeAPP(54), height: SNMichealCalendar_adjustSizeAPP(54)))
        }
        
    }

}

extension SNMichealCalendarMenuView {
    
    func lastMonth() {
        showMonth -= 1
        if showMonth < 1 {
            showMonth = 12
            showYear -= 1
        }
        
        updateContent()
    }
    
    func nextMonth() {
        showMonth += 1
        if showMonth > 12 {
            showMonth = 1
            showYear += 1
        }
        
        updateContent()
    }
    
    func selectMonth() {
        
    }
    
    func updateContent() {
        self.monthBtn?.setTitle("\(showYear)年\(showMonth)月", for: .normal)
    }
}
