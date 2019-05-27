//
//  FloatPointView.swift
//  FloatPoint
//
//  Created by 吴昊原 on 2019/5/20.
//  Copyright © 2019 FloatPoint. All rights reserved.
//

import UIKit

class FloatPointView: NSObject,UIGestureRecognizerDelegate,UINavigationControllerDelegate{
    
    static let floatPoint = FloatPointView();
    
    let window = UIApplication.shared.keyWindow
    let screenWith = UIScreen.main.bounds.width
    let screenHright = UIScreen.main.bounds.height
    let bgImg = UIImageView()
    let imageView = UIImageView()
    let floatImg = UIImageView()
    let floatLabel = UILabel()
    var formViewController:UIViewController? = nil
    var tmpViewController:UIViewController? = nil
    var isOpenVC = false;
    
    open var openPointVC:((_ viewConttoller:UIViewController) -> Void)? = nil;
    
    lazy var pointView: UIView = {
        let pointV = UIView(frame: CGRect(x: UIScreen.main.bounds.width-70, y: UIScreen.main.bounds.height/3, width: 60, height: 60))
        pointV.layer.cornerRadius = pointV.frame.size.height/2;
        pointV.layer.masksToBounds = true
        pointV.isHidden = true;
        pointV.backgroundColor = UIColor.white
        
        self.imageView.frame = CGRect(x: 2.5, y: 2.5, width: 55, height: 55)
        self.imageView.image = UIImage(named: "pointLine")
        self.imageView.isUserInteractionEnabled = true;
        self.imageView.contentMode = UIViewContentMode.scaleToFill;
        pointV.addSubview(self.imageView)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openViewController(sender:)))
        pointV.addGestureRecognizer(tap)
        return pointV
    }()
    
    lazy var floatView: UIView = {
        
        let floatV = UIView(frame: CGRect(x: self.screenWith, y: self.screenHright, width: self.screenWith/3, height: self.screenWith/3))
        
        self.bgImg.frame = CGRect(x: 0, y: 0, width: floatV.frame.size.width, height: floatV.frame.size.height)
        self.bgImg.contentMode = UIViewContentMode.scaleToFill
        self.bgImg.image = UIImage(named: "floatWindow")
        floatV.addSubview(self.bgImg)
        
        self.floatImg.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.floatImg.center = bgImg.center
        self.floatImg.image = UIImage(named: "floatPoint")
        self.floatImg.contentMode = UIViewContentMode.scaleToFill
        bgImg.addSubview(self.floatImg)
        
        self.floatLabel.frame = CGRect(x: 0, y: floatV.frame.size.height-40, width: floatV.frame.size.width, height: 30)
        self.floatLabel.font = UIFont.systemFont(ofSize: 15)
        self.floatLabel.textColor = UIColor.white
        self.floatLabel.textAlignment = NSTextAlignment.center
        self.floatLabel.text = "浮窗"
        bgImg.addSubview(self.floatLabel)
        
        
        return floatV
    }()
    
    override init() {
        super.init()
        

    }
    
    open func isPushVCAnimation() -> PushAnimation? {
        let FPControl = FloatPointView.floatPoint
        if FPControl.isOpenVC {
            return PushAnimation()
        }else{
            return nil;
        }
    }
    
    open func isPopVCAmoation() -> PopAnimation? {
        let FPControl = FloatPointView.floatPoint
        if FPControl.isOpenVC{
            return PopAnimation()
        }else{
            return nil;
        }
    }
    
    @objc func openViewController(sender:UIViewController) {
        if self.openPointVC != nil {
            self.openPointVC!(FloatPointView.floatPoint.formViewController!)
        }
    }
    
    
    open func openPoint() {

        if (!self.window!.subviews.contains(self.floatView)) {
            self.window!.addSubview(self.floatView)
            self.window!.addSubview(self.pointView)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
            self.pointView.addGestureRecognizer(pan);
        }
    }
    
    @objc func panGestureAction(sender:UIPanGestureRecognizer) {
        let points = sender.location(in: self.window)
        
        var rect = self.pointView.frame;
        switch sender.state {
        case .began:
            
            UIView.animate(withDuration: 0.25) {
                self.floatView.transform = CGAffineTransform(translationX: -self.screenWith/3, y: -self.screenWith/3)
            }
            
            break
        case .changed:
            rect.origin = CGPoint(x: points.x-25, y: points.y-25)
            self.pointView.frame = rect;
            if self.floatView.frame.contains(self.pointView.frame) {
                self.bgImg.image = UIImage(named: "floatWindowCancel")
                self.floatImg.image = UIImage(named: "floatPointCancel")
                self.floatLabel.text = "取消浮窗"
            }else{
                self.bgImg.image = UIImage(named: "floatWindow")
                self.floatImg.image = UIImage(named: "floatPoint")
                self.floatLabel.text = "浮窗"
            }
            break
        case .ended:
            let screenWidth = UIScreen.main.bounds.width;
            let max = screenWidth-60;
            let min:CGFloat = 0.0;
            let max_x = self.pointView.frame.origin.x;
            UIView.animate(withDuration: 0.25) {
                if max_x >= max || (max_x < max && max_x > screenWidth/2.0) {
                    var rect = self.pointView.frame;
                    rect.origin.x = max - 10
                    self.pointView.frame = rect;
                }else if max_x <= min || (max_x > min && max_x < screenWidth/2.0)  {
                    var rect = self.pointView.frame;
                    rect.origin.x = min + 10
                    self.pointView.frame = rect;
                }
            }
            if self.floatView.frame.contains(self.pointView.frame) {
                self.pointView.isHidden = true
                self.pointView.frame = CGRect(x: UIScreen.main.bounds.width-70, y: UIScreen.main.bounds.height/3, width: 60, height: 60)
                self.formViewController = nil
                self.bgImg.image = UIImage(named: "floatWindow")
                self.floatImg.image = UIImage(named: "floatPoint")
                self.floatLabel.text = "浮窗"
            }
            UIView.animate(withDuration: 0.25) {
                self.floatView.transform = CGAffineTransform.identity
            }
            
            break
        default:
            break
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (operation == .push){
            return FloatPointView.floatPoint.isPushVCAnimation()
        }else{
            return FloatPointView.floatPoint.isPopVCAmoation()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = (viewController.navigationController!.viewControllers.count > 1) ? true : false
    }
    
    @objc func closePointView() {
        self.floatView.removeFromSuperview()
        self.pointView.removeFromSuperview()
        self.formViewController = nil
        self.pointView.isHidden = true
        self.isOpenVC = false
    }
    
}
