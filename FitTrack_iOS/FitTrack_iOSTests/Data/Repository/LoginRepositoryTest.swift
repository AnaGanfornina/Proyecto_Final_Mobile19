//
//  LoginRepositoryTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 8/9/25.
//

import XCTest

@testable import FitTrack_iOS
final class LoginRepositoryTest: XCTestCase {
    
    var sut: LoginRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginRepository(network: ApiProviderMock())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_loginRepository() async throws{
        //Given
        let tokenMock = "tokenMock"
        
        //When
        let token = try await sut.loginApp(user: "userTest", pass: "passTest")
        //Then
        
        XCTAssertEqual(token, tokenMock)
    }
}
