//
//  EmagScraperFromZeroUITests.swift
//  EmagScraperFromZeroUITests
//
//  Created by Pinzariu Marian on 21/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import XCTest

class EmagScraperFromZeroUITests: XCTestCase {
    
    private var application: XCUIApplication?
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application = XCUIApplication()
        application?.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        application = nil
    }
    
    func testBtnSearchClicked_withAppleValue() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
    }
    
    func testBtnSearchClicked_withWrongValue() {
        doSearch("vadscdveeqqw")
        
        XCTAssertNotNil(application?.alerts["No results"].buttons["OK"])
        application?.alerts["No results"].buttons["OK"].tap()
    }
    
    func testTextFieldShouldReturn_withLenovoValue() {
        doSearch("lenovo", tapOnButton: false)
        
        XCTAssertEqual(application?.tables.cells.count, 36)
    }
    
    func testGetDetails_foriPhoneX() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        application?.tables/*@START_MENU_TOKEN@*/.staticTexts["Telefon mobil Apple iPhone X, 64GB, 4G, Space Grey"]/*[[".cells.staticTexts[\"Telefon mobil Apple iPhone X, 64GB, 4G, Space Grey\"]",".staticTexts[\"Telefon mobil Apple iPhone X, 64GB, 4G, Space Grey\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotNil(application?.scrollViews.otherElements.containing(.staticText, identifier:"Telefon mobil Apple iPhone X, 64GB, 4G, Space Grey"))
    }
    
    func testPreviewImage_forIPhone7() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        swipeUpAndTapOnIPhone7()
        
        let image = application?.scrollViews.children(matching: .image).element
        XCTAssertNotNil(image)
    }
    
    func testPreviewImageFromDetailsAndTable_forIPhone7() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        application?.tables/*@START_MENU_TOKEN@*/.staticTexts["Telefon mobil Apple iPhone 7, 32GB, Black"]/*[[".cells[\"Telefon mobil Apple iPhone 7, 32GB, Black, 2799.90, Lei, Label\"].staticTexts[\"Telefon mobil Apple iPhone 7, 32GB, Black\"]",".staticTexts[\"Telefon mobil Apple iPhone 7, 32GB, Black\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(3)
        
        let scrollViewsQuery = application?.scrollViews
        scrollViewsQuery?.otherElements.containing(.staticText, identifier:"Telefon mobil Apple iPhone 7, 32GB, Black").children(matching: .image).element.tap()
        
        var image = scrollViewsQuery?.children(matching: .image).element
        XCTAssertNotNil(image)
        
        image?.swipeLeft()
        image?.tap()
        
        application?.navigationBars["EmagScraperFromZero.PageView"].buttons["Back"].tap()
        application?.navigationBars["EmagScraperFromZero.DetailsView"].buttons["Back"].tap()
        
        sleep(1)
        application?.tables.cells["Telefon mobil Apple iPhone 7, 32GB, Black, 2799.90, Lei, Label"].children(matching: .image).element.tap()
        
        image = application?.scrollViews.children(matching: .image).element
        XCTAssertNotNil(image)
    }
    
    func testPreviewImageFromDetails_forIPhone7() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        application?.tables/*@START_MENU_TOKEN@*/.staticTexts["Telefon mobil Apple iPhone 7, 32GB, Black"]/*[[".cells[\"Telefon mobil Apple iPhone 7, 32GB, Black, 2799.90, Lei, Label\"].staticTexts[\"Telefon mobil Apple iPhone 7, 32GB, Black\"]",".staticTexts[\"Telefon mobil Apple iPhone 7, 32GB, Black\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        sleep(5)

        let scrollViewsQuery = application?.scrollViews
        scrollViewsQuery?.otherElements.containing(.staticText, identifier:"Telefon mobil Apple iPhone 7, 32GB, Black").children(matching: .image).element.tap()
        
        let image = scrollViewsQuery?.children(matching: .image).element
        XCTAssertNotNil(image)
        
        image?.swipeLeft()
        image?.tap()
        
        application?.navigationBars["EmagScraperFromZero.PageView"].buttons["Back"].tap()
    }
    
    func testPreviewImageAndSwipeLeft10Times_forIPhone7() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        swipeUpAndTapOnIPhone7()
        
        sleep(3)

        swipeBetweenImages((application?.scrollViews)!, "left")
    }
    
    func testPreviewImageAndSwipeRight10Times_forIPhone7() {
        doSearch("apple")
        
        XCTAssertEqual(application?.tables.cells.count, 36)
        
        swipeUpAndTapOnIPhone7()

        sleep(3)

        swipeBetweenImages((application?.scrollViews)!, "right")
    }
    
    func testGotoFirstView_fromDetails() {
        doSearch("cafea")
        
        XCTAssertGreaterThan(application!.tables.cells.count, 0)
        
        application?.tables/*@START_MENU_TOKEN@*/.staticTexts["Capsule Jacobs Tassimo Espresso, 16 Capsule, 118.4 g"]/*[[".cells.staticTexts[\"Capsule Jacobs Tassimo Espresso, 16 Capsule, 118.4 g\"]",".staticTexts[\"Capsule Jacobs Tassimo Espresso, 16 Capsule, 118.4 g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let image = application?.navigationBars["EmagScraperFromZero.DetailsView"].images["emagLogo"]
        XCTAssertNotNil(image)
        image?.tap()
        
        let searchTextField = application?.textFields["(search)"]
        XCTAssertNotNil(searchTextField)
        searchTextField?.tap()
        
        XCTAssertEqual(searchTextField?.value as! String, "cafea")
    }
    
    func testGotoFirstView_fromTable() {
        doSearch("cafea")
        
        XCTAssertGreaterThan(application!.tables.cells.count, 0)
        application?.tables.element.swipeDown()
        
        let image = application?.navigationBars["EmagScraperFromZero.ItemTableView"].images["emagLogo"]
        XCTAssertNotNil(image)
        image?.tap()
        
        let searchTextField = application?.textFields["(search)"]
        XCTAssertNotNil(searchTextField)
        searchTextField?.tap()
        
        XCTAssertEqual(searchTextField?.value as! String, "cafea")
    }
    
    private func doSearch(_ searchValue: String, tapOnButton: Bool = true) {
        application?.textFields["(search)"].tap()
        application?.textFields["(search)"].typeText(searchValue)
        
        if tapOnButton {
            application?.children(matching: .window).element(boundBy: 0).buttons["Search"].tap()
        } else {
            application?.keyboards.buttons["Search"].tap()
        }
        
        sleep(5)
    }
    
    private func swipeBetweenImages(_ scrollViewsQuery: XCUIElementQuery,_ swipeType: String) {
        let firstImage = scrollViewsQuery.children(matching: .image).element
        var image: XCUIElement? = nil
        var index = 0
        while index <= 5 {
            if image == nil {
                image = firstImage
            }
            
            XCTAssertNotNil(image)
            
            if swipeType == "left" {
                image!.swipeLeft()
            } else {
                image!.swipeRight()
            }
            
            sleep(1)
            
            image = scrollViewsQuery.children(matching: .image).element
            index += 1
        }
    }
    
    private func swipeUpAndTapOnIPhone7() {
        let tablesQuery = application?.tables
        
        tablesQuery?.cells["Telefon mobil Apple iPhone 7, 32GB, Black, 2799.90, Lei, Label"].children(matching: .image).element.tap()
    }
}
