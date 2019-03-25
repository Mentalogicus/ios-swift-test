//
//  INotesPresenter.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-24.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

protocol INotesPresenter {
    func numberOfSections() -> Int
    func numberOfNotes() -> Int
    func noteTextAtRow(_ row: Int) -> String
    func noteDateAtRow(_ row: Int) -> String
    func reloadView(completion: @escaping () -> Void)
    func addNote(_ text: String)
    func search(by text: String)
}
