//
//  DBError.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation

enum DBError: Error {
    case read(_ details: String)
    case write(_ details: String)
}
