//
//  ViewController.swift
//  Xxk
//
//  Created by qzp on 15/8/31.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let w = self.view.bounds.size.width
        let h = self.view.bounds.size.height
        
        let v1 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.grayColor())
        let v2 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.redColor())
        let v3 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.yellowColor())
        let v4 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.purpleColor())
        
        
        let  xview = QxxkView(frame:CGRectMake(0, 50, self.view.bounds.size.width, 400),viewTitles:["新闻","艺术","本地新闻","三个字","HELLO","天"],views:[v1,v2,v3,v4,v2,v1])
        xview.canShake = false
        self.view.addSubview(xview)
        xview.QxxkViewClickIndex = {(index: Int)  in
            print(index)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

