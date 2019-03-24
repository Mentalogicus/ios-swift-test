//
//  CreateNodeViewController.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-24.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

protocol ICreateNodeViewControllerDelegate: class {
    func notedCreatedWithText(text: String)
}

class CreateNodeViewController: UIViewController {

    weak var delegate: ICreateNodeViewControllerDelegate?
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        saveButton.isEnabled = false
    }

    @IBAction func saveNote(_ sender: Any) {
        guard let text = noteTextView.text else { return }
        delegate?.notedCreatedWithText(text: text)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelNote(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateNodeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.saveButton.isEnabled = (textView.text != "")
    }
}
