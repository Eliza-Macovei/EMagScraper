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
    
    private var htmlReader: HtmlReader?
    private var mockURLSession: MockURLSession?
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        htmlReader = HtmlReader(session: mockURLSession!)
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockURLSession = nil
        htmlReader = nil
    }
    
    func testGetHtml_withValidSearch() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Html with value"))
        
        if let url = URL(string: "\(Constants.URLConst.EmagURL)search/apple") {
            htmlReader?.getHtml(url: url, completion: {_ in
                XCTAssertEqual((self.htmlReader?.session as? MockURLSession)?.dataTaskLastURL, url)
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
            htmlReader?.getHtml(url: url, completion: {_ in
                XCTAssertNotEqual((self.htmlReader?.session as? MockURLSession)?.dataTaskLastURL?.absoluteString, url.absoluteString)
                
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
