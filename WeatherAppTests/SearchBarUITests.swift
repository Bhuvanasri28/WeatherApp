//
//  SearchBarUITests.swift
//  WeatherAppTests
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

import UIKit
import XCTest

class SearchBarUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testSearchBarFunctionality() {
        let searchField = app.searchFields["Search for a city"]
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("London")
        
        let firstResult = app.staticTexts["London, ENG, UK"]
        XCTAssertTrue(firstResult.exists)
    }
}
