//
//  LineChartTableViewCell.swift
//  ChartDemo
//
//  Created by Xanthus Software Solutions on 21/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import UIKit
import Charts

class LineChartTableViewCell: UITableViewCell {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var horizontalBarChartView: HorizontalBarChartView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.layer.cornerRadius = 7.0
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowRadius = 2.0
        self.contentView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
