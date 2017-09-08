//
//  PokeUITests.swift
//  PokeUITests
//
//  Created by Craig Briggs on 9/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import XCTest

class PokeUITests: XCTestCase {
    var app :XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    /// Tests that the Tableview is linked to the correct page by 
    /// clicking on a couple of different tableview items and making sure the 
    /// page that follows is correct
    func testBasicTableView() {
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Ivysaur"].tap()
        XCTAssertTrue(app.staticTexts["Ivysaur"].exists, "Ivysaur field doesn't exist, wrong page")
        app.navigationBars["Pokepedia"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        tablesQuery.staticTexts["Charizard"].tap()
        XCTAssertTrue(app.staticTexts["Charizard"].exists, "Charizard field doesn't exist, wrong page")
    }
    
    /// Test that the filter is working and the correct page is loaded after a filter
    func testFilteredTableView(){
        
        let app = XCUIApplication()
        let searchPokemonSearchField = app.searchFields["Search Pokemon"]
        searchPokemonSearchField.tap()
        searchPokemonSearchField.typeText("char")
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Charmeleon"].tap()
         XCTAssertTrue(app.staticTexts["Charmeleon"].exists, "Charmeleon field doesn't exist, wrong page")
    }
}
