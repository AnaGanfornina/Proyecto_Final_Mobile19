//
//  AppLogger.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 8/9/25.
//

import Foundation

import OSLog

class AppLogger {
    // El subsystem en logging permite filtrar y separar los logs de diferentes orígenes (apps, sistema, frameworks) evitando que se mezclen, facilitando la identificación y depuración de los registros específicos de la aplicación.
    private static let subsystem = "com.jetLag.FitTrack_iOS"
    
    // Cada vez que creemos un logger se añade al diccionario de loggerCache para que no se repitan y se use una única instancia por cada categoría
    private static var loggerCache: [String: Logger] = [:]
    
    
    private static func getLogger(category: String) -> Logger {
        guard let logger = loggerCache[category] else {
            loggerCache[category] = Logger(subsystem: subsystem, category: category)
            return loggerCache[category]!
        }
        return logger
    }
    
    // TODO:  CREAR RESTO DE FUNCIONES (INFO, ERROR...)
    
    static func debug(_ message: String, withSensitiveValues sensitiveValues: [String: String]? = nil, inFile file: StaticString = #file, andFunction function: StaticString = #function, onLine line: UInt = #line) {
        // file = toda la ruta + RemoteDataSourceImpl.swift
        let filename: NSString = ("\(file)" as NSString).lastPathComponent as NSString // Ejemplo Filename = RemoteDataSourceImpl.swift
        let category = filename.deletingPathExtension // Category = RemoteDataSourceImpl
        let logger = getLogger(category: category) // Le pasamos la categoría al logger
        
        let logMessage = "🔍 \(message)"
        
        if let sensitiveValues = sensitiveValues {
            logger.debug("\(logMessage) with sensitive values --> in \(function) on \(line)")
            // Reemplazar cada valor sensible
            for (key, value) in sensitiveValues {
                logger.debug("--> \(key): \(value, privacy: .sensitive(mask: .hash))")
            }
        } else {
            logger.debug("\(logMessage) --> in \(function) on \(line)")
        }
    }
}



