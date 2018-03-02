//
//  ViewController.swift
//  WYLog
//
//  Created by 王俨 on 2018/3/2.
//  Copyright © 2018年 https://github.com/wangyansnow All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for i in 0..<1000 {
            WYPerson.log()
            DispatchQueue.global().async {
                WYLogUtil.wy_log("i = \(i) ====== ")
            }
        }
        
    }
    
    @objc func wy_test() {
        
    }


}

