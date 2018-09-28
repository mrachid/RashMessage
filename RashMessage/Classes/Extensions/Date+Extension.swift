//
//  Date+Extension.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import Foundation

public extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}


class DateHelper {
    
    //32/10/2017
    static let dateShortFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        return dateFormater
    }()
}
