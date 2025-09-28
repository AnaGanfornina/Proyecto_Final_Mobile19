//
//  GetTraineesByMonthURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

struct GetTrainingsByMonthURLRequest: URLRequestComponents {
    typealias Response = [TrainingDTO]
    var path: String = "/api/trainings/byMonth"
    var queryParameters: [String : String]?
    var httpMethod: HTTPMethod = .GET
    var authorized: Bool = true
    
    init(_ month: Int, year: Int) {
        queryParameters = [
            "month": month.description,
            "year": year.description
        ]
    }
}
