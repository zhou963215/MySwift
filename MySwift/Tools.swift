//
//  Tools.swift
//  MySwift
//
//  Created by zhou on 2017/5/24.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit


enum HTTPRequestMethod : String {
    case GET            = "GET"
    case POST           = "POST"
    case DELETE         = "DELETE"
    case PUT            = "PUT"

}

class Tools: NSObject {

 
    
    var type = HTTPRequestMethod.GET
    
    
    public func publicRequset( _ requestMethod : HTTPRequestMethod){
        
        
        let addCloser1: (_ num1: Int, _ num2: Int) -> (Int)
        
        //为已经创建好的常量 addCloser1 赋值
        
        addCloser1 = {
            
            
            (_ num1: Int, _ num2: Int) -> (Int) in

            return num1 + num2
            
        }
        
        
//        addCloser1 = {
//            
//            (_ num1: Int, _ num2: Int) -> (Int) in
//            
//            return num1 + num2
//            
//        }
        
        //调用闭包并接受返回值
        
        let result = addCloser1(20, 10)
       
        
        print(result)
    }
    
    
    
    public func moer( jisuan : @escaping ( _ first : Int , _ second : Int) -> ( c : Int , chu : Int)){
        
        
       
        
    }
    
  public  func loadData(finishedCallbak: @escaping (_ res : String) -> ()) {
        
        
    DispatchQueue .global().async() {
            
            print("发送网络请求:\(Thread.current)")
            
            DispatchQueue .main.sync {
                print("回调主线程:\(Thread.current)")
                self.publicRequset(.POST)
                
                finishedCallbak("123")
            }

        }

        
        
    }
    
    public func loadMore(finish : @escaping (_ res : Dictionary<String, String>) ->()){
        
        DispatchQueue.global().async {
            
            finish(["name": "jack"])
  
            
        }
        
        
    }
    public func request(sucess : @escaping (_ res : Dictionary<String,String>) ->() , final : @escaping (_ res : Dictionary<String,String>) ->() ){
    
    
        sucess(["name" : "jm"])
        
        final(["cotent" : "fianl"])
    
    }
    
    
}
