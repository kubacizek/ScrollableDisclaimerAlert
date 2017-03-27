//
//  ViewController.swift
//  ScrollableDisclaimerAlert
//
//  Created by Kuba on 10/03/2017.
//  Copyright © 2017 Jakub Cizek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DisclaimerViewDelegate {

    var disclaimer = DisclaimerView.initView()
    var multiple = MultipleDisclaimerView()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var killSwitch: UISwitch!
    
    var disclaimers: [DisclaimerView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disclaimers = [
            DisclaimerView.initWith(title: "Disclaimer", filePath: "test", fileExtension: "txt", delegate: self),
            DisclaimerView.initWith(title: "Title 2", content: "Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic.", delegate: self),
            DisclaimerView.initWith(title: "Test", filePath: "test", fileExtension: "txt", delegate: self),
            DisclaimerView.initWith(title: "Another Disclaimer", filePath: "test", fileExtension: "txt", delegate: self)
        ]
    }
    
    // MARK: Buttons
    
    @IBAction func loadContentFromFile(_ sender: Any) {
        disclaimer = DisclaimerView.initWith(title: "Disclaimer", filePath: "test", fileExtension: "txt", delegate: self)
        self.view.addSubview(disclaimer)
    }
    
    @IBAction func loadContentAsString(_ sender: Any) {
        disclaimer = DisclaimerView.initWith(title: "Škoda", content: "Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. ", delegate: self)
        self.view.addSubview(disclaimer)
    }
    
    @IBAction func loadMutidisclaimer(_ sender: Any) {
        multiple = MultipleDisclaimerView.initWithDisclaimers(disclaimers: disclaimers)
        self.view.addSubview(multiple)
    }
    
    // MARK: DisclaimerViewDelegate
    
    func acceptDisclaimer(index: Int) {
        print("acceptDisclaimer index: \(index)")
        
        if index == -1 {
            disclaimer.removeFromSuperview()
            statusLabel.text = "ACCEPTED"
        }
        
        if index == disclaimers.count - 1 {
            multiple.removeFromSuperview()
            statusLabel.text = "ACCEPTED"
        }
    }
    
    func cancelDisclaimer(index: Int) {
        print("cancelDisclaimer index: \(index)")
        disclaimer.removeFromSuperview()
        
        if index == 0 {
            multiple.removeFromSuperview()
            statusLabel.text = "CANCELED"
            if killSwitch.isOn { exit(0) }
        }
        
        if index == -1 {
            if killSwitch.isOn { exit(0) } else { disclaimer.removeFromSuperview(); statusLabel.text = "CANCELED" }
        }
    }
}
