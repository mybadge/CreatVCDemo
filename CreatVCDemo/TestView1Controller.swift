//
//  TestView1Controller.swift
//  CreatVCDemo
//
//  Created by 赵志丹 on 2018/8/11.
//  Copyright © 2018年 mybadge. All rights reserved.
//

import UIKit

class TestView1Controller: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TestView1"
    }

    override static func storyBoardName() -> StoryBoardName {
        return .main
    }
    
    @IBAction func btnToTest2Action(_ sender: UIButton) {
        let vc = TestView2Controller.creatVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
