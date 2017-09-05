//
//  DecodeJsonTest.swift
//  Pokemon
//
//  Created by Craig Briggs on 3/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import XCTest
@testable import Pokemon

class testPokemonList: XCTestCase {
    var pokemonGroup:[Pokemon]!
    //var error: Error?
    override func setUp() {
        super.setUp()
        pokemonGroup = [Pokemon]()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Check that Pokemon is initialized correctly
    func testPokomonInit (){
        let pokemonDictionary: [String:Any] = ["name": "sandslash", "url": "http://pokeapi.co/"]
        let pokemon = Pokemon.init(pokemonDictionary: pokemonDictionary)
        XCTAssertEqual(pokemon.name, "sandslash")
        XCTAssertEqual(pokemon.url, "http://pokeapi.co/")
    }
    
    /// Checks that the correct number of Pokemon are returned - 30
    func testCheckCount (){
        // Given
        let bundle = Bundle(for: testPokemonList.self)
        
        // When
        Pokemon.useLocalData(bundle: bundle, success: {newPokemonGroup in
            self.pokemonGroup = newPokemonGroup
            
        }, fail: {error in
        })

        // Then
        XCTAssertEqual(pokemonGroup.count, 30)
    }
    
    /// Checks if JSON file formed badly, if so then should fail safely
    func testCheckForMisFormedJSON () {
        // Given
        let bundle = Bundle(for: testPokemonList.self)
        
        // When
        Pokemon.useLocalData(bundle: bundle, success: {newPokemonGroup in
        }, fail: {error in
            // Then
             XCTAssertEqual(error.code, 3840, "JSON Correct format")
        })
        
    }
    
    /// Check if code is handling misnamed keys, should skip over them and return 28
    func testMisformedKeys (){
        // Given
        let bundle = Bundle(for: testPokemonList.self)
        
        // When
        Pokemon.useLocalData(bundle: bundle, fileName: "pokemonListMisformedKeys" ,success: {newPokemonGroup in
            self.pokemonGroup = newPokemonGroup
        }, fail: {error in
        })
        
        // Then
        XCTAssertEqual(pokemonGroup.count, 28)
    }
    

    /// Will pass over dodgy URL, should fail safely
    func testConnectionToServer () {
        
        // Given
        let expect = expectation(description: "URL or server not valid, should have failed safely")
        
        // When
        Pokemon.downloadPokemonData(downloadURL:"http://pokeapi.co/api/v2/pokemon/?limit=30&offset=1", success: {newPokemonGroup in // successfully downloaded content
            self.pokemonGroup = newPokemonGroup
            expect.fulfill()
        }, fail: {error in // error downloading so load local file
            print("Failed safely")
        })
        
        // Then
        waitForExpectations(timeout: 10, handler: nil)
        
    }
}
