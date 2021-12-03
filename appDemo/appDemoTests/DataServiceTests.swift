//
//  DataServiceTests.swift
//  appDemoTests
//
//  Created by Damien on 03/12/2021.
//

import XCTest
@testable import appDemo
class DataServiceTests: XCTestCase {

    let data = MockData.getFakeData()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSave() throws {
        let dataService = DataService()
        dataService.saveData(data, completion: { _ in
            
        })
        XCTAssertEqual(dataService.getAllKeys().count, 10)
        XCTAssertEqual(dataService.getAllChoords().count, 100)

    }

    func testGetKey() throws {
        let dataService = DataService()
        dataService.saveData(data, completion: { _ in

        })
        for key in dataService.getAllKeys() {

            let choords = dataService.getChoordsForKey(key: key)
            XCTAssertNotNil(choords)
            XCTAssertEqual(choords.count, 10)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
