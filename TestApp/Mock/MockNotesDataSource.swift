//
//  MockNoteDataSource.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-23.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

class MockNotesDataSource {

    fileprivate var notes: [Note] = []
    fileprivate let dataSourceQueue = DispatchQueue(label: "alayacare.data.source.queue")
    fileprivate var notesDidChangeBlock: (([Note]) -> Void)?

    func createProceduralNotes(quantity: Int, dayBack: Int) {
        for i in 0..<quantity {
            notes.append(Note(text: "A note number \(i)", date: Date.random(daysBack: dayBack) ?? Date()))
        }
    }

    func createNotes() {
        notes = [
            Note(text: "Allo", date: Date.fromString("26/01/2018 03:26:48") ?? Date()),
            Note(text: "New note", date: Date.fromString("26/01/2018 03:26:48") ?? Date())
        ]
    }

    fileprivate func notifyNodeDidChange() {
        let delay = Double.random(in: 0 ..< 0.5)
        dataSourceQueue.asyncAfter(deadline: .now() + delay) { [weak self] in
            if let notes = self?.notes {
                self?.notesDidChangeBlock?(notes)
            }
        }
    }
}

extension MockNotesDataSource: INotesDataSource {
    func fetchNotes(completion: @escaping ([Note]) -> Void) {
        let delay = Double.random(in: 0 ..< 1)
        dataSourceQueue.asyncAfter(deadline: .now() + delay) {
            completion(self.notes)
        }
    }

    func notesDidChange(completion: @escaping ([Note]) -> Void) {
        notesDidChangeBlock = completion
    }

    func addNote(_ note: Note) {
        dataSourceQueue.sync {
            notes.append(note)
            notifyNodeDidChange()
        }
    }

    func deleteNote(at index: Int) -> Bool {
        guard index >= 0 && index < notes.count else { return false }
        dataSourceQueue.sync {
            notes.remove(at: index)
            notifyNodeDidChange()
        }
        return true
    }

    func replaceNote(at index: Int, by note: Note) -> Bool {
        guard index >= 0 &&  index < notes.count else { return false }
        dataSourceQueue.sync {
            notes[index] = note
            notifyNodeDidChange()
        }
        return true
    }
}

extension MockNotesDataSource: CustomStringConvertible {
    var description: String {
        var notesString = "MockNotesDataSource:"
        for note in notes {
            notesString += "\n\(note)"
        }
        return notesString
    }
}
