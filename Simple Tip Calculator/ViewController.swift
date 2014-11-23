//
//  ViewController.swift
//  Simple Tip Calculator
//
//  Created by Martin Lok on 08/10/14.
//  Copyright (c) 2014 Martin Lok. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
    
    @IBOutlet weak var txtMealCost: UITextField!
    @IBOutlet weak var txtTip: UITextField!
    @IBOutlet weak var lblTipCalculated: UILabel!
    @IBOutlet weak var lblTipCalculator: UILabel!
    @IBOutlet weak var lblCalculate: UIButton!
    @IBOutlet weak var lblClear: UIButton!
    @IBOutlet weak var lblDollar: UIButton!
    @IBOutlet weak var lblEuro: UIButton!
    @IBOutlet weak var lblPound: UIButton!
    
    @IBOutlet weak var adBannerView: ADBannerView!
    
    var mealCost = ""
    var tipPercentage = ""
    var answer : Float = 0
    var answerFormat: NSString = ""
    var dollarsActive = false
    var euroActive = false
    var poundActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dollarsActive = true
        lblDollar.highlighted = false
        
        // iAd
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.hidden = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCalculate(sender: UIButton) {
        calculateTip()
        
        if txtMealCost.text == "" && txtTip.text == "" {
            lblTipCalculated.text = "Enter Numbers"
        }
        
        
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        txtMealCost.text = ""
        txtTip.text = ""
        
        lblTipCalculated.text = "Tip Total"
        funcRemoveKeyboard()
    }
    
    @IBAction func btnClear(sender: UIButton) {
        
        txtMealCost.text = ""
        txtTip.text = ""
        
        lblTipCalculated.text = "Tip Total"
        funcRemoveKeyboard()
        
    }
    
    func calculateTip () -> Bool {
        
        lblTipCalculated.text = "Tip Total: $\(funcAnswerFormat())"
        currencyWhenCalculate()
        funcRemoveKeyboard()
        
        return true
    }
    
    
    @IBAction func btnDollars(sender: UIButton) {
        
        dollarsActive = true
        euroActive = false
        poundActive = false
        lblDollar.highlighted = false
        lblEuro.highlighted = true
        lblPound.highlighted = true
        
        if lblTipCalculated.text != "Tip Total" && lblTipCalculated.text != "Enter numbers"{
            lblTipCalculated.text = funcCurrencyChanger("$")
        }
        funcRemoveKeyboard()
    }
    
    @IBAction func btnEuro(sender: UIButton) {
        
        euroActive = true
        dollarsActive = false
        poundActive = false
        lblDollar.highlighted = true
        lblEuro.highlighted = false
        lblPound.highlighted = true
        
        if lblTipCalculated.text != "Tip Total" && lblTipCalculated.text != "Enter numbers"{
            lblTipCalculated.text = funcCurrencyChanger("€")
        }
        funcRemoveKeyboard()

    }
    
    @IBAction func btnPound(sender: UIButton) {
        
        poundActive = true
        dollarsActive = false
        euroActive = false
        lblDollar.highlighted = true
        lblEuro.highlighted = true
        lblPound.highlighted = false
        
        if lblTipCalculated.text != "Tip Total" && lblTipCalculated.text != "Enter numbers" {
            lblTipCalculated.text = funcCurrencyChanger("")
        }
        
        funcRemoveKeyboard()

    }
    
    func funcAnswerFormat () -> NSString {
        mealCost = txtMealCost.text
        tipPercentage = txtTip.text
        
        var fMealCost = (mealCost as NSString).floatValue
        var fTipPercentage = (tipPercentage as NSString).floatValue
        
        answer = fMealCost * (fTipPercentage * 0.01)
        answerFormat = NSString(format: "%0.2f", answer)
        
        return answerFormat
    }
    
    func funcCurrencyChanger (currency: String) -> String {
        
        if lblTipCalculated != "Tip Total" {
            lblTipCalculated.text = "Tip Total: \(currency)\(answerFormat)"
        }
        
        var answerFinal = lblTipCalculated.text
        
        return answerFinal!
    }
    
    func funcRemoveKeyboard () {
        
        txtMealCost.resignFirstResponder()
        txtTip.resignFirstResponder()
    }
    
    func currencyWhenCalculate () {
        
        if dollarsActive == true {
            lblTipCalculated.text = funcCurrencyChanger("$")
        } else if euroActive == true {
            lblTipCalculated.text = funcCurrencyChanger("€")
        } else {
            lblTipCalculated.text = funcCurrencyChanger("")
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        funcRemoveKeyboard()
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        NSLog("bannerViewWillLoadAd")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
        self.adBannerView.hidden = false
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        NSLog("bannerViewActionShouldBegin")
        

        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("bannerView")
        self.adBannerView.hidden = true
    }

}
















