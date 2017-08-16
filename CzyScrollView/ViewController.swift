//
//  ViewController.swift
//  CzyScrollView
//
//  Created by macOfEthan on 17/8/16.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

import UIKit

var scrollView:UIScrollView?
var pageControl:UIPageControl?

let kCzyFullWidth:CGFloat = UIScreen.main.bounds.size.width
let kczyFullHeight:CGFloat = UIScreen.main.bounds.size.height

var leftImageView:UIImageView?
var centerImageView:UIImageView?
var rightImageView:UIImageView?

var centerIndex:NSInteger = 0
var leftIndex:NSInteger = 0
var rightIndex:NSInteger = 0

class ViewController: UIViewController , UIScrollViewDelegate {

    var imageNames:[String] = {
        
        var imgs:[String]? = [String]()
        
        for i in 0...6 {
            imgs?.append("\(i+1)")
        }
        
        return imgs!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.staticUI()
    }

    func staticUI() -> Void {
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kCzyFullWidth, height: kczyFullHeight))
        scrollView?.contentSize = CGSize.init(width: (CGFloat)(self.imageNames.count)*kCzyFullWidth, height: kczyFullHeight)
        scrollView?.backgroundColor = UIColor.black
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.bounces = false
        scrollView?.delegate = self
        self.view.addSubview(scrollView!)
        
        leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kCzyFullWidth, height: kczyFullHeight))
        centerImageView = UIImageView.init(frame: CGRect.init(x: kCzyFullWidth, y: 0, width: kCzyFullWidth, height: kczyFullHeight))
        centerImageView?.contentMode = .scaleAspectFit
        rightImageView = UIImageView.init(frame: CGRect.init(x: 2*kCzyFullWidth, y: 0, width: kCzyFullWidth, height: kczyFullHeight))
        
        scrollView?.addSubview(leftImageView!)
        scrollView?.addSubview(centerImageView!)
        scrollView?.addSubview(rightImageView!)
        
        //设置默认图片
        centerImageView?.image = UIImage(named: self.imageNames[centerIndex])
        
        //三张图片 默认显示第一张
        scrollView?.contentOffset = CGPoint.init(x: kCzyFullWidth, y: 0)
        
        pageControl = UIPageControl.init(frame: CGRect.init(x: kCzyFullWidth/2-100, y: kczyFullHeight-60, width: 200, height: 30))
        pageControl?.pageIndicatorTintColor = UIColor.lightGray
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.numberOfPages = self.imageNames.count
        pageControl?.currentPage = 0
        self.view.addSubview(pageControl!)
    }
}

extension ViewController{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentOffsetX:CGFloat = scrollView.contentOffset.x
        
        if currentOffsetX > kCzyFullWidth {
            
            centerIndex = (centerIndex + 1) % self.imageNames.count
            
        }else{
            
            centerIndex = (centerIndex+self.imageNames.count-1) % self.imageNames.count
        }
                
        //设置中间图片内容
        centerImageView?.image = UIImage(named: "\(centerIndex+1)")
        
        //总是偏移到中间图片
        scrollView.contentOffset = CGPoint.init(x: kCzyFullWidth, y: 0)
        
        //设置pageControl
        pageControl?.currentPage = centerIndex;
        
        //此时 滚动的时候会出现白边左边 是因为没有设置左右两张图片内容
        leftIndex = (centerIndex + self.imageNames.count - 1) % self.imageNames.count
        rightIndex = (centerIndex + 1) % self.imageNames.count
                
        leftImageView?.image = UIImage.init(named: "\(leftIndex)")
        rightImageView?.image = UIImage.init(named: "\(rightIndex)")
    }
}

