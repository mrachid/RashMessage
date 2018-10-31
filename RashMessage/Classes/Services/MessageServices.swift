//
//  MessageServices.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import Foundation

final class MugiMessageServices {
    
   public static func parseMessageIntoSection(mugiMessages messages: [MugiMessage]) ->  [[MugiMessage]] {
        let messagesSorted = messages.sorted { (msg1, msg2) -> Bool in
            return msg1.createdAt < msg2.createdAt
        }
        
        var groupResult:[String: [MugiMessage]] = [:]
        
        for message in messagesSorted {
            let date = DateHelper.dateShortFormater.string(from: message.createdAt)
            if groupResult[date] != nil {
                groupResult[date]!.append(message)
            } else {
                groupResult[date] = [message]
            }
        }
        
        let finalResult = groupResult.sorted { (arg0, arg1) -> Bool in
            return arg0.key < arg1.key
        }
        
        var all: [[MugiMessage]] = []
        for group in finalResult {
            all.append(group.value)
        }
        
        return all
    }
}
