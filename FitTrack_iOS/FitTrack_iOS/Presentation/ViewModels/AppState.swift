//
//  AppState.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import Foundation

@MainActor
@Observable
final class AppState: ObservableObject {
    var status = Status.none  // TODO: Cambiar a Status.none cuando sepamos qué hacer con la EmptyView
    
    private var loginUsesCase: LoginUseCaseProtocol
    
    // MARK: - Initializer
    init(loginUsesCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUsesCase = loginUsesCase
        Task {
            await determineInitialState()
        }
    }
    
    // MARK: - Functions
    
    
    /// Performs the login process for a user asynchronously.
       ///
       /// This method updates the application state (`status`) according to the
       /// result of the login attempt:
       /// - Sets `status` to `.loading` while the login request is being processed.
       /// - If the login is successful, sets `status` to `.home`.
       /// - If the login fails or an error occurs, sets `status` back to `.none`.
       ///
       /// - Parameters:
       ///   - user: The username to authenticate. Defaults to `"TestUser"`.
       ///   - password: The password to authenticate. Defaults to `"TestPassword"`.
       ///
       /// - Note: The default parameters are temporary and should be removed
       ///   (`TODO`) once the login flow is fully integrated with real user input.
       ///
       /// - Important: This method runs asynchronously on a `Task`, so the state
       ///   changes may occur after a short delay.
    func performLogin(user: String = "TestUser", password: String = "TestPassword") {
        //TODO: Remover los parámetros por defautl
        self.status = .loading
        
        Task {
            do {
                try await loginUsesCase.run(user: user, password: password)
                self.status = .home
            } catch {
                print("error on login")
                self.status = .none
            }
        }
    }
    
    
    /// Determines initial State.
    /// If the status is not none, it doesn't do anything.
    /// If it's none, check onboarding and login
    func determineInitialState() async {
        guard status == .none else { return }
        status = .loading
        
        // Check onBoarding
        let hasSeenOnBoarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        if !hasSeenOnBoarding {
            status = .onBoarding
            return
        }
        
        // Check login / token
        Task {
            //let validSession = await loginUsesCase.hasValidSession()
            await MainActor.run {
                //status = validSession ? .home : .login
                status = .login
            }
        }
    }
    
    
    /// Initiates the sign-up flow.
       ///
       /// This method updates the application `status` to `.login`,
       /// which should trigger the navigation or presentation of the
       /// sign-up screen.
       ///
       /// - Note: Currently this only updates the state. Additional
       ///   sign-up logic (e.g., API calls, validation) should be
       ///   implemented in the future.
    func performSignUp(){
        
        self.status = .login
    }
    
    /// Logs out the current user and resets the application state.
       ///
       /// This method updates the application `status` to `.none`,
       /// effectively returning the app to its initial state.
       ///
       /// - Note: At the moment, this method only updates the state.
       ///   In the future it could also clear stored user data, tokens,
       ///   or cached sessions as part of the logout process.
    func logOutUser(){
        
        
        self.status = .none
        
    }
    
    
}

