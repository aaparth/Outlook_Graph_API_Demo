//
//  MessageCell.swift
//  swift-tutorial
//
//  Created by ParthSoni on 03/01/18.
//  Copyright © 2018 ParthSoni. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    var from: String? {
        didSet {
            fromLabel.text = from
        }
    }
    
    var received: String? {
        didSet {
            receivedLabel.text = received
        }
    }
    
    var subject: String? {
        didSet {
            subjectLabel.text = subject
        }
    }
}
