//
//  ViewController.swift
//  WYLog
//
//  Created by 王俨 on 2018/3/2.
//  Copyright © 2018年 https://github.com/wangyansnow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            var i = 2
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        WYLogUtil.wy_log("有没有人曾告诉你")
//        WYLogUtil.wy_log("wy_min", isWriteToFile: true)
//        WYLogUtil.wy_log("dsfdsafjewoiqpwrekjqprjkwqjr32")
//        WYLogUtil.wy_log("有dsfjewqlijwlirji23人曾告诉你")
//        WYLogUtil.wy_log("有没dsfkewqrk3q;2okr;32mlirj32li有人曾告诉你")
//        WYPerson.log()
        
        for i in 0..<1000 {
            DispatchQueue.global().async {
                WYLogUtil.wy_log("i = \(i) ====== ")
            }
        }
        
    }
    
    @objc func wy_test() {
        
    }


}

