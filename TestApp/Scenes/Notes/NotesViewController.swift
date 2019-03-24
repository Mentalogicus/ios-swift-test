//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView!

    var presenter: INotesPresenter?

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotesPresenter {
            DispatchQueue.main.async { [weak self] in
                self?.setupTableView()
            }
        }

        presenter?.reloadView {
            // Indicate that the data as changed and the view must be reloaded
        }
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfNotes() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath)
        }

        cell.note.text = presenter?.noteTextAtRow(indexPath.row)
        cell.date.text = presenter?.noteDateAtRow(indexPath.row)
        return cell
    }
}
