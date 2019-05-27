//
//  WebViewController.swift
//  FloatPoint
//
//  Created by 吴昊原 on 2019/5/20.
//  Copyright © 2019 FloatPoint. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    
    lazy var webView: WKWebView = {
        
        let web = WKWebView(frame: self.view.frame);
        
        return web;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.webView);

        self.navigationController?.delegate = FloatPointView.floatPoint
        self.navigationController?.interactivePopGestureRecognizer?.delegate = FloatPointView.floatPoint
        self.openPointView()
        
        let url = URL(string: "https://www.baidu.com")
        self.webView.load(URLRequest(url: url!))
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
