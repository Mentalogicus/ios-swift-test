//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

class NotesPresenter {

    private let noteDatasource = MockNotesDataSource()
    fileprivate var notes: [Note] = []
    fileprivate var filteredNotes: [Note] = []
    fileprivate var reloadViewBlock: (() -> Void)?
    fileprivate var searchQuery: String = ""

    init(completion: @escaping () -> Void) {
        //noteDatasource.createProceduralNotes(quantity: 5, dayBack: 100)
        noteDatasource.createNotesForSearch()
        noteDatasource.fetchNotes { (notes) in
            self.setNotes(notes)
            completion()
        }
    }

    fileprivate func sortByDate() {
        self.notes = self.notes.sorted { rhs, lhs in
            return rhs.date >= lhs.date
        }
    }

    fileprivate func setNotes(_ notes: [Note]) {
        self.notes = notes
        self.sortByDate()
        filter()
    }

    fileprivate func filter() {
        guard searchQuery != "" else {
            filteredNotes = notes
            return
        }
        filteredNotes = notes.filter({ (note) -> Bool in
            return note.text.contains(self.searchQuery)
        })
    }
}

extension NotesPresenter: INotesPresenter {
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfNotes() -> Int {
        return filteredNotes.count
    }

    func noteTextAtRow(_ row: Int) -> String {
        guard row >= 0 && row < filteredNotes.count else { return "" }
        return filteredNotes[row].text
    }

    func noteDateAtRow(_ row: Int) -> String {
        guard row >= 0 && row < filteredNotes.count else { return "" }
        return filteredNotes[row].date.toString()
    }

    func reloadView(completion: @escaping () -> Void) {
        reloadViewBlock = completion
        noteDatasource.notesDidChange { [weak self] (notes) in
            self?.setNotes(notes)
            self?.reloadViewBlock?() ?? completion()
        }
    }

    func addNote(_ text: String) {
        guard text != "" else { return }
        noteDatasource.addNote(Note(text: text))
    }

    func search(by text: String) {
        searchQuery = text
        filter()
        reloadViewBlock?()
    }
}
