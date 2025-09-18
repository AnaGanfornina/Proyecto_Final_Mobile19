//
//  AppStateTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import XCTest
@testable import FitTrack_iOS

@MainActor
final class AppStateTests: XCTestCase {
    var sut: AppState!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppState(
            loginUseCase: MockLoginUseCase(),
            getSessionUseCase: MockGetSessionUseCase()
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
 
    /// Test para comprobar que pasa del estado .none a .login. Es decir pasa de la pantalla de OnBoarding a la del login
    func test_performSignUp() async throws {
        // Given
        sut.status = Status.onBoarding
        
        // When
        sut.performSignUp()
        
        // Then
        XCTAssertEqual(sut.status, .login)
    }
    
    /// Test para comprobar que pasa del estado .login a .loading. Es decir pasa de la pantalla de Login a la de la loading.
    func test_LoginToLoading() async throws {
        // Given
        sut.status = Status.login
        let expectation = expectation(description: "Pass to loading ")
        
        // When
        sut.performLogin(user: "adminuser@keepcoding.es", password: "abc12345")
        
        let observer = Task {
            while sut.status == .login {    // Espera a que deje de ser .login
                try await Task.sleep(nanoseconds: 10_000_000)
            }
            
            XCTAssertEqual(self.sut.status, .loading)
            expectation.fulfill()
        }
        
        // Then
        
        await fulfillment(of: [expectation], timeout: 3.0)
        observer.cancel()
 
        
    }
    
    /// Test para comprobar que pasa del estado .login a .loading. Es decir pasa de la pantalla de Login a la de la loading.
    func test_LoadingToHome() async throws {
        // Given
        sut.status = Status.loading
        let expectation = expectation(description: "Login completed")
        
        // When
        let observer = Task {
            while sut.status != .home && sut.status != .none {
                try await Task.sleep(nanoseconds: 50_000_000)
            }
            expectation.fulfill()
        }
        
        sut.performLogin(user: "adminuser@keepcoding.es", password: "abc12345")
        
        // Then
        await fulfillment(of: [expectation], timeout: 3.0)
        observer.cancel()
        XCTAssertEqual(sut.status, .home)
    }
}
