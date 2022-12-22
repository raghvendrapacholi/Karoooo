//
//  UserListViewControllerTests.swift
//  KarooooTests
//
//  Created by Raghvendra Pacholi on 22/12/22.
//

import Quick
import Nimble
@testable import Karoooo

@MainActor
class UserListViewControllerTests: QuickSpec {
    override func spec() {
        var sut: UsersListViewController!
        describe("The 'Users List View Controller'") {
            context("Can show the correct labels text") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    let storyboard =  UIStoryboard(name: "Main", bundle: Bundle.main)
                    sut =  storyboard.instantiateViewController(withIdentifier: "UsersListViewControllerIdentifier") as? UsersListViewController
                    _ =  sut.view
                    if let path = Bundle(for: type(of: self)
                        ).path(forResource: "Users_List", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                             sut.usersListViewModel.usersDetailsViewModel = try decoder.decode([UserDetails].self, from: data).map(UserDetailsViewModel.init)
                        } catch {
                            fail("Problem parsing JSON")
                        }
                    }
                }
                it("can parse the correct name") {
                    expect(sut.usersListViewModel.usersDetailsViewModel[0].name).to(equal("Leanne Graham"))
                }
                it("can parse the correct phone number") {
                    expect(sut.usersListViewModel.usersDetailsViewModel[0].phone).to(equal("1-770-736-8031 x56442"))
                }
                it("can parse the correct latitude") {
                    expect(sut.usersListViewModel.usersDetailsViewModel[0].address.geo.lat).to(equal("-37.3159"))
                }
                it("can parse the correct longitude") {
                    expect(sut.usersListViewModel.usersDetailsViewModel[0].address.geo.lng).to(equal("81.1496"))
                }
                it("can parse the correct company name") {
                    expect(sut.usersListViewModel.usersDetailsViewModel[0].company.name).to(equal("Romaguera-Crona"))
                }
            }
        }
    }
}
