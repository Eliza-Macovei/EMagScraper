//
//  HtmlReaderTests.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest
@testable import EmagScraperFromZero

class HtmlReaderTests: XCTestCase {
    
    private var htmlReader: HtmlReaderProtocol?
    
    override func setUp() {
        super.setUp()
        
        htmlReader = HtmlReader()
    }
    
    override func tearDown() {
        super.tearDown()
        
        htmlReader = nil
    }
    
    func testGetHtml_withValidSearch() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Html with value"))
        
        if let url = URL(string: "\(Constants.URLConst.EmagURL)search/apple") {
            htmlReader?.getHtml(url: url, completion: {
                XCTAssertNotNil($0)
                
                expectation.fulfill()
            })
        }
        
        //Wait for the expectation
        self.waitForExpectations(timeout: Constants.Expectation.DefaultTimeOut) { error in
            if let error = error {
                XCTFail("\(Constants.Expectation.WaitForExpectations) \(error)")
            }
        }
    }
    
    func testGetHtml_withInvalidSearch() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Html with value"))
        expectation.isInverted = true
        
        if let url = URL(string: "test") {
            htmlReader?.getHtml(url: url, completion: {
                XCTAssertNil($0)
                
                expectation.fulfill()
            })
        }
        
        //Wait for the expectation
        self.waitForExpectations(timeout: Constants.Expectation.DefaultTimeOut) { error in
            if let error = error {
                XCTFail("\(Constants.Expectation.WaitForExpectations) \(error)")
            }
        }
    }
}
