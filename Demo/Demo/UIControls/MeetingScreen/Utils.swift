//
//  Utils.swift
//  Demo
//
//  Created by Krunal Patel on 19/04/23.
//

import UIKit

let timeZones = [
    "(UTC) Casablanca",
    "(UTC) Coordinated Universal Time",
    "(UTC) Dublin, Edinburgh, Lisbon, London",
    "(UTC) Monrovia, Reykjavik",
    "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",
    "(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague",
    "(UTC+01:00) Brussels, Copenhagen, Madrid, Paris",
    "(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb",
    "(UTC+01:00) West Central Africa",
    "(UTC+01:00) Windhoek",
    "(UTC+02:00) Amman",
    "(UTC+02:00) Athens, Bucharest",
    "(UTC+02:00) Beirut",
    "(UTC+02:00) Cairo",
    "(UTC+02:00) Damascus",
    "(UTC+02:00) E. Europe",
    "(UTC+02:00) Harare, Pretoria",
    "(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius",
    "(UTC+02:00) Istanbul",
    "(UTC+02:00) Jerusalem",
    "(UTC+03:00) Baghdad",
    "(UTC+03:00) Kuwait, Riyadh",
    "(UTC+03:00) Minsk",
    "(UTC+03:00) Moscow, St. Petersburg, Volgograd (RTZ 2)",
    "(UTC+03:00) Nairobi",
    "(UTC+03:30) Tehran",
    "(UTC+04:00) Abu Dhabi, Muscat",
    "(UTC+04:00) Baku",
    "(UTC+04:00) Port Louis",
    "(UTC+04:00) Tbilisi",
    "(UTC+04:00) Yerevan",
    "(UTC+04:30) Kabul",
    "(UTC+05:00) Ashgabat, Tashkent",
    "(UTC+05:00) Islamabad, Karachi",
    "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
    "(UTC+05:30) Sri Jayawardenepura",
    "(UTC+05:45) Kathmandu",
    "(UTC+06:00) Astana",
    "(UTC+06:00) Dhaka",
    "(UTC+06:30) Yangon (Rangoon)",
    "(UTC+07:00) Bangkok, Hanoi, Jakarta",
    "(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi",
    "(UTC+08:00) Kuala Lumpur, Singapore",
    "(UTC+08:00) Taipei",
    "(UTC+08:00) Ulaanbaatar",
    "(UTC+09:00) Osaka, Sapporo, Tokyo",
    "(UTC+09:00) Seoul",
    "(UTC+10:00) Canberra, Melbourne, Sydney",
    "(UTC+10:00) Guam, Port Moresby",
    "(UTC+11:00) Solomon Is., New Caledonia",
    "(UTC+12:00) Auckland, Wellington",
    "(UTC+12:00) Coordinated Universal Time+12",
    "(UTC+12:00) Fiji",
    "(UTC+13:00) Nuku'alofa",
    "(UTC+13:00) Samoa",
    "(UTC-01:00) Cabo Verde Is.",
    "(UTC-02:00) Coordinated Universal Time-02",
    "(UTC-03:00) Brasilia",
    "(UTC-03:00) Cayenne, Fortaleza",
    "(UTC-03:00) City of Buenos Aires",
    "(UTC-03:00) Greenland",
    "(UTC-03:00) Montevideo",
    "(UTC-03:00) Santiago",
    "(UTC-04:00) Asuncion",
    "(UTC-04:00) Atlantic Time (Canada)",
    "(UTC-04:00) Georgetown, La Paz, Manaus, San Juan",
    "(UTC-04:30) Caracas",
    "(UTC-05:00) Bogota, Lima, Quito, Rio Branco",
    "(UTC-05:00) Eastern Time (US & Canada)",
    "(UTC-06:00) Central America",
    "(UTC-06:00) Guadalajara, Mexico City, Monterrey",
    "(UTC-07:00) Mountain Time (US & Canada)",
    "(UTC-08:00) Pacific Time (US & Canada)",
    "(UTC-10:00) Hawaii",
    "(UTC-11:00) Coordinated Universal Time-11"
]

let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

extension UIImage {
    static func randomProfileImage(_ size: CGSize = CGSizeMake(40, 40)) -> UIImage? {
        return UIImage(named: "profile_\(Int.random(in: 0...5))")
    }
}

extension Date {
    func formatted(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {
    func formatted(units: NSCalendar.Unit = [.hour, .minute]) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .full
        return formatter.string(from: self)?.replacingOccurrences(of: ",", with: "") ?? ""
    }
}

extension UIViewController {
    
    func showToast(message : String, backgroundColor: UIColor = .red) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: 400, width: 150, height: 35))
        toastLabel.backgroundColor = backgroundColor
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }

func isValidEmail(_ email: String?) -> Bool {
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

