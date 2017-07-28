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
    let tools = Tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tools.delegate = self
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "弹框", style: .plain, target: self, action:#selector(alertShow))
        
        automaticallyAdjustsScrollViewInsets = false
        let titles = ["娱乐","美女","头条","搞笑","游戏","趣玩","虞姬", "鲁班", "孙尚香"]
        let style = HYTitleStyle()
        style.isScrollEnable = true
        style.isShowScrollLine = true
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count{
            
            let vc  = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
            
            
        }
//        view.backgroundColor = UIColor.randomColor()
        let pageFrame = CGRect(x: 0 , y : 64 , width:view.bounds.width,height:view.bounds.height-64)
        
        let pageView  = HYPageView(frame:pageFrame , titles:titles , childs : childVcs, parentVc:self , style :style)
//        view .addSubview(pageView)
      //        view .addSubview(custom)
        
        
        var array = ["C","B","E","A","D"]
        
        //以前可以自定义函数名称传递升降序。然而我现在发现不能传递自定义函数名玩了。
        func backwords(s1: String, s2: String) -> Bool {
            return s1 > s2
        }
        
              //普通属性
        var firstName:String = ""
        var lastName:String  = ""
        var nickName:String  = ""
        
        var age:Int = 0
        {
            //我们需要在age属性变化前做点什么
            willSet
            {
                print("Will set an new value \(newValue) to age")
            }
            //我们需要在age属性发生变化后，更新一下nickName这个属性
            didSet
            {
                
                
                print("age filed changed form \(oldValue) to \(age)")
                if age<10
                {
                    nickName = "Little"
                    
                    
                }else
                {
                    nickName = "Big"
                }
            }
        }
        
        age = 10
        print(nickName)
}
    
    func ddddddd(){
        
        
        
    }
    
    func alertShow() {
        
        let customFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let custom = CustomAlertView(frame: customFrame)
        
        custom.studname = {
            
            
            //            self.navigationController? .pushViewController(PopViewController(), animated: true)
            
            //           self.view .backgroundColor = UIColor.orange
        }
        custom.clickValueSource { (sender) in
            
            print("取消当前决定")
            
        }
        custom.confirmValueSource { (sender) in
            
            self.navigationController? .pushViewController(PopViewController(), animated: true)
            
//            self.view .backgroundColor = UIColor.orange
            
            
        }

        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        view.endEditing(true)
        
        tools.moer { (a, b) -> (c: Int, chu: Int) in
            
            
            
            
            return (a * b , a/b)
            
        }
        
        tools.loadData { (res) in
            
            print(res)
            
        }
        
        tools.loadMore { (res) in
            
            print(res)
            
        }
        
      
        tools.request(sucess: { (res) in
           
            print(res)
            
        }) { (res) in
           
            print(res)
        }
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
   

extension ViewController:DDViewDelegate{
    
    
    
    func ddddddd(_ name: String) {
        print(name)
    }
    
    
    
}

