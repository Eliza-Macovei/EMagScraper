//
//  DetailsItemTests.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest
@testable import EmagScraperFromZero

class DetailsItemTests: XCTestCase {
    
    private var detailsItem: DetailsItem?
    
    override func setUp() {
        super.setUp()
        
        detailsItem = DetailsItem("", "title", "availability", "shipping type", "seller", "description", "specs")
    }
    
    override func tearDown() {
        super.tearDown()
        
        detailsItem = nil
    }
    
    func testAddThumbnailUrl_withEmptyUrlString() {
        addThumbnailUrlWith(nil)
        
        XCTAssertTrue(detailsItem?.listOfThumbnailUrls.count == 0)
    }
    
    func testAddThumbnailUrl_withUrlString() {
        addThumbnailUrlWith("test")
        
        XCTAssertTrue(detailsItem?.listOfThumbnailUrls.count == 1)
    }
    
    func addThumbnailUrlWith(_ stringValue: String?) {
        detailsItem?.addThumbnailUrl(stringUrl: stringValue)
    }
}
