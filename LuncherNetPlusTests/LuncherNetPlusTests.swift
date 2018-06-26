//
//  LuncherNetPlusTests.swift
//  LuncherNetPlusTests
//
//  Created by Jaylin Phipps on 6/15/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import XCTest
@testable import LuncherNetPlus

class LuncherNetPlusTests: XCTestCase {
    func TwitterUrl() {
        let browser = BroswerViewController()
        
        let givenUrl = browser.twitterUrl
        
        XCTAssertNotNil(givenUrl)
    }
    
    func BrowserUrl() {
        let browser = BroswerViewController()
        
        let citiUrl = browser.citiUrl
        
        XCTAssertNotNil(citiUrl)
        
    }
}
