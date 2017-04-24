//
//  ViewController.swift
//  MySwift
//
//  Created by zhou on 2017/4/21.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        let titles = ["娱乐","美女","头条","搞笑","游戏","趣玩","虞姬", "鲁班", "孙尚香"]
        let style = HYTitleStyle()
        style.isScrollEnabel = true
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count{
            
            let vc  = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
            
            
        }
        view.backgroundColor = UIColor.randomColor()
        let pageFrame = CGRect(x: 0 , y : 64 , width:view.bounds.width,height:view.bounds.height-64)
        
        let pageView  = HYPageView(frame:pageFrame , titles:titles , childs : childVcs, parentVc:self , style :style)
        view .addSubview(pageView)
        
        
        
}
}
//        print(sayHello(personName:"Anna"))
//        
//        
//     incrementBy( 5, 20)
//        
//        var somePoint = Point(x: 4.0, y: 5.0)
//        if somePoint.isToTheRightOfX(x: 1.0) {
//            print("This point is to the right of the line where x == 1.0")
//        }
//      somePoint.moveByX(deltaX: 2.0, y: 3.0)
//        
//        print(somePoint)
//    }
//    
//    struct Point {
//        var x = 0.0, y = 0.0
//        mutating func moveByX(deltaX: Double, y deltaY: Double) {
//            x += deltaX
//            y += deltaY
//        }
//        func isToTheRightOfX(x: Double) -> Bool {
//            return self.x > x
//        }
//    }
//    
//    func incrementBy(_ amount:Int, _ numberOfTimes:Int){
//        
//        
//       count += amount * numberOfTimes
//    }
//
//
//    
//    
//    func sayHello(personName:String) -> String {
//        
//        let greeting  = "Hello, "+personName+"!"
//        return greeting
//        
//        
//        
//    }
   



