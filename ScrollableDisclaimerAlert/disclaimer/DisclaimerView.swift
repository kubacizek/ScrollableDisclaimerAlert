//
//  DisclaimerView.swift
//  ScrollableDisclaimerViewAlert
//
//  Created by Kuba on 09/03/2017.
//  Copyright © 2017 Jakub Cizek. All rights reserved.
//

import UIKit

protocol DisclaimerViewDelegate: class {
    func acceptDisclaimer(index: Int)
    func cancelDisclaimer(index: Int)
}

class DisclaimerView: UIView {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var title: UILabel!
    
    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
    
    let kAnimationDuration = 0.3
    
    // MARK: Delegate
    
    weak var delegate: DisclaimerViewDelegate?

    @IBAction func cancelAction(_ sender: Any) {
        delegate?.cancelDisclaimer(index: pageControl.currentPage)
        
        let count = pageControl.numberOfPages
        let currentPage = pageControl.currentPage
        
        if count > currentPage {
            var frame: CGRect = scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(currentPage - 1);
            frame.origin.y = 0;
            scrollView.scrollRectToVisible(frame, animated: true)
            pageControl.currentPage = currentPage-1
        }
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        delegate?.acceptDisclaimer(index: pageControl.currentPage)
        
        let count = pageControl.numberOfPages
        let currentPage = pageControl.currentPage
        
        if count - 1 > currentPage {
            var frame: CGRect = scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(currentPage + 1);
            frame.origin.y = 0;
            scrollView.scrollRectToVisible(frame, animated: true)
            pageControl.currentPage = currentPage+1
        }
    }
    
    // MARK: Implementation
    
    class func initView() -> DisclaimerView {
        
        let disclaimerView = UINib(nibName: "Disclaimer", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DisclaimerView
        return disclaimerView
    }
    
    class func initWith(title: String, filePath: String? = nil, fileExtension: String? = nil, content: String = "", cancelTitle: String = "Cancel", acceptTitle: String = "Confirm", frame: CGRect = UIScreen.main.bounds, delegate: DisclaimerViewDelegate) -> DisclaimerView {
        
        let disclaimerView = UINib(nibName: "Disclaimer", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DisclaimerView
        
        disclaimerView.title.text = title
        
        if content == "" {
            if let path = Bundle.main.path(forResource: filePath, ofType: fileExtension) {
                disclaimerView.content.text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
            }
        } else {
            disclaimerView.content.text = content
        }
        
        disclaimerView.acceptButton.setTitle(acceptTitle, for: .normal)
        disclaimerView.cancelButton.setTitle(cancelTitle, for: .normal)
        
        disclaimerView.delegate = delegate
        
        disclaimerView.frame = frame
        
        disclaimerView.cancelButton.borders(for: [.top, .right], color: .init(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1))
        disclaimerView.acceptButton.borders(for: [.top], color: .init(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1))
        
        disclaimerView.backgroundColor = .lightGray
        
        return disclaimerView
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

// MARK: - Extenstions

extension UIView {
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {
        
        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]
            
            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }
                
                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = color
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)
                    
                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"
                    
                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }
}
