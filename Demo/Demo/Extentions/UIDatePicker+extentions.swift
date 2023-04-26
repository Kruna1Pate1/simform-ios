//
//  UIDatePickerStyle+extentions.swift
//  Demo
//
//  Created by Krunal Patel on 21/04/23.
//

import UIKit

extension UIDatePicker.Mode {
    var name: String {
        switch self {
        case .countDownTimer:
            return "count down timer"
        case .date:
            return "date"
        case .time:
            return "time"
        case .dateAndTime:
            return "date and time"
        }
    }
    
    var availableStyles: [UIDatePickerStyle] {
        switch self {
        case .countDownTimer:
            return [.automatic, .wheels]
        case .date:
            return [.automatic, .compact, .inline, .wheels]
        case .time:
            return [.automatic, .compact, .inline, .wheels]
        case .dateAndTime:
            return [.automatic, .compact, .inline, .wheels]
        }
    }
}

extension UIDatePickerStyle {
    var name: String {
        switch self {
        case .automatic:
            return "automatic"
        case .compact:
            return "compact"
        case .inline:
            return "inline"
        case .wheels:
            return "wheels"
        }
    }
}
