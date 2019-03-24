//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

class NotesPresenter {

    private let noteDatasource = MockNotesDataSource()
    fileprivate var notes: [Note] = []

    init(completion: @escaping () -> Void) {
        noteDatasource.createProceduralNotes(quantity: 100, dayBack: 100)
        noteDatasource.fetchNotes { (notes) in
            self.notes = notes
            completion()
        }
    }
}

extension NotesPresenter: INotesPresenter {
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfNotes() -> Int {
        return notes.count
    }

    func noteTextAtRow(_ row: Int) -> String {
        guard row >= 0 && row < notes.count else { return "" }
        return notes[row].text
    }

    func noteDateAtRow(_ row: Int) -> String {
        guard row >= 0 && row < notes.count else { return "" }
        return notes[row].date.toString()
    }

    func reloadView(completion: @escaping () -> Void) {
        noteDatasource.notesDidChange { (notes) in
            self.notes = notes
            completion()
        }
    }
}
