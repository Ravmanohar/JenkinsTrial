//
//  DashboardVC.swift
//  Dashboard
//
//  Created by Xanthus Software Solutions on 31/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import UIKit
import Charts

class DashboardVC: UIViewController {

    @IBOutlet weak var graphTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var row = 0
    let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
    "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
    "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
    "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
    "Party Y", "Party Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    @IBAction func sideMenuButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "DashboardToSideMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DashBoardToChartScreen"{
            if let vc = segue.destination as? ChartScreenViewController{
                vc.row = self.row
            }
        }
    }
    
    func setDataCountForLineChart(_ count: Int, range: UInt32, chartView: LineChartView) {
        
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet \(chartView.tag)")
        set1.drawIconsEnabled = false
        
        //        set1.lineDashLengths = [5, 2.5]
        //        set1.highlightLineDashLengths = [5, 2.5]
        //        set1.setColor(.black)
        //        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
    }
    
    func setDataCountForBarChart(_ count: Int, range: UInt32, chartView: BarChartView) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            chartView.data = data
        }
        chartView.animate(yAxisDuration: 1.0)
        //        chartView.setNeedsDisplay()
    }
    
    func setDataCountForHorizontalBarChart(_ count: Int, range: UInt32, chartView: HorizontalBarChartView) {
        
        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        
        chartView.fitBars = true
        
        let barWidth = 9.0
        let spaceForBar = 10.0
        
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            return BarChartDataEntry(x: Double(i)*spaceForBar, y: val)
        }
        
        let set1 = BarChartDataSet(entries: yVals, label: "DataSet")
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        
        chartView.data = data
        chartView.animate(yAxisDuration: 1.0)
    }
    
    func setDataCountForPieChart(_ count: Int, range: UInt32, chartView: PieChartView) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.white)
        
        chartView.data = data
        chartView.highlightValues(nil)
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    func setDataCountForSinusChart(_ count: Int, chartView: BarChartView) {
        let entries = (0..<count).map {
            BarChartDataEntry(x: Double($0), y: sin(.pi * Double($0%128) / 64))
        }
        
        let set = BarChartDataSet(entries: entries, label: "Sinus Function")
        set.setColor(UIColor(red: 240/255, green: 120/255, blue: 123/255, alpha: 1))
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setDrawValues(false)
        data.barWidth = 0.8
        
        chartView.data = data
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }

}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = ""
        switch indexPath.row {
        case 0:
            identifier = "LineChartCell"
            break
        case 1:
            identifier = "BarChartCell"
            break
        case 2:
            identifier = "HorizontalBarChartCell"
            break
        case 3,4:
            identifier = "PieChartCell"
            break
        case 5:
            identifier = "SinusChartCell"
            break
        default:
            identifier = "LineChartCell"
            break
        }
        
        let cell = graphTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LineChartTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.graphTableView.frame.height/2 - 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = graphTableView.cellForRow(at: indexPath) as! LineChartTableViewCell
        self.row = cell.contentView.tag
        performSegue(withIdentifier: "DashBoardToChartScreen", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! LineChartTableViewCell
        cell.contentView.tag = indexPath.row
        switch indexPath.row {
        case 0:
            cell.lineChartView.backgroundColor = .darkGray
            cell.lineChartView.rightAxis.enabled = false
            self.setDataCountForLineChart(45, range: UInt32(100), chartView: cell.lineChartView)
            break
        case 1:
            cell.barChartView.backgroundColor = .darkGray
            cell.barChartView.rightAxis.enabled = false
            self.setDataCountForBarChart(11, range: UInt32(50), chartView: cell.barChartView)
            break
        case 2:
            cell.horizontalBarChartView.backgroundColor = .darkGray
            cell.horizontalBarChartView.rightAxis.enabled = false
            self.setDataCountForHorizontalBarChart(12, range: UInt32(50), chartView: cell.horizontalBarChartView)
            break
        case 3:
            cell.pieChartView.maxAngle = 360 // Half chart
            cell.pieChartView.rotationAngle = 360 // Rotate to make the half on the upper
            cell.pieChartView.backgroundColor = .darkGray
            self.setDataCountForPieChart(4, range: UInt32(50), chartView: cell.pieChartView)
            break
        case 4:
            cell.pieChartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0)
            cell.pieChartView.holeRadiusPercent = 0.25
            cell.pieChartView.rotationEnabled = false
            cell.pieChartView.highlightPerTapEnabled = true
            
            cell.pieChartView.holeColor = .darkGray
            cell.pieChartView.maxAngle = 180 // Half chart
            cell.pieChartView.rotationAngle = 180 // Rotate to make the half on the upper side
            cell.pieChartView.backgroundColor = .darkGray
            self.setDataCountForPieChart(4, range: UInt32(50), chartView: cell.pieChartView)
            break
        case 5:
            cell.barChartView.backgroundColor = .darkGray
            cell.barChartView.rightAxis.enabled = false
            self.setDataCountForSinusChart(153, chartView: cell.barChartView)

            break
        default:
            cell.lineChartView.backgroundColor = .white
            cell.lineChartView.rightAxis.enabled = false
            self.setDataCountForLineChart(45, range: UInt32(100), chartView: cell.lineChartView)
            break
        }
        
    }
    
}
