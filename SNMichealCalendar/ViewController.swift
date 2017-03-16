//
//  ViewController.swift
//  SNMichealCalendar
//
//  Created by spectator Mr.Z on 2017/3/15.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        view.addSubview(view1)
//        
//        let view2 = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
//        view.addSubview(view2)
//        
//        view1.backgroundColor = UIColor(netHex: 0x00a8c2)
//        view2.backgroundColor = SN_colorWithHexString(hex: "#00a8c2")
        self.navigationController?.navigationBar.isTranslucent = false;
        
        let calendar = SNMichealCalendar(frame: CGRect(x: 0, y: 0, width: SN_ScreenW, height: SN_ScreenH))
        view.addSubview(calendar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

