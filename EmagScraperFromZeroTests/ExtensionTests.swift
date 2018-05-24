//
//  ExtensionTests.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest
@testable import SwiftSoup
@testable import EmagScraperFromZero

class ElementTests: XCTestCase {

    private var element: Element?
    
    override func setUp() {
        super.setUp()
        
        element = Element(Tag(""), "")
    }
    
    override func tearDown() {
        super.tearDown()
        
        element = nil
    }
    
    func testTryGetElement_withEmptyValue() {
        XCTAssertNil(element?.tryGetElement(""))
    }
    
    func testTryGetText_withEmptyValue() {        
        XCTAssertTrue((element?.tryGetText().isEmpty)!)
    }
    
    func testTryReadValue_withEmptyValue() {
        XCTAssertNil(Element.tryReadValue("", reader: (element?.attr)!))
    }
}

class UIImageViewTests: XCTestCase {

    private var uiimageView: UIImageView?
    
    private let invalidValue = "test"
    private let validValue = "https://s12emagst.akamaized.net/products/8892/8891494/images/res_d7d63673fac35dac5f93604c4a7bd059_450x450_5t3l.jpg"
    private var mockURLSession: MockURLSession?
    
    override func setUp() {
        super.setUp()
        
        uiimageView = UIImageView()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        super.tearDown()
        
        uiimageView = nil
        mockURLSession = nil
    }
    
    func testLoadImageUsingUrlString_withInvalidUrl() {
        uiimageView?.loadImageUsingUrlString(url: URL(string: invalidValue)!, mockURLSession)
        
        XCTAssertNil(uiimageView?.image)
    }
    
    func testLoadImageUsingUrlString_withInvalidUrlString() {
        uiimageView?.loadImageUsingUrlString(urlString: invalidValue, mockURLSession)
        
        XCTAssertNil(uiimageView?.image)
    }
    
    func testSetupImageViewForGestureRecognizer_withValue() {
        uiimageView?.setupImageViewForGestureRecognizer(UITapGestureRecognizer())
        
        XCTAssertNotNil(uiimageView?.gestureRecognizers)
    }
}

class UIImageTests: XCTestCase {    
    func testFrom_withValue() {
        let value = UIImage.from(color: .white)
        
        XCTAssertNotNil(value)
    }
}

class UIViewTests: XCTestCase {
    private var uiview: UIView?
    
    override func setUp() {
        super.setUp()
        
        uiview = UIView()
    }
    
    override func tearDown() {
        super.tearDown()
        
        uiview = nil
    }
    
    func testGenerateActivityIndicator_checkingColor() {
        let value = uiview?.generateActivityIndicator()
        
        XCTAssertEqual(value?.color, #colorLiteral(red: 0.4078431373, green: 0.09411764706, blue: 0.5333333333, alpha: 1))
    }
}

class UINavigationItemTests: XCTestCase {
    private var uinavigationItem: UINavigationItem?
    
    override func setUp() {
        super.setUp()
        
        uinavigationItem = UINavigationItem()
    }
    
    override func tearDown() {
        super.tearDown()
        
        uinavigationItem = nil
    }
    
    func testAddButtonNav_haveGesture() {
        uinavigationItem?.addButtonNav(onTap: UITapGestureRecognizer())
        
        XCTAssertEqual(uinavigationItem?.rightBarButtonItems?.count, 1)
    }
}
