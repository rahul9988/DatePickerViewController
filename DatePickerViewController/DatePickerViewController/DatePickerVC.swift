//
//  DatePickerVC.swift
//  FieldTracking
//
//  Created by Rahul Dhiman on 28/02/19.
//  Copyright © 2019 Rahul Dhiman. All rights reserved.
//

import UIKit
extension Date{
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
struct PickerConstants{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let pickerWidth:CGFloat = 300
    static let pickerHeight:CGFloat = 300
}
protocol DatePickerControllerDelegate {
    func didPickDate(_ date:Date?)
    func didCancelPickingDate()
}

class DatePickerVC: UIViewController {
    typealias DateCompletion = (_ selectedDate : Date?, _ Cancel:Bool) -> ()
    var delegate:DatePickerControllerDelegate?
    var completion: DateCompletion?
    var pickerTitle:String?
    var pickTitle:String?
    var cancelTitle:String?
    var backgroundView:UIView?
    var lblTitle:UILabel?
    var pickerContainerView = UIView()
    var rootVC:UIViewController?
    var datePicker:UIDatePicker?
    var titleLabel:UILabel?
    var pickButton:UIButton?
    var cancelButton:UIButton?
    
    public class func pickDate(title:String?,pickTitle:String?,cancelTitle:String?,
                               completion: DateCompletion? = nil,
                               delegate:DatePickerControllerDelegate? = nil){
        UIApplication.shared.keyWindow?.rootViewController?.addChild(DatePickerVC(title: title, pickTitle: pickTitle, cancelTitle: cancelTitle,completion:completion,delegate:delegate))
    }
    
    convenience init(title:String?,pickTitle:String?,cancelTitle:String?,
                     completion: DateCompletion? = nil,
                     delegate:DatePickerControllerDelegate? = nil) {
        self.init()
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.pickerTitle = title
        self.pickTitle = pickTitle
        self.cancelTitle = cancelTitle
        self.delegate = delegate
        self.completion = completion
        setupPickerView()
        DispatchQueue.global(qos: .userInitiated).async {
            // ... do Stufff here
            DispatchQueue.main.async {
                // ... get back to main
            }
        }
        return
    }
    func showInVC(_ vc:UIViewController){
        rootVC = vc
        rootVC?.addChild(self)
        rootVC?.view.addSubview(self.view)
        self.didMove(toParent: self)
    }
    private func setupPickerView(){
        self.view.backgroundColor = #colorLiteral(red: 0.2708397508, green: 0.2708397508, blue: 0.2708397508, alpha: 0.6224315068)
        addBlurrEffectView()
    }
    
    private func addBlurrEffectView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        pickerContainerView.layer.cornerRadius = 15
        pickerContainerView.clipsToBounds = true

        pickerContainerView.frame = CGRect(x: 0, y: 0, width:   PickerConstants.pickerWidth, height: PickerConstants.pickerHeight)
        pickerContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
        blurView.frame = pickerContainerView.frame
        pickerContainerView.center = CGPoint(x: PickerConstants.screenWidth/2, y: PickerConstants.screenHeight/2 - self.view.safeAreaInsets.top/2)

        pickerContainerView.addSubview(blurView)
        pickerContainerView.backgroundColor = .white

        self.addTitleLabel()
        self.addDatePicker()
        self.addHorizontalSeperator()
        self.addVerticalSeperator()
        self.addButtons()
        view.addSubview(pickerContainerView)
    }
    
    private func addTitleLabel(){
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: PickerConstants.pickerWidth, height: 50))
        titleLabel?.font = UIFont.boldSystemFont(ofSize: (titleLabel?.font.pointSize)!)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.text = pickerTitle
        pickerContainerView.addSubview(titleLabel!)
    }
    
    private func addDatePicker(){
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 50, width: PickerConstants.pickerWidth, height: 200))
        datePicker?.datePickerMode = .date
        pickerContainerView.addSubview(datePicker!)
    }
    
    @objc func actionCancel(){
        delegate?.didCancelPickingDate()
        completion?(nil,true)
        close()
    }
    
    @objc func actionSelect(){
        delegate?.didPickDate(datePicker?.date)
        completion?(datePicker?.date,true)
        close()
    }
    
    private func close(){
//        self.view.removeFromSuperview()
//        self.removeFromParent()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addButtons(){
        cancelButton = UIButton(frame: CGRect(x: 0, y: 251, width: (PickerConstants.pickerWidth-1)/2, height: 49))
        cancelButton?.addTarget(self, action: #selector(actionCancel), for: UIControl.Event.touchUpInside)
        cancelButton?.setTitle(cancelTitle, for: UIControl.State.normal)
        cancelButton?.setTitleColor(view.tintColor, for: UIControl.State.normal)
        pickerContainerView.addSubview(cancelButton!)
        
        pickButton = UIButton(frame: CGRect(x: (PickerConstants.pickerWidth+1)/2, y: 251, width: (PickerConstants.pickerWidth-1)/2, height: 49))
        pickButton?.addTarget(self, action: #selector(actionSelect), for: UIControl.Event.touchUpInside)
        pickButton?.setTitle(pickTitle, for: UIControl.State.normal)
        pickButton?.setTitleColor(view.tintColor, for: UIControl.State.normal)
        pickerContainerView.addSubview(pickButton!)
    }
    
    private func addHorizontalSeperator(){
        let seperator = UIView(frame: CGRect(x: 0, y: 250, width: PickerConstants.pickerWidth, height: 0.5))
        seperator.backgroundColor = UIColor.gray
        pickerContainerView.addSubview(seperator)
    }
    
    private func addVerticalSeperator(){
        let seperator = UIView(frame: CGRect(x: (PickerConstants.pickerWidth-1)/2, y: 250, width: 0.5, height: 49))
        seperator.backgroundColor = UIColor.gray
        pickerContainerView.addSubview(seperator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
