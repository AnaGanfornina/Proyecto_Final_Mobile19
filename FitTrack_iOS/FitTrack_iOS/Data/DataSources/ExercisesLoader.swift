//
//  ExercisesLoader.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//

import Foundation

final class ExercisesLoader {
    
    // MARK: Properties
    var exercises: [Exercise]
    
    // MARK: Init
    init() {

        self.exercises = []
        
        
    }
    
    func loadData() -> [Exercise]? {
        
        do {
            guard let filepath =  Bundle.main.path(forResource: "exercises", ofType: "json") else {
                AppLogger.debug("Error: No se encontró el archivo exercises.json en el bundle.")
                return nil
            }
            let url = URL(fileURLWithPath: filepath)
            
            guard FileManager.default.fileExists(atPath: url.path) else {
                AppLogger.debug("Error: No se encontró el archivo exercises.json en la ruta.")
                return nil
            }
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
         
            let exerciseResponse = try decoder.decode([Exercise].self, from: data)
            return exerciseResponse
            
        } catch {
            AppLogger.debug("Error al cargar o decodificar exercises.json: \(error)")
            return nil
        }
    }
}
