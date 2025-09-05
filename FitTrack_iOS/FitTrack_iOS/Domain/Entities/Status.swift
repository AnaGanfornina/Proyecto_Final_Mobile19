//
//  Status.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import Foundation
enum Status : Equatable{
    case none, loading, loaded, error(error: String)
}
