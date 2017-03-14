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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var killSwitch: UISwitch!
    
    // MARK: Buttons
    
    @IBAction func loadContentFromFile(_ sender: Any) {
        disclaimer = DisclaimerView.initWith(title: "Disclaimer", filePath: "test", fileExtension: "txt", delegate: self)
        self.view.addSubview(disclaimer)
    }
    
    @IBAction func loadContentAsString(_ sender: Any) {
        disclaimer = DisclaimerView.initWith(title: "Škoda", content: "Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. Škoda Auto (Czech pronunciation: [ˈʃkoda]), more commonly known as Škoda, is a Czech automobile manufacturer founded in 1895 as Laurin & Klement. It is headquartered in Mladá Boleslav, Czech Republic. ", delegate: self)
        self.view.addSubview(disclaimer)
    }
    
    // MARK: DisclaimerViewDelegate
    
    func acceptDisclaimer() {
        print("acceptDisclaimer")
        disclaimer.removeFromSuperview()
        statusLabel.text = "ACCEPTED"
    }
    
    func cancelDisclaimer() {
        print("cancelDisclaimer")
        disclaimer.removeFromSuperview()
        if killSwitch.isOn { exit(0) } else { disclaimer.removeFromSuperview(); statusLabel.text = "CANCELED" }
    }
}
