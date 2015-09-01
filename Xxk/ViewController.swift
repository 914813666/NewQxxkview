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
        
        var v1 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.grayColor())
        var v2 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.redColor())
        var v3 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.yellowColor())
        var v4 = TestView(frame: CGRectMake(0, 0, w, h), color: UIColor.purpleColor())
        
        
        var  xview = QxxkView(frame:CGRectMake(0, 50, self.view.bounds.size.width, 400),viewTitles:["新闻","艺术","本地新闻","三个字"],views:[v1,v2,v3,v4])
        self.view.addSubview(xview)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

