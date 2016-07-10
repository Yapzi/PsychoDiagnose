//
//  ViewController.swift
//  PsychoDiagnose
//
//  Created by Yapzi on 16/7/7.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

class PsychologyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showHVC(sender: UIButton) {
        performSegueWithIdentifier("showHVC", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
        if let navigationController = destination as? UINavigationController {
            destination = navigationController.visibleViewController!
        }
        if let happinessViewController = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "showHappy":
                    happinessViewController.happiness = 100
                case "showSad":
                    happinessViewController.happiness = 0
                case "showMeh":
                    happinessViewController.happiness = 50
                case "showHVC":
                    happinessViewController.happiness = 25
                default:
                    break
                }
            }
        }
    }
}

