//
//  QxxkView.swift
//  Xxk
//
//  Created by qzp on 15/8/31.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

class QxxkView: UIView {
    ///视图页面
    var viewControllers: [UIViewController]!
    
    var views: [UIView]!
    ///视图对应的标题
    var viewTitles: [String]!
    ///视图对应的图片
    //var viewImages: [UIImage]?
    
    ///当前选择的第几个视图
    var currentIndex: Int = 0
    
    ///标题栏高度
    var topHeight: CGFloat = 40
    ///标题栏宽度
    var topWidth: CGFloat = 100
    //是否抖动
    var canShake: Bool = true
    
    ///回调
    var QxxkViewClickIndex: ((index: Int) -> Void)?
    
    
    
    var barLabelColor: UIColor = UIColor.orangeColor()
    
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let garyColor = UIColor(red: 222.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha: 1)
    
    
    private var topScrollView: UIScrollView!
    private var centerScrollView: UIScrollView!
    private var topBarLabel: UILabel!

    private let TAG: Int = 10000
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        initializeUserInterface()
    }
    
    init(frame: CGRect,viewTitles: [String], views: [UIView]) {
        super.init(frame: frame)
        self.viewTitles = viewTitles
        self.views = views
        initializeUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUserInterface() {
        let selfWidth = self.bounds.size.width
        let selfHeight = self.bounds.size.height
        
        //print(selfWidth)
        
        topScrollView = {
            let scrollview = UIScrollView(frame: CGRect(x: 0,y: 0,width: selfWidth,height: self.topHeight))
            self.addSubview(scrollview)
            scrollview.delegate = self
            scrollview.showsHorizontalScrollIndicator = false
            scrollview.backgroundColor = UIColor.whiteColor()
            scrollview.contentSize = CGSizeMake( self.topWidth * CGFloat(self.viewTitles.count),0)
            return scrollview
            }()
        
        let topLineLabel1 = UILabel(frame: CGRectMake(0, CGRectGetMinY(topScrollView.frame), selfWidth, 1))
        topLineLabel1.backgroundColor = garyColor
        self.addSubview(topLineLabel1)
        
        let topLineLabel2 = UILabel(frame: CGRectMake(0, CGRectGetMaxY(topScrollView.frame)-1, selfWidth, 1))
        topLineLabel2.backgroundColor = garyColor
        self.addSubview(topLineLabel2)
        
        topBarLabel = UILabel(frame: CGRectMake(CGFloat(self.currentIndex) * self.topWidth, CGRectGetHeight(topScrollView.frame)-3, self.topWidth, 3))
        topBarLabel.backgroundColor = self.barLabelColor;
        topScrollView.addSubview(topBarLabel)
        
        var leftX: CGFloat = 0;
        for(var i = 0; i < self.viewTitles.count; i++) {
            leftX =   CGFloat(i) * self.topWidth
            let label = UILabel(frame: CGRectMake(leftX, 0, self.topWidth, self.topHeight))
            label.text = self.viewTitles[i]
            label.textAlignment = .Center
            topScrollView.addSubview(label)
            
            let btn = UIButton(frame: CGRectMake(leftX, 0, self.topWidth, self.topHeight))
            btn.addTarget(self, action: Selector("buttonClick:"), forControlEvents: .TouchUpInside)
            btn.tag = TAG + i
            topScrollView.addSubview(btn)
       }
        
        
        centerScrollView = {
            let scrollView = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), selfWidth, selfHeight - self.topHeight))
            scrollView.delegate = self
            scrollView.pagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.contentSize = CGSizeMake( selfWidth * CGFloat(self.viewTitles.count),0)
            self.addSubview(scrollView)
            return scrollView
            }()
        
        var cLeftx: CGFloat = 0;
        for(var i = 0; i < self.viewTitles.count; i++) {
            cLeftx = CGFloat(i) * selfWidth
            //println(cLeftx)
            let view = UIView(frame: CGRectMake(cLeftx, 0, selfWidth, CGRectGetHeight(centerScrollView.frame)))
            centerScrollView.addSubview(view)
            view.addSubview(self.views[i])
        }
    
        
    }
    
    func buttonClick(btn: UIButton) {
        self.scrollViewStop(btn)
        let tag = btn.tag - TAG
     //   println(tag)
        let selfWidth = self.bounds.size.width
        self.centerScrollView.contentOffset = CGPointMake(CGFloat(tag) * selfWidth, 0)
    }
    
    func scrollViewStop(btn: UIButton) {
        let tag = btn.tag - TAG
        //println(tag)
        self.currentIndex = tag
        let selfWidth = self.bounds.size.width
        // self.centerScrollView.contentOffset = CGPointMake(CGFloat(tag) * selfWidth, 0)
        
        btn.userInteractionEnabled = false
        for (var i = TAG ; i < TAG + self.viewTitles.count; i++) {
            if i != btn.tag {
                let mybtn: UIButton = self.viewWithTag(i) as! UIButton
                mybtn.userInteractionEnabled = true
            }
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            var frame = self.topBarLabel.frame
            frame.origin.x = self.topWidth * CGFloat(tag)
            self.topBarLabel.frame = frame
            
            }) { (_) -> Void in
                if self.canShake == false {return}
                
                let currentOX = self.topBarLabel.frame.origin.x
                let rCX = currentOX + 5
                
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    var frame = self.topBarLabel.frame
                    frame.origin.x = rCX
                    self.topBarLabel.frame = frame
                    }, completion: { (_) -> Void in
                        var frame = self.topBarLabel.frame
                        frame.origin.x = currentOX
                        self.topBarLabel.frame = frame
                })
                
                
        }
        
        topScrollViewEndPosition()
        
        self.QxxkViewClickIndex?(index: self.currentIndex)
        
    }
    
    ///
    func topScrollViewEndPosition() {
        let x = self.topBarLabel.frame.origin.x
        var  a : CGFloat = self.topWidth * CGFloat(self.currentIndex+1) - CGRectGetWidth(self.topScrollView.frame) + self.frame.size.width/2
        //println(self.topScrollView.contentSize.width )
        if a < 0 {a=0}
        if x + self.topWidth >= self.topScrollView.contentSize.width - self.frame.size.width/2  {
            a = self.topScrollView.contentSize.width - CGRectGetWidth(self.topScrollView.frame)
        }
        //println(a)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.topScrollView.contentOffset = CGPointMake(a, 0)
            }, completion: { (b ) -> Void in
                
        })
    }
    
}

extension QxxkView: UIScrollViewDelegate {
 
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.centerScrollView {
            let index: Int = Int(scrollView.contentOffset.x / CGRectGetWidth(self.topScrollView.frame))
           // print(index)
            let btn: UIButton = self.viewWithTag(TAG+index) as! UIButton
            scrollViewStop(btn)
        }
    }
    
    

}
