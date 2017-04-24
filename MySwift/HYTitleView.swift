
//
//  HYTitleView.swift
//  MySwift
//
//  Created by zhou on 2017/4/22.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit

protocol HYTitleViewDelegate : class {
    
    func titleView(_ titleView : HYTitleView, targetIndex : Int)
    
    
}

class HYTitleView: UIView {

    weak var delegete : HYTitleViewDelegate?
    
    fileprivate var titles: [String]
    fileprivate var style : HYTitleStyle
    
    fileprivate lazy var currentIndex : Int = 0
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
        
    
    fileprivate lazy var scrollView:UIScrollView = {
       
       let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.scrollsToTop = false

        
        return scrollView
    }()
    init(frame: CGRect, titles: [String] ,style:HYTitleStyle) {
        
        self.titles = titles
        self.style  = style
        super .init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension HYTitleView {
    
    
    fileprivate func setupUI(){
        
        addSubview(scrollView)
        
        setupTieleLabels()
        setupTitleLabelsFrame()
        setupTitleLabelsFrame()
        
    }
    
    
    private func setupTieleLabels(){
        
        
        for(i,title)in titles.enumerated(){
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = style.normalColor
            titleLabel.font = UIFont.systemFont(ofSize: style.fontSize)
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            let  tapGes = UITapGestureRecognizer(target: self, action:#selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
            
            
        }
        
        
        
        
    }
    
    
    private func setupTitleLabelsFrame(){
        
        let count = titles.count
        for ( i,label) in titleLabels.enumerated(){
            
            var w :CGFloat = 0
            let h :CGFloat = bounds.height
            var x :CGFloat = 0
            let y :CGFloat = 0

            if style.isScrollEnabel {//可以滚动

                
            
             w = (titles[i] as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT),height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
                
                if  i == 0 {
                    
                    
                    x = style.itemMargin * 0.5
                }else{
                    
                    let preLabel = titleLabels[i-1]
                    x = preLabel.frame.maxX + style.itemMargin
                    
                }
                
            }else{//不能滚动
               
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
                
            }
            
            label.frame  = CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        scrollView.contentSize = style.isScrollEnabel ? CGSize(width: titleLabels.last!.frame.maxX+style.itemMargin*0.5, height: 0) : CGSize.zero
    }
    
    
    
}



extension HYTitleView{
    
    
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        
        let targetLabel = tapGes.view as! UILabel

        let sourceLabel = titleLabels[currentIndex]
        
        //切换文字颜色
        
        targetLabel.textColor = style.selectColor
        sourceLabel.textColor = style.normalColor
        
        //记录选中的label
        currentIndex = targetLabel.tag
        
        //通知ContentView进行调整
        
        delegete?.titleView(self, targetIndex: currentIndex)
        
        //调整位置
        
        if style.isScrollEnabel {
            
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            
            if offsetX < 0 {
                
                offsetX = 0
            }
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            
            scrollView.setContentOffset(CGPoint(x : offsetX , y : 0 ), animated: true)
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}










