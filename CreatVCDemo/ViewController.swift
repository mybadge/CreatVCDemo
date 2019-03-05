//
//  ViewController.swift
//  initVCDemo
//
//  Created by 赵志丹 on 2018/8/11.
//  Copyright © 2018年 mybadge. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
    }

    
    @IBAction func btnToTest1Action(_ sender: UIButton) {
       let vc = TestView1Controller.initVC()
    
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

