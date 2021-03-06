//
//  ChartViewController.swift
//  CCR
//
//  Created by Erica Millado on 3/14/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    let store = DataStore.sharedInstance

    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    var taskDataPoints: [String] = []
    var taskDataValues: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChartData()
        setChart(dataPoints: taskDataPoints, values: taskDataValues)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getChartData()
        setChart(dataPoints: taskDataPoints, values: taskDataValues)
    }
    
    func getChartData() {
        taskDataValues.removeAll()
        taskDataPoints.removeAll()
        
        for task in self.store.tasks {
            if task.ratingDouble != nil {
                if let unwrappedRatingDouble = task.ratingDouble {
                    taskDataPoints.append(task.description)
                    taskDataValues.append(unwrappedRatingDouble)
                }
            }
        }
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "There is no data available for the chart."
        //for the chart to display data, we need to create a barchartdataobject
        //1 - create an array of BarChartDataEntry objects
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            //2 - initialize an instance of BarChartDataEntry that takes in the value of each entry (y value) and the index (x value)
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        //3 - we use our data entries and create a BarChartData object
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Task Rating")
        //4 - we set this data set as our chart view's data
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        //5 - change the default color of the bar chart
//        chartDataSet.colors = [Constants.red]
//        chartDataSet.setColor(Constants.red)
        //6 - change the position of the x-axis labels
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0)
    }
    

}











