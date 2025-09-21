import Foundation

/// Representation of a regex pattern
enum RegexPattern: String {
    case email = #"^[A-Za-z0-9]+@[a-zA-Z]+\.[es|com]{2,3}$"#
    case password = #"[\w]{8,24}"#
}

struct RegexLint {
    /// Validates if a string matches the patterns defined in (`RegexPattern`)
    /// - Parameters:
    ///   - data: a text of type (`String`) that represent the user input
    ///   - regexPattern: an enum case of type (`RegexPattern`)
    static func validate(data: String?, matchWith regexPattern: RegexPattern) throws -> String {
        let regex = try Regex(regexPattern.rawValue)
        guard let data, data.contains(regex) else {
            throw RegexLintError(from: regexPattern)
        }
        return data
    }
}

/// Represents a Regex error
enum RegexLintError: Error, LocalizedError {
    case email
    case password
    case none
    
    /// Constructor  to initialize an error from the RegexLint
    init(from regex: RegexPattern) {
        switch regex {
        case .email:
            self = .email
        case .password:
            self = .password
        }
    }
    
    /// A localized message describing what error occurred
    var errorDescription: String? {
        switch self {
        case .email:
            AppLogger.debug("Email format is invalid")
            return "The username or password is incorrect"
        case .password:
            AppLogger.debug("The password must have at least 8 characters")
            return "The username or password is incorrect"
        case .none:
            return nil
        }
    }
}
