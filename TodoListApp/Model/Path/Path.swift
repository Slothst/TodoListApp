//
//  Path.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
