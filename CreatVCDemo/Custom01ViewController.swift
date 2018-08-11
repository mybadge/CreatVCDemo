//
//  Custom01ViewController.swift
//  CreatVCDemo
//
//  Created by 赵志丹 on 2018/8/11.
//  Copyright © 2018年 mybadge. All rights reserved.
//

import UIKit

class Custom01ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom01"
        let redView = UIView(frame: CGRect(x: 20, y: 200, width: 300, height: 300))
        redView.backgroundColor = .red
        view.backgroundColor = .white
        view.addSubview(redView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
