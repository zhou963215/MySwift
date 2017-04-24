//
//  HYPageView.swift
//  MySwift
//
//  Created by zhou on 2017/4/22.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit

class HYPageView: UIView {

    fileprivate var titles : [String]
    fileprivate var childs : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate var style : HYTitleStyle

    fileprivate var titleView : HYTitleView!
    
    init(frame: CGRect , titles : [String] , childs: [UIViewController] , parentVc : UIViewController, style:HYTitleStyle) {
        
        self.titles = titles;
        self.childs = childs;
        self.parentVc = parentVc
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
// MARK:- 设置UI界面

extension HYPageView{
    
    
    fileprivate func setupUI(){
        
        setupTitleView()
        setupConententView()
    }
    
    private func setupTitleView(){
        
        let  titleFrame  = CGRect(x: 0,y: 0, width: bounds.width , height:style.titleHeight)
        titleView = HYTitleView(frame: titleFrame, titles: titles,style:style)
        
      addSubview(titleView)
        
    }
    
    private func setupConententView(){
        
        let contentFrame = CGRect(x: 0 , y: style.titleHeight, width : bounds.width , height:bounds.height-style.titleHeight)
        
        
        let  contentView = HYContentView(frame : contentFrame ,childVcs:childs , parentVC : parentVc)
        
        addSubview(contentView)
        contentView.backgroundColor = UIColor.randomColor()
        
        //让contentView成为titleView的代理
        titleView.delegete = contentView
    }
    
}
