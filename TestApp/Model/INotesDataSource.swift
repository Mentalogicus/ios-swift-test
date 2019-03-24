//
//  INotesDataSource.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-23.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

protocol INotesDataSource {
    func fetchNotes(completion: @escaping ([Note]) -> Void)
    func addNote(_ note: Note)
    func deleteNote(at index: Int) -> Bool
    func replaceNote(at index: Int, by note: Note) -> Bool
    func notesDidChange(completion: @escaping ([Note]) -> Void)
}
