//
//  ViewController.swift
//  GenericWebViewJourneyExample
//
//  Created by Ravi Yaganti on 05/03/22.
//

import UIKit
import GenericWebViewJourney

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            let url = URL(string: "https://www.raywenderlich.com/home")
            let genericWebView = GenericWebViewViewController(webAppURL: url)
            self.navigationController?.pushViewController(genericWebView, animated: true)
        }
    }
}

