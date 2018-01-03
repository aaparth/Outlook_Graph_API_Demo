//
//  EventCell.swift
//  swift-tutorial
//
//  Created by ParthSoni on 03/01/18.
//  Copyright © 2018 ParthSoni. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Event {
    let subject: String
    let start: String
    let end: String
    let bodyPreview: String
}

class EventCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var bodyPreviewLabel: UILabel!
    
    var subject: String? {
        didSet {
            subjectLabel.text = subject
        }
    }
    
    var start: String? {
        didSet {
            startLabel.text = start
        }
    }
    
    var end: String? {
        didSet {
            endLabel.text = end
        }
    }
    
    var bodyPreview: String? {
        didSet{
            bodyPreviewLabel.text = bodyPreview
        }
    }
}

class EventsDataSource: NSObject {
    let events: [Event]
    
    init(events: [JSON]?) {
        var evtArray = [Event]()
        
        if let unwrappedEvents = events {
            for (event) in unwrappedEvents {
                let newEvent = Event(
                    subject: event["subject"].stringValue,
                    start: Formatter.dateTimeTimeZoneToString(date: event["start"]),
                    end: Formatter.dateTimeTimeZoneToString(date: event["end"]),
                    bodyPreview: event["bodyPreview"].stringValue)
                evtArray.append(newEvent)
            }
        }
        self.events = evtArray
    }
}

extension EventsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self)) as! EventCell
        let event = events[indexPath.row]
        cell.subject = event.subject
        cell.start = event.start
        cell.end = event.end
        cell.bodyPreview = event.bodyPreview
        return cell
    }
}
