//
//  EmagScraperTests.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest
@testable import EmagScraperFromZero

class EmagScraperTests: XCTestCase {
    
    private var emagScraper: EmagScraper?
    private var previewItem: PreviewItem?
    private var forSearch: HtmlReaderMock?
    private var forDetails: HtmlReaderMock?
    
    override func setUp() {
        super.setUp()
        
        emagScraper = EmagScraper()
        previewItem = PreviewItem("origin", "title", nil, 2, "Lei", "details")        
        forSearch = HtmlReaderMock()
        forDetails = HtmlReaderMock(true)
    }
    
    override func tearDown() {
        super.tearDown()
        
        emagScraper = nil
        previewItem = nil
        forSearch = nil
        forDetails = nil
    }
    
    func testSearch_withAppleSearch() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Searching"))
        
        emagScraper = EmagScraper(forSearch!)
        emagScraper?.search("apple", callbackSearch: { (items: [PreviewItem]) in
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

    func testGetDetails_withoutDetailsItem() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Get details"))
        
        emagScraper = EmagScraper(forDetails!)
        
        emagScraper?.getDetails(previewItem!, callbackDetails: { (item: DetailsItem?) in
            XCTAssertNotNil(item)
            
            expectation.fulfill()
        })
        
        //Wait for the expectation
        self.waitForExpectations(timeout: Constants.Expectation.DefaultTimeOut) { error in
            if let error = error {
                XCTFail("\(Constants.Expectation.WaitForExpectations) \(error)")
            }
        }
    }
    
    func testGetDetails_withDetailsItem() {
        let expectation = self.expectation(description: Constants.Expectation.getDescription("Get details"))
        
        emagScraper = EmagScraper(forDetails!)
        previewItem?.detailsItem = DetailsItem(nil, "title", "availability", "shipping type", "seller", "description", "specifications")
        
        emagScraper?.getDetails(previewItem!, callbackDetails: { (item: DetailsItem?) in
            XCTAssertEqual(item?.title, self.previewItem?.detailsItem?.title)
            
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
