//
//  CustomAlertView.swift
//  MySwift
//
//  Created by zhou on 2017/6/24.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit
import SnapKit
class CustomAlertView: UIView {
    //声明闭包
    typealias clickBtn = (_ sender : Int?) -> Void
    //把申明的闭包设置成属性
    var clickSource : clickBtn?
   // 为闭包设置调用函数
    func clickValueSource(closure : clickBtn?) {
        clickSource = closure
    }
    
    
    typealias confirmClick = (_ confirm : Int?) ->Void
    
    var confirmSource : confirmClick?
    
    func confirmValueSource(confirm :  @escaping confirmClick) {
        
        confirmSource = confirm
        
    }
    
    
    
    var studname = { print(0000)}

   
    
    fileprivate lazy var bgView:UIView = {
        
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        bg.backgroundColor = UIColor.black
        bg.alpha = 0.3
        let  tapGes = UITapGestureRecognizer(target: self, action:#selector(hiddenBG(_ :)))
        bg.addGestureRecognizer(tapGes)
        bg.isUserInteractionEnabled = true
        return bg
    }()
    
    fileprivate lazy var popView : UIView = {
       
        let pop = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        pop.layer.masksToBounds = true
        pop.layer.cornerRadius = 5
        pop.backgroundColor = UIColor.white
        return pop
        
    }()
    
     override init(frame: CGRect ) {
        
        

     super .init(frame: frame)
        
        
        
        UIApplication.shared.keyWindow? .addSubview(self)
        
        setupUI()

    }
    
    func setupUI () {
        
        addSubview(bgView)
        popView.center = bgView.center
        addSubview(popView)
        showPop()

        setButton()
        
        
    }
    
    func setButton(){
        
        let y :CGFloat = 80
        let item :CGFloat = (popView.bounds.width-y*2)/3
        
        let title = UILabel()
        title.font = UIFont .systemFont(ofSize: 14)
        title.text = "温馨提示"
        title.textColor = UIColor.black
//        title.frame = CGRect(x: popView.bounds.width/2-40, y: 10, width: 80, height: 20)
        title.textAlignment = NSTextAlignment.center
        popView .addSubview(title)
        
        let subject = UILabel()
//        subject.frame = CGRect(x: 10, y: 60, width: bounds.width-20, height: 20)
        subject.text = "只是一条提示,下一步要测试能否自动化布局"
        subject.textColor = UIColor.orange
        subject.numberOfLines = 0
        subject.font = UIFont.systemFont(ofSize: 14)
        popView .addSubview(subject)
        
        
        
      let cance = UIButton(type: UIButtonType.custom)
//        cance.frame = CGRect(x: item, y: 150, width: y, height: 40)
        cance .setTitle("取消", for: UIControlState.normal)
        cance .setTitleColor(UIColor.red, for: UIControlState.normal)
        cance.titleLabel?.font = UIFont .systemFont(ofSize: 14)
        cance.layer.masksToBounds = true
        cance.layer.cornerRadius = 5
        cance.backgroundColor = UIColor.cyan
        cance.tag = 1
        cance .addTarget(self, action:#selector (buttonClick(sender :)), for: UIControlEvents.touchUpInside)
        popView.addSubview(cance)
        
        
        
        
        let confirm = UIButton(type: UIButtonType.custom)
//        confirm.frame = CGRect(x: item*2+y, y: 150, width: y, height: 40)
        confirm .setTitle("确定", for: UIControlState.normal)
        confirm .setTitleColor(UIColor.red, for: UIControlState.normal)
        confirm.titleLabel?.font = UIFont .systemFont(ofSize: 14)
        confirm.layer.masksToBounds = true
        confirm.layer.cornerRadius = 5
        confirm.backgroundColor = UIColor.cyan
        confirm.tag = 2
        confirm .addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        popView.addSubview(confirm)

        
        
        title.snp.makeConstraints { [weak self] (make) in
            
            make.centerX.equalTo((self?.popView)!)
            make.top.equalTo((self?.popView)!).offset(10)
            make.height.equalTo(20)
            
        }
        subject.snp.makeConstraints { [weak self](make) in
            
            make.left.equalTo((self?.popView)!).offset(10);
            make.right.equalTo((self?.popView)!).offset(-10)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.bottom.equalTo(cance.snp.top).offset(-10)
        }
        
        cance.snp.makeConstraints { [weak self](make) in
            
            make.bottom.equalTo((self?.popView.snp.bottom)!).offset(-10)
            make.left.equalTo(item)
            make.size.equalTo(CGSize(width: y, height: 40))
        
            
        }
        
        confirm.snp.makeConstraints { [weak self](make) in
            
            make.bottom.equalTo((self?.popView.snp.bottom)!).offset(-10)
            make.right.equalTo(-item)
            make.size.equalTo(cance)
            
        }
        
    }
    
 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    

}

extension CustomAlertView{
    
    
    @objc   func buttonClick(sender : UIButton )  {
        
  
        
        hiddenSelf()
        
        print(sender.tag)
        if sender.tag == 2 {
            
            if (clickSource != nil) {
                
                clickSource!(sender.tag)
            }
            
            if (confirmSource != nil) {
                
                confirmSource!(sender.tag)
            }
            
            
            studname()
            
        }
       
        
        
        
    }
    
    
    @objc  func hiddenBG( _ tapGes : UITapGestureRecognizer) {
        
        hiddenSelf()
    }
    
    
    func  showPop()  {
        
        self.popView.layer .setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
        
        UIView.animate(withDuration: 1, animations: {
          
            self.popView.layer .setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))

            
        }) { (Bool) in
            
//            self.popView.layer .setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))

        }
        
        
    }
    
    func hiddenSelf() {
        
        self.popView.layer .setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))

        UIView.animate(withDuration: 0.5 ,animations : {
            
            self.popView.layer .setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
            
        }){(Bool)in
            
            
//            self.bgView .removeFromSuperview()
//            self.popView .removeFromSuperview()
            self .removeFromSuperview()
            
        }
        
    }
    
    
}
