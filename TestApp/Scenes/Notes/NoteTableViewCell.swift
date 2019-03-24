//
//  NoteTableViewCell.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-24.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
