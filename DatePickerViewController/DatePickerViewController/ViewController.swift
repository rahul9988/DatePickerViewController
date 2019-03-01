//
//  ViewController.swift
//  DatePickerViewController
//
//  Created by Rahul Dhiman on 01/03/19.
//  Copyright © 2019 Rahul Dhiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func pickDateButtonAction(_ sender: UIButton) {
        let datePickerVC = DatePickerVC(title: "Select a Date", pickTitle: "Select", cancelTitle: "Cancel", completion: { (date, canceled) in
            if let d = date {
                sender.setTitle(d.string(), for: .normal)
            }
        }, delegate:self)
        self.present(datePickerVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}
extension ViewController:DatePickerControllerDelegate {
    func didPickDate(_ date: Date?) {
        print(date?.string())
    }
    
    func didCancelPickingDate() {
        print("Canceled")
    }
    
    
}

