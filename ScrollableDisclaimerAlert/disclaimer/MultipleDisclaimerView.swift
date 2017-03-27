//
//  MultipleDisclaimerView.swift
//  ScrollableDisclaimerViewAlert
//
//  Created by Kuba on 22/03/2017.
//  Copyright © 2017 Jakub Cizek. All rights reserved.
//

import UIKit

class MultipleDisclaimerView: UIView {
    
    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
    var disclaimers: [MultipleDisclaimerView] = []
    
    let kAnimationDuration = 0.3
    
    // MARK: Implementation
    
    class func initWithDisclaimers(disclaimers: [DisclaimerView]) -> MultipleDisclaimerView {
        let contentView = MultipleDisclaimerView()
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: disclaimers[0].bounds.width, height: disclaimers[0].bounds.height))
        contentView.addSubview(scrollView)
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        contentView.frame.size = scrollView.frame.size
        
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 39, height: 37))
        pageControl.isUserInteractionEnabled = false
        
        pageControl.numberOfPages = disclaimers.count
        pageControl.currentPage = 0
        
        for index in 0..<disclaimers.count {

            disclaimers[index].pageControl = pageControl
            disclaimers[index].scrollView = scrollView
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let subView = disclaimers[index]
            subView.frame = frame
            scrollView.addSubview(subView)
        }
        
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(disclaimers.count), height: scrollView.frame.size.height)
        
        contentView.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activate([horizontalConstraint, bottomConstraint])
        
        return contentView
    }
    
    override func layoutSubviews() {
        layer.opacity = 0
        UIView.animate(withDuration: kAnimationDuration) {
            self.layer.opacity = 1
        }
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: kAnimationDuration, animations: {
            self.layer.opacity = 0
        }) { processing in
            if !processing { super.removeFromSuperview() }
        }
    }
}
