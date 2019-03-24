//
//  Note.swift
//  TestApp
//
//

import Foundation

class Note {
    var text: String
    var date: Date

    init(text: String, date: Date) {
        self.text = text
        self.date = date
    }
}

extension Note: CustomStringConvertible {
    var description: String {
        return "Text: \(text) Date: \(date)"
    }
}

extension Note: Equatable {
    func equalTo(rhs: Note) -> Bool {
        return rhs.text == text && rhs.date == date
    }
}

func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.equalTo(rhs: rhs)
}
