//
//  DecodeJsonTest.swift
//  Pokemon
//
//  Created by Craig Briggs on 3/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import XCTest
@testable import Pokemon

class PokemonDetailsTest: XCTestCase {
    var pokemonGroup = [Pokemon]()
    var pokemonDetails : PokemonDetails!
    //var error: Error?
    override func setUp() {
        super.setUp()
        pokemonDetails = PokemonDetails()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// Check if code is handling invalid URLs,should fail safely
    func testMisformedURLs (){
        // Given
        let expect = expectation(description: "URL or server not valid, should have failed safely")
        let data: String = "http://pokeapi.co/api/v2/pokemon/3/" // change this
        
        // When
        PokemonDetails.downloadPokemonDetails (dataURLPass: data, success: {_ in
            expect.fulfill()
        }, fail: {error in
            
        })
        
        // Then
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    
    /// Check if code is handling misnamed keys,should fail safely
    func testMisformedKeys (){
        
        // Given
        let expect = expectation(description: "Keys do not match, should have failed safely")
        //let data: String = "http://pokeapi.co/api/v2/machine/1/" // invalid
        let data: String = "http://pokeapi.co/api/v2/pokemon/2/"
        
        // When
        PokemonDetails.downloadPokemonDetails (dataURLPass: data, success: {test in
            expect.fulfill()
        }, fail: {error in
            
        })
        
        // Then
        waitForExpectations(timeout: 10, handler: nil)

    }
    
    /// Check if code handles misformed URLs when downloading image,should fail safely
    func testDownloadImage() {
        
        // Given
        let expect = expectation(description: "Image does not exist, should have failed safely")
        let imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/3.png" // alter for dodgy URL
        
        // When
        PokemonDetails.downloadImage(imageURL: imageURL, success: {image in
            expect.fulfill()
        }, fail: {
        
        })
        
        // Then
        waitForExpectations(timeout: 10, handler: nil)
        
        
    }
}
