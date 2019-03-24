//
//  TestINotesDataSource.swift
//  TestAppTests
//
//  Created by Francis Moore on 2019-03-23.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TestApp

class INotesDataSourceTests: QuickSpec {

    override func spec() { // swiftlint:disable:this function_body_length
        Nimble.AsyncDefaults.Timeout = 1000

        describe("When adding a note") {
            let datasource = MockNotesDataSource()
            let firstNote: Note = Note(text: "Allo", date: Date())
            var notesList: [Note] = []

            it("must trigger notesDidChange") {
                waitUntil { done in
                    datasource.notesDidChange(completion: { (notes) in
                        expect(notes).toNot(beNil())
                        notesList = notes
                        done()
                    })
                    datasource.addNote(firstNote)
                }
            }

            it("the first note of the array must be equal to the node added") {
                expect(notesList.first).to(equal(firstNote))
            }
        }

        describe("When trying to delete a note at wrong index") {
            let datasource = MockNotesDataSource()
            it("must return false") {
                let success = datasource.deleteNote(at: 20)
                expect(success).to(beFalse())
            }
        }

        describe("When deleting a note") {
            let datasource = MockNotesDataSource()
            datasource.createNotes()
            var notesList: [Note] = []
            var success = false

            it("must trigger notesDidChange") {
                waitUntil { done in
                    datasource.notesDidChange(completion: { (notes) in
                        expect(notes).toNot(beNil())
                        notesList = notes
                        done()
                    })
                    success = datasource.deleteNote(at: 0)
                }
            }

            it("must succeed") {
                expect(success).to(beTrue())
            }

            it("the notes array must equal 1") {
                expect(notesList.count).to(equal(1))
            }

            it("remaining note text must be right") {
                expect(notesList.first?.text).to(equal("New note"))
            }
        }

        describe("When replacing a note at wrong index") {
            let datasource = MockNotesDataSource()
            it("must return false") {
                let success = datasource.replaceNote(at: 20, by: Note(text: "Allo", date: Date()))
                expect(success).to(beFalse())
            }
        }

        describe("When replacing a note") {
            let datasource = MockNotesDataSource()
            datasource.createNotes()
            var notesList: [Note] = []
            var success = false

            it("must trigger notesDidChange") {
                waitUntil { done in
                    datasource.notesDidChange(completion: { (notes) in
                        expect(notes).toNot(beNil())
                        notesList = notes
                        done()
                    })
                    success = datasource.replaceNote(at: 0, by: Note(text: "Replaced", date: Date()))
                }
            }

            it("must succeed") {
                expect(success).to(beTrue())
            }

            it("must have replaced the note properly") {
                expect(notesList.first?.text).to(equal("Replaced"))
            }
        }

        describe("When making multiple operation on concurent thread") {
            let groupQueue = DispatchQueue(label: "alayacare.INotesDataSourceTests.groupqueue", attributes: .concurrent)
            let dispatchGroup = DispatchGroup()
            let datasource = MockNotesDataSource()
            let quantity = 1000
            datasource.createProceduralNotes(quantity: quantity, dayBack: 50)

            it ("all operation must work") {
                var success = false
                for _ in 0...1000 {
                    dispatchGroup.enter()
                    groupQueue.async {
                        datasource.fetchNotes(completion: { (_) in
                        })
                        datasource.addNote(Note(text: "Allo", date: Date()))
                        success = datasource.deleteNote(at: Int(arc4random_uniform(UInt32(quantity-1))))
                        expect(success).to(beTrue())
                        success = datasource.replaceNote(at: Int(arc4random_uniform(UInt32(quantity-1))), by: Note(text: "Replaced", date: Date()))
                        expect(success).to(beTrue())
                        dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.wait()
            it("must not crash") {
                expect(true).to(beTrue())
            }
        }
    }
}
