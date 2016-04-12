//
//  ViewController.swift
//  ColorPicker
//
//  Created by 姚鸿 on 16/4/10.
//  Copyright © 2016年 TonyShmily. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var redPicker: NSSlider!
    @IBOutlet weak var greenPicker: NSSlider!
    @IBOutlet weak var bluePicker: NSSlider!
    @IBOutlet weak var alphaPicker: NSSlider!
    
    @IBOutlet weak var lbRed: NSTextField!
    @IBOutlet weak var lbGreen: NSTextField!
    @IBOutlet weak var lbBlue: NSTextField!
    @IBOutlet weak var lbAlpha: NSTextField!
    
    @IBOutlet weak var tbAndroid: NSTextField!
    @IBOutlet weak var tbSwift: NSTextField!
    @IBOutlet weak var tbSwiftNS: NSTextField!
    @IBOutlet weak var tbRGB: NSTextField!
    @IBOutlet weak var tbRGB16: NSTextField!
    
    @IBOutlet weak var showColor: NSTextFieldCell!
    
    @IBOutlet weak var lbStatus: NSTextField!
    var pasteBoard = NSPasteboard.generalPasteboard()
    
    @IBAction func rChange(sender: AnyObject) {
        lbRed.stringValue = String(redPicker.intValue)
        lbRed.textColor = NSColor(calibratedRed: CGFloat(redPicker.intValue)/255, green: 0, blue: 0, alpha: 1)

        ShowColor()
        getColorInfo()
    }
    
    @IBAction func gChange(sender: AnyObject) {
        lbGreen.stringValue = String(greenPicker.intValue)
        lbGreen.textColor = NSColor(calibratedRed: 0, green: CGFloat(greenPicker.intValue)/255, blue: 0, alpha: 1)
        ShowColor()
        getColorInfo()
    }
    
    @IBAction func bChange(sender: AnyObject) {
        lbBlue.stringValue = String(bluePicker.intValue)
        lbBlue.textColor = NSColor(calibratedRed: 0, green: 0, blue: CGFloat(bluePicker.intValue)/255, alpha: 1)
        ShowColor()
        getColorInfo()
    }
    
    @IBAction func aChange(sender: AnyObject) {
        lbAlpha.stringValue = String(alphaPicker.intValue)
        ShowColor()
        getColorInfo()
    }
    
    func initStatus(){
        lbRed.stringValue = String(redPicker.intValue)
        lbRed.textColor = NSColor(calibratedRed: CGFloat(redPicker.intValue)/255, green: 0, blue: 0, alpha: 1)

        lbGreen.stringValue = String(greenPicker.intValue)
        lbGreen.textColor = NSColor(calibratedRed: 0, green: CGFloat(greenPicker.intValue)/255, blue: 0, alpha: 1)
        
        lbBlue.stringValue = String(bluePicker.intValue)
        lbBlue.textColor = NSColor(calibratedRed: 0, green: 0, blue: CGFloat(bluePicker.intValue)/255, alpha: 1)
        lbAlpha.stringValue = String(alphaPicker.intValue)
    }
    
    
    func ShowColor(){
        showColor.backgroundColor = NSColor(calibratedRed: CGFloat(redPicker.intValue)/255, green: CGFloat(greenPicker.intValue)/255, blue: CGFloat(bluePicker.intValue)/255, alpha: CGFloat(alphaPicker.intValue)/100)
    }
    
    
    func getColorInfo(){
        let r16 = String().stringByAppendingFormat("%02x",Int(lbRed.stringValue)!)
        let g16 = String().stringByAppendingFormat("%02x",Int(lbGreen.stringValue)!)
        let b16 = String().stringByAppendingFormat("%02x",Int(lbBlue.stringValue)!)
        let a16 = String().stringByAppendingFormat("%02x",Int(Float(lbAlpha.stringValue)! / 100 * 255))
        let t16 = "#\(a16)\(r16)\(g16)\(b16)".uppercaseString
        
        tbRGB.stringValue = "\(lbRed.stringValue),\(lbGreen.stringValue),\(lbBlue.stringValue)"
        tbRGB16.stringValue = t16
        
        tbAndroid.stringValue = " Color.parseColor(\(t16))"
        
        tbSwift.stringValue = "UIColor(red: \(lbRed.stringValue)/255, green: \(lbGreen.stringValue)/255, blue: \(lbBlue.stringValue)/255, alpha: \(lbAlpha.stringValue)/100)"
        tbSwiftNS.stringValue = "NSColor(calibratedRed: \(lbRed.stringValue)/255, green: \(lbGreen.stringValue)/255, blue: \(lbBlue.stringValue)/255, alpha: \(lbAlpha.stringValue)/100)"
    }
        
    @IBAction func btnRGBCopy(sender: AnyObject) {
        pasteBoard.clearContents()
        copyInfo([tbRGB.stringValue], copyType: "RGB", tbType: tbRGB)
    }
    
    @IBAction func btnRGB16Copy(sender: AnyObject) {
        pasteBoard.clearContents()
        copyInfo([tbRGB16.stringValue], copyType: "RGB(16进制)", tbType: tbRGB16)
    }
    
    @IBAction func btnAndroidCopy(sender: AnyObject) {
        pasteBoard.clearContents()
        copyInfo([tbAndroid.stringValue], copyType: "Android取色值", tbType: tbAndroid)
    }
    
    @IBAction func btnSwiftCopy(sender: AnyObject) {
        pasteBoard.clearContents()
        copyInfo([tbSwift.stringValue], copyType: "Swift取色值1", tbType: tbSwift)
    }
    
    @IBAction func btnSwiftNSCopy(sender: AnyObject) {
        pasteBoard.clearContents()
        copyInfo([tbSwiftNS.stringValue], copyType: "Swift取色值2", tbType: tbSwiftNS)
    }
    
    func copyInfo(str: [NSPasteboardWriting], copyType: String, tbType: NSTextField){
        pasteBoard.writeObjects(str)
        lbStatus.textColor = NSColor.blackColor()
        lbStatus.stringValue = "\(copyType) 已复制！"
        tbRGB.backgroundColor = NSColor.whiteColor()
        tbRGB16.backgroundColor = NSColor.whiteColor()
        tbAndroid.backgroundColor = NSColor.whiteColor()
        tbSwift.backgroundColor = NSColor.whiteColor()
        tbSwiftNS.backgroundColor = NSColor.whiteColor()
        tbType.backgroundColor = NSColor(calibratedRed: 125/255, green: 217/255, blue: 109/255, alpha: 100/100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStatus()
        ShowColor()
        getColorInfo()
        // Do any additional setup after loading the view.
    }

    @IBAction func showColor(sender: AnyObject) {
        let str = tbRGB.stringValue
        let strList = str.componentsSeparatedByString(",")
       
        if (getRGBInfo(strList).success)
        {
            showColorSuccess(getRGBInfo(strList).r, g: getRGBInfo(strList).g, b: getRGBInfo(strList).b)}
        else
        {
            self.showColorFailed()
        }
    }
    
    func showColorSuccess(r:Int32, g:Int32, b:Int32){
        redPicker.intValue = r
        greenPicker.intValue = g
        bluePicker.intValue = b
        alphaPicker.intValue = 100
        
        initStatus()
        ShowColor()
        getColorInfo()
        
        lbStatus.stringValue = "颜色已按填写内容重现!"
        lbStatus.textColor = NSColor.blueColor()
    }
    
    func showColorFailed()
    {
        let alert = NSAlert()
        alert.messageText = "错误"
        alert.informativeText = "请检查RGB值是否按要求正确填写!"
        alert.addButtonWithTitle("确定")
        alert.alertStyle = NSAlertStyle.WarningAlertStyle
        let window = NSApplication.sharedApplication().mainWindow
        alert.beginSheetModalForWindow(window!, completionHandler: nil)
        lbStatus.stringValue = "错误：请检查RGB值是否按要求正确填写!"
        lbStatus.textColor = NSColor.redColor()
    }
    
    func getRGBInfo(strList: [String]) -> (success: Bool ,r: Int32, g: Int32, b: Int32) {
        if NSNumberFormatter().numberFromString(strList[0])?.integerValue != nil
            && NSNumberFormatter().numberFromString(strList[1])?.integerValue != nil
            && NSNumberFormatter().numberFromString(strList[2])?.integerValue != nil{
            return(true, Int32(strList[0])!, Int32(strList[1])!, Int32(strList[2])!)
        }
        else{
            //throw getIntRGB.convertErr
            return (false, -1, -1, -1)
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

