//
//  training.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation
@testable import FitTrack_iOS

enum TrainingData {
    static let givenItem = Training(
        id: UUID(uuidString: "DAB7C5C0-0579-4D01-A01D-002D3F6D8985"),
        name: "Fuerza: Full Body",
        scheduledAt: "2025-09-20T14:06:36Z",
        traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679")
    )
    
    static let givenList = [
        Training(
            id: UUID(uuidString: "81493846-95EB-4EB6-8343-B89BCB87C475"),
            name: "Fuerza: Full Body",
            scheduledAt: "2025-09-20T14:06:36Z",
            traineeId: UUID(uuidString: "5FFF81DE-C845-49B0-8BA0-C6AE19EC9A85")
        ),
        Training(
            id: UUID(uuidString: "78CBA4EE-8EA7-49E5-A00F-59BE9AC62DC5"),
            name: "Cardio: Run",
            scheduledAt: "2025-09-18T14:06:36Z",
            traineeId: UUID(uuidString: "5FFF81DE-C845-49B0-8BA0-C6AE19EC9A85")
        ),
        Training(
            id: UUID(uuidString: "C9A2DC6E-1B69-406F-88AC-55AAABF677BF"),
            name: "Fuerza: Full Body",
            scheduledAt: "2025-09-21T14:06:36Z",
            traineeId: UUID(uuidString: "0B75E4C6-C4F1-4376-A77E-047987D70881")
        )
    ]
}
