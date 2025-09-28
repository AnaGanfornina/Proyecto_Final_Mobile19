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
            guard let filepath =  Bundle.main.path(forResource: "exercises", ofType: "json", inDirectory: "Data/Datasource/exercises") else {
                AppLogger.debug("Error: No se encontró el archivo songs.json en el bundle.")
                return nil
            }
            let url = URL(fileURLWithPath: filepath)
            
            guard FileManager.default.fileExists(atPath: url.path) else {
                AppLogger.debug("Error: No se encontró el archivo songs.json en la ruta.")
                return nil
            }
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
  
            let exerciseResponse = try decoder.decode(exerciseResponse.self, from: data)
            return exerciseResponse.exercises
            
        } catch {
            AppLogger.debug("Error al cargar o decodificar songs.json: \(error)")
            return nil
        }
    }
}
