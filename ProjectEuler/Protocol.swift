//
//  Protocol.swift
//  ProjectEuler
//
//  Created by Alex Pro on 2/5/19.
//  Copyright © 2019 Alex Pro. All rights reserved.
//

import Foundation

protocol Task: class {
    static func runTask() -> TimeInterval
}
