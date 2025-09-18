//
//  LoginUserCaseTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 8/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class LoginUserCaseTest: XCTestCase {
    var sut: LoginUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginUseCase(repository: MockLoginRepository())
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    /// Test para comprobar que el login se ha hecho correctamente, pues este devuele true
    func test_login_ReturnSuccess() async throws{
        
        //Given
        
        //When
        
        //let login = try await sut.run(user: "userTest", password: "passwordTest")
        
        //Then
        
        //XCTAssertNotNil(sut)
        //XCTAssertEqual(login,true)
    }
    //TODO: Implementar el test cuando podamos validar que el token se ha guardado correctamente en keychain
    /*
    func test_loginWhitJwt_ReturnSuccess() async throws{
        
        //Given
        let jwt = "tokenMock"
        
        //When
        
        let login = try await sut.login(user: "userTest", password: "passwordTest")
        
        //Then
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(login,true)
        //XCTAssertNotEqual(jwt, "")
        
    }
   */
}
