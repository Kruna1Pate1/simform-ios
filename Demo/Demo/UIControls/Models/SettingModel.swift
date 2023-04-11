//
//  SettingModel.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

struct Setting {
    let icon: UIImage?
    let title: String
    var isSwitched: Bool = false
    var isSwitchOn: Bool = false
    var description: String?
    var expanded: Bool?
    
    static func dummySettings(for category: String) -> [Setting] {
        
        switch category {
        case "Network":
            return [
                Setting(icon: UIImage(named: "wifi"), title: "Wi-Fi", isSwitched: true, isSwitchOn: true),
                Setting(icon: UIImage(named: "mobile_network"), title: "Mobile network"),
                Setting(icon: UIImage(named: "bluetooth"), title: "Bluetooth", isSwitched: true),
                Setting(icon: UIImage(named: "share"), title: "Connection sharing")
            ]
        case "Accessibility":
            return [
                Setting(icon: UIImage(named: "paint"), title: "Wallpaper & style"),
                Setting(icon: UIImage(named: "wallpaper"), title: "Home screen & Lock Screen"),
                Setting(icon: UIImage(named: "sun2"), title: "Display & brightness"),
                Setting(icon: UIImage(named: "sound"), title: "Sound & vibration"),
                Setting(icon: UIImage(named: "notification"), title: "Notification")
            ]
        case "Security":
            return [
                Setting(icon: UIImage(named: "apps"), title: "Apps"),
                Setting(icon: UIImage(named: "key"), title: "Password"),
                Setting(icon: UIImage(named: "privacy"), title: "Privacy"),
                Setting(icon: UIImage(named: "gps"), title: "Location", isSwitched: true),
                Setting(icon: UIImage(named: "emergency"), title: "Safety & emergency")
            ]
        case "Developer options":
            return [
                Setting(icon: UIImage(named: "developer"), title: "Developer Mode", isSwitched: true, isSwitchOn: true),
                Setting(icon: UIImage(named: "lab"), title: "iOS Lab"),
                Setting(icon: UIImage(named: "jail_break"), title: "Jail break", isSwitched: true)
            ]
        case "Language":
            return [
                Setting(icon: UIImage(named: "language"), title: "Select Language", expanded: true)
            ]
        default:
            return []
        }
    }
}

protocol expandable {
    var expandade: Bool { get set }
}
