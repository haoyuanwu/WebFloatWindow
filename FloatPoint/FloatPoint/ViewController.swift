//
//  ViewController.swift
//  FloatPoint
//
//  Created by 吴昊原 on 2019/5/20.
//  Copyright © 2019 FloatPoint. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let webVC = WebViewController()
        self.navigationController?.pushViewController(webVC, animated: true);
    }
    
}
