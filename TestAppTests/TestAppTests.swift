//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Francis Moore on 2019-03-23.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import Quick
import Nimble

class TestAppTests: QuickSpec {
    override func spec() {
        describe("When I do this") {
            it("it must succeed") {
                let value = true
                expect(value).to(beTrue())
            }
        }
    }
}
