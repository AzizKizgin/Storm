//
//  Utils.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation

struct Utils {
    
    // MARK: - Checking Password Validation
    static func isPasswordValid(for password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - Checking Email Validation
    static func isValidEmail(for email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - Date to Date String  
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Date String to Date
    static func stringtoDate(dateString: String) -> Date? {
        guard !dateString.isEmpty else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
    
    static func getDateTitle(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            let calendar = Calendar.current
            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInThisYear(date) {
                formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
            } else {
                formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
            }
            
            return formatter.string(from: date)
        }
        return ""
    }
    
    static func getChatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            let calendar = Calendar.current
            if calendar.isDateInToday(date) {
                formatter.setLocalizedDateFormatFromTemplate("HH:mm")
            } else if calendar.isDateInThisYear(date) {
                formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
            } else {
                formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
            }
            
            return formatter.string(from: date)
        }
        return ""
    }
    
    static func isDatesEqual(_ dateString1: String, _ dateString2: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date1 = dateFormatter.date(from: dateString1), let date2 = dateFormatter.date(from: dateString2){
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
            return formatter.string(from: date1) == formatter.string(from: date2)
        }
        return false
    }
    
    static func getMessageTime(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("HH:mm")
            return formatter.string(from: date)
        }
        return ""
    }
    
}

extension Calendar {
    private var currentDate: Date { return Date() }
    
    func isDateInThisYear(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .year)
    }
    
}
