//
//  UIView-Controller.swift
//  MySwift
//
//  Created by zhou on 2017/6/26.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit

extension UIView{
    
    
    
    func viewControll() -> UIViewController?{
        
        var next : UIResponder? = self.next
        
        repeat{
            if (next is UIViewController) {
                
                
               return next as? UIViewController
                
            }
            next = next?.next
        }while next != nil
        
        return nil
    }
    
    
    func navigationController() -> UINavigationController? {
        
        
       return viewControll()?.navigationController
        
        
        
    }
    
    
    
}
