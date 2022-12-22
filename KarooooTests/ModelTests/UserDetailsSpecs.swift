//
//  UserDetailsSpecs.swift
//  KarooooTests
//
//  Created by Raghvendra Pacholi on 21/12/22.
//

import Foundation
import Quick
import Nimble


@testable import Karoooo

class UserDetailsSpecs: QuickSpec {
    
    override func spec() {
        var userDetailsList = [UserDetails]()
        describe("The 'User Details'") {
            context("Can be created with valid JSON") {
                afterEach {
                    userDetailsList = []
                }
                beforeEach {
                    //5
                    if let path = Bundle(for: type(of: self)
                    ).path(forResource:"Users_List",
                           ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            userDetailsList = try decoder.decode([UserDetails].self, from: data)
                        } catch {
                            fail("Problem parsing JSON")
                        }
                    }
                }
                it("can parse the correct name") {
                    expect(userDetailsList[0].name).to(equal("Leanne Graham"))
                }
                it("can parse the correct phone number") {
                    expect(userDetailsList[0].phone).to(equal("1-770-736-8031 x56442"))
                }
                it("can parse the correct latitude") {
                    expect(userDetailsList[0].address.geo.lat).to(equal("-37.3159"))
                }
                it("can parse the correct longitude") {
                    expect(userDetailsList[0].address.geo.lng).to(equal("81.1496"))
                }
                it("can parse the correct company name") {
                    expect(userDetailsList[0].company.name).to(equal("Romaguera-Crona"))
                }
            }
        }
    }
    
}
