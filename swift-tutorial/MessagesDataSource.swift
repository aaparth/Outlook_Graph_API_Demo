//
//  MessagesDataSource.swift
//  swift-tutorial
//
//  Created by ParthSoni on 03/01/18.
//  Copyright © 2018 ParthSoni. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessagesDataSource: NSObject {
    let messages: [Message]
    
    init(messages: [SwiftyJSON.JSON]?) {
        var msgArray = [Message]()
        
        if let unwrappedMessages = messages {
            for (message) in unwrappedMessages {
                let newMsg = Message(
                    from: message["from"]["emailAddress"]["name"].stringValue,
                    received: Formatter.dateToString(date: message["receivedDateTime"]),
                    subject: message["subject"].stringValue)
                
                msgArray.append(newMsg)
            }
        }
        
        self.messages = msgArray
    }
}

extension MessagesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCell.self)) as! MessageCell
        let message = messages[indexPath.row]
        cell.from = message.from
        cell.received = message.received
        cell.subject = message.subject
        return cell
    }
}
