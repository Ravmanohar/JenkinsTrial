//
//  DashboardTests.swift
//  DashboardTests
//
//  Created by Xanthus Software Solutions on 29/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import XCTest
@testable import Dashboard

class DashboardTests: XCTestCase {

    var sut: DashboardVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "DashboardVC") as? DashboardVC
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//            var identifier = ""
////
////            for i in 0...5{
////                if i == 0{
////                    identifier = "LineChartCell"
////                }else if i == 1{
////                    identifier = "BarChartCell"
////                }else if i == 2{
////                    identifier = "HorizontalBarChartCell"
////                }else if i == 3{
////                    identifier = "PieChartCell"
////                }else if i == 4{
////                    identifier = "SinusChartCell"
////                }else{
////                    identifier = "LineChartCell"
////                }
////                print(identifier)
////            }
//            for i in 0...5{
//                switch i {
//                case 0:
//                    identifier = "LineChartCell"
//                    break
//                case 1:
//                    identifier = "BarChartCell"
//                    break
//                case 2:
//                    identifier = "HorizontalBarChartCell"
//                    break
//                case 3,4:
//                    identifier = "PieChartCell"
//                    break
//                case 5:
//                    identifier = "SinusChartCell"
//                    break
//                default:
//                    identifier = "LineChartCell"
//                    break
//                }
//                print(identifier)
//            }
//
//        }
//    }
    
    func testHasATableView() {
        XCTAssertNotNil(sut.graphTableView)
        self.measure {
            sut.graphTableView.reloadData()
        }
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.graphTableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.graphTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = sut.tableView(sut.graphTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? LineChartTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "LineChartCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

}
