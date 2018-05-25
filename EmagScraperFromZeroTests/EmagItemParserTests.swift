//
//  EmagItemParserTests.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest
@testable import EmagScraperFromZero

class EmagItemParserTests: XCTestCase {
    
    private var emagItemParser: EmagItemParser?
    private var forSearch: HtmlReaderMock?
    private var forDetails: HtmlReaderMock?
    
    override func setUp() {
        super.setUp()
        
        emagItemParser = EmagItemParser()
        forSearch = HtmlReaderMock()
        forDetails = HtmlReaderMock(true)
    }
    
    override func tearDown() {
        super.tearDown()
        
        emagItemParser = nil
        forSearch = nil
        forDetails = nil
    }
    
    func testParse_forWith36ItemsInSearch() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Parsing"))
        
        emagItemParser = EmagItemParser(forSearch!)
        
        let url = URL(string: "\(Constants.URLConst.EmagURL)search/apple")
        emagItemParser?.parse(url: url!, completion: { (items: [PreviewItem]) in
            XCTAssertEqual(items.count, 36)
            
            expectation.fulfill()
        })
        
        //Wait for the expectation
        self.waitForExpectations(timeout: Constants.Expectation.DefaultTimeOut) { error in
            if let error = error {
                XCTFail("\(Constants.Expectation.WaitForExpectations) \(error)")
            }
        }
    }
    
    func testParse_for0Search() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Parsing", false))
        expectation.isInverted = true
        
        forSearch!.withEmtyValue = true
        emagItemParser = EmagItemParser(forSearch!)
        
        let url = URL(string: "\(Constants.URLConst.EmagURL)search/jkawdkwbadbkj")
        emagItemParser?.parse(url: url!, completion: { (items: [PreviewItem]) in
            XCTAssertEqual(items.count, 0)
            
            expectation.fulfill()
        })
        
        //Wait for the expectation
        self.waitForExpectations(timeout: Constants.Expectation.DefaultTimeOut) { error in
            if let error = error {
                XCTFail("\(Constants.Expectation.WaitForExpectations) \(error)")
            }
        }
    }
}
