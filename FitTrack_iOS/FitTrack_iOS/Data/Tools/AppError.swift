import Foundation

struct AppError: Error, Equatable {
    let reason: String
    let regex: RegexLintError?
    
    init(reason: String, regex: RegexLintError? = nil) {
        self.reason = reason
        self.regex = regex
    }
}

extension AppError {
    /// Describes a regex error in the input data
    /// - Parameter error: an enum case of type (`RegexLintErro+`–)  that represents the regex pattern
    /// - Returns: an object of type (`AppError`) to encapsulate a message and type of input error
    static func regex(_ error: RegexLintError) -> Self {
        AppError(reason: "Regex error", regex: error)
    }
    
    /// Describes an empty hero list error
    /// - Returns: an object of type (`AppError`) that encapsulate an error message
    static func emptyList() -> Self {
        AppError(reason: "Empty entity list")
    }
    
    /// Describes an empty error
    /// - Returns: an object of type (`AppError`) that encapsulate an error message
    static func notFound() -> Self {
        AppError(reason: "Entity not found")
    }
    
    /// Describes an empty error
    /// - Returns: an object of type (`AppError`) that encapsulate an error message
    static func session(_ message: String) -> Self {
        AppError(reason: message)
    }
    
    /// Describes a network error in the api client
    /// - Parameter error: an object of type (`String`) that represents an api error
    /// - Returns: an object of type (`AppError`) that encapsulate an error message
    static func network(_ errorMessage: String) -> Self {
        AppError(reason: errorMessage)
    }
    
    /// Describes an unknow login error
    /// - Returns: - Returns: an object of type (`AppError`) that encapsulate an error message
    static func uknown() -> Self {
        AppError(reason: "Unknown error")
    }
}
