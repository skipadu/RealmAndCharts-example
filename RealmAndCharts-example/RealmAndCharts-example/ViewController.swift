//
//  ViewController.swift
//  RealmAndCharts-example
//
//  Created by Sami Korpela on 8.10.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
  @IBOutlet weak var tfValue: UITextField!
  @IBOutlet weak var barView: BarChartView!
  
  @IBAction func btnAddTapped(_ sender: AnyObject) {
    if let value = tfValue.text , value != "" {
      let visitorCount = VisitorCount()
      visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
      visitorCount.save()
      tfValue.text = ""
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

