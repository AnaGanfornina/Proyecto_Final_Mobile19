//
//  AppStateTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class AppStateTest: XCTestCase {
    var sut: AppState!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppState(loginUsesCase: LoginUseCaseMock())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    
    /// Test para comprobar que pasa del estado .none a .loading. Es decir pasa de la pantalla de OnBoarding a la del login
    func test_performSignUp() throws {
        // Given
        sut.status = Status.onBoarding
        let expectation = expectation(description: "Pass to Login is OK")
        
        // Observamos el cambio de estado
        DispatchQueue.global().async {
               while self.sut.status != .login { }
               expectation.fulfill()
           }
         
        // When
        sut.performSignUp()
        
        
        // Then
        wait(for: [expectation], timeout: 1.0) // lo ponemos en 4 ya que el login tarda 2 segundos en hacerse
        XCTAssertEqual(sut.status, .login)
        
    }
    
    /// Test para comprobar que pasa del estado .loading a .loaded. Es decir pasa de la pantalla de Login a la de la home.
    func test_LoginApp() throws {
        // Given
        sut.status = Status.loading
        let expectation = expectation(description: "Pass to Home is OK")
        
        // Observamos el cambio de estado
        DispatchQueue.global().async {
               while self.sut.status != .loading { }
               expectation.fulfill()
           }
         
        // When
        sut.performLogin()
        
        // Then
        wait(for: [expectation], timeout: 1.0) // lo ponemos en 4 ya que el login tarda 2 segundos en hacerse
        XCTAssertEqual(sut.status, .home)
        
    }
}
