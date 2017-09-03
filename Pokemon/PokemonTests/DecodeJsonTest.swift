//
//  DecodeJsonTest.swift
//  Pokemon
//
//  Created by Craig Briggs on 3/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import XCTest
@testable import Pokemon

class DecodeJsonTest: XCTestCase {
    var pokemonGroup = [Pokemon]()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: DecodeJsonTest.self)
        Pokemon.useLocalData(bundle: bundle){newPokemonGroup in
            self.pokemonGroup = newPokemonGroup
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckCount (){
       // let decodeJson = DecodeJson()
        
        XCTAssertEqual(pokemonGroup.count, 30)
        print("this is a test")
        print(pokemonGroup.count)
    }

    func checkResultsTable () {
        
    }
    
}
