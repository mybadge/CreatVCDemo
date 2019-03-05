//
//  TestView2Controller.swift
//  initVCDemo
//
//  Created by 赵志丹 on 2018/8/11.
//  Copyright © 2018年 mybadge. All rights reserved.
//

import UIKit

class TestView2Controller: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TestView2"
    }

    override class func storyBoardName() -> StoryBoardName {
        return .project
    }

    
}
