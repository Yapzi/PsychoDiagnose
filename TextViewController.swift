//
//  TextViewController.swift
//  PsychoDiagnose
//
//  Created by Yapzi on 16/7/7.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var TextView: UITextView! {
        didSet {
            TextView.text = text
        }
    }
    var text: String = "" {
        didSet {
            TextView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if presentingViewController != nil {
                return TextView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
}
