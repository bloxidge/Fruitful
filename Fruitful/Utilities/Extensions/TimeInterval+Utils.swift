//
//  TimeInterval+Utils.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation

extension TimeInterval {
    
    private static var hoursPerDay: Double { 24 }
    private static var minutesPerHour: Double { 60 }
    private static var secondsPerMinute: Double { 60 }
    private static var millisecondsPerSecond: Double { 1000 }

    /// - Returns: The value in days using the `TimeInterval` type.
    static func days(_ value: Double) -> TimeInterval {
        return hours(value) * hoursPerDay
    }

    /// - Returns: The value in hours using the `TimeInterval` type.
    static func hours(_ value: Double) -> TimeInterval {
        return minutes(value) * minutesPerHour
    }

    /// - Returns: The value in minutes using the `TimeInterval` type.
    static func minutes(_ value: Double) -> TimeInterval {
        return seconds(value) * secondsPerMinute
    }

    /// - Returns: The value in seconds using the `TimeInterval` type.
    static func seconds(_ value: Double) -> TimeInterval {
        return value
    }

    /// - Returns: The value in milliseconds using the `TimeInterval` type.
    static func milliseconds(_ value: Double) -> TimeInterval {
        return seconds(value) / millisecondsPerSecond
    }
    
    // MARK: Suffix properties
    
    var days: Double {
        return self.hours / Self.hoursPerDay
    }
    
    var hours: Double {
        return self.minutes / Self.minutesPerHour
    }
    
    var minutes: Double {
        return self.seconds / Self.secondsPerMinute
    }
    
    var seconds: Double {
        return self
    }
    
    var milliseconds: Double {
        return self.seconds * Self.millisecondsPerSecond
    }
}
