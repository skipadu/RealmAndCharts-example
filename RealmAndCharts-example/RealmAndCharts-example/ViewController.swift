//
//  ViewController.swift
//  RealmAndCharts-example
//
//  Created by Sami Korpela on 8.10.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {
  @IBOutlet weak var tfValue: UITextField!
  @IBOutlet weak var barView: BarChartView!
  
  weak var axisFormatDelegate: IAxisValueFormatter?
  
  @IBAction func btnAddTapped(_ sender: AnyObject) {
    if let value = tfValue.text , value != "" {
      let visitorCount = VisitorCount()
      visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
      visitorCount.save()
      tfValue.text = ""
    }
    updateChartWithData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    axisFormatDelegate = self
    
    updateChartWithData()
  }
  
  func updateChartWithData() {
    var dataEntries: [BarChartDataEntry] = []
    
    let visitorCounts = getVisitorCountsFromDatabase()
    
    for i in 0..<visitorCounts.count {
      let timeIntervalForDate: TimeInterval = visitorCounts[i].date.timeIntervalSince1970
      let dataEntry = BarChartDataEntry(x: Double(timeIntervalForDate), y: Double(visitorCounts[i].count))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
    let chartData = BarChartData(dataSet: chartDataSet)
    barView.data = chartData
    
    let xaxis = barView.xAxis
    xaxis.valueFormatter = axisFormatDelegate
  }
  
  func getVisitorCountsFromDatabase() -> Results<VisitorCount> {
    do {
      let realm = try Realm()
      return realm.objects(VisitorCount.self)
    } catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

// MARK: axisFormatDelegate
extension ViewController: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm.ss"
    return dateFormatter.string(from: Date(timeIntervalSince1970: value))
  }
  
}
