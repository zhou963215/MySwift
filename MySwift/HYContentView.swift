//
//  HYContentVIew.swift
//  MySwift
//
//  Created by zhou on 2017/4/22.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit
private let kContenViewCellID = "kContenViewCellID"
class HYContentView: UIView {

    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView (frame:self.bounds,collectionViewLayout:layout)
        collectionView.dataSource = self
       return collectionView
    }()
    
     init(frame: CGRect, childVcs:[UIViewController] , parentVC: UIViewController) {
        
        self.childVcs = childVcs
        self.parentVC = parentVC
        
        
        super .init(frame: frame)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContenViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
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

extension HYContentView : HYTitleViewDelegate{
    
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int) {
        
        let  indexPath = IndexPath(item: targetIndex, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        
    }
    
    
}




