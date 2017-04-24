//
//  HYContentVIew.swift
//  MySwift
//
//  Created by zhou on 2017/4/22.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit
private let kContenViewCellID = "kContenViewCellID"


protocol HYContentViewDelegate : class {
    
    func contentView(_ contentView : HYContentView , targetIndex : Int)
    func contentView(_ contentView : HYContentView , targetIndex : Int , progress : CGFloat)
    
}

class HYContentView: UIView {

    weak var delegate : HYContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    
    fileprivate var  startOffsetX : CGFloat = 0
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView (frame:self.bounds,collectionViewLayout:layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContenViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false

       return collectionView
    }()
    
     init(frame: CGRect, childVcs:[UIViewController] , parentVC: UIViewController) {
        
        self.childVcs = childVcs
        self.parentVC = parentVC
        
        
        super .init(frame: frame)
        
               setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension HYContentView{
    
    fileprivate func setupUI(){
      //1. 将我们的所有子控制器添加到父控制器中
        
        for chlidVc in childVcs{
            
            parentVC.addChildViewController(chlidVc)
            
        }
        //添加collectionView
        addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
}

extension HYContentView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContenViewCellID, for: indexPath)
        for subView in cell.contentView.subviews{
            
            subView.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView .addSubview(childVc.view)
        
        return cell
    }
    
    
    
    
}


// MARK:- UICollectionView的delegate


extension HYContentView : UICollectionViewDelegate{
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
      contentEndScroll()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            contentEndScroll()
        }
    }
    
    private func contentEndScroll(){
        
        //1.获取滚动到的位置
        
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        //通知titleView进行调整
        
        delegate?.contentView(self, targetIndex: currentIndex)
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断和开始的偏移量是否一致
        guard startOffsetX != scrollView.contentOffset.x else {
            
            return
        }
        
        //定义targentIndex/progress
        
        var targetIndex = 0
        var progress : CGFloat = 0.0
        
        //给targetIndex/Progress赋值
        let currentIndex = Int(startOffsetX / scrollView.bounds.width)
        
        if  startOffsetX < scrollView.contentOffset.x { //左滑动
            
            targetIndex = currentIndex + 1
            if targetIndex > childVcs.count - 1 {
                
                targetIndex = childVcs.count - 1
            }
            
            progress = (scrollView.contentOffset.x - startOffsetX) / scrollView.bounds.width
            print(progress)
        }else{//右滑动
            
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                
                targetIndex = 0
            }
           progress = (startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.width
            print(progress)

        }   
        
       delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
    }
    
}





extension HYContentView : HYTitleViewDelegate{
    
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int) {
        
        let  indexPath = IndexPath(item: targetIndex, section: 0)
        startOffsetX = collectionView.bounds.width * CGFloat(targetIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
    }
    
    
}




