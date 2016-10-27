//
//  Date+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
let SQLDataFormatter = "yyyy-MM-dd HH:mm:ss"
extension Date {
    /// 日期组件
    var dateComponents: DateComponents {
        return Calendar.current.dateComponents([.calendar, .day, .era, .hour, .minute, .month, .nanosecond, .quarter, .second, .timeZone, .weekday, .weekdayOrdinal, .weekOfMonth, .weekOfYear, .year, .yearForWeekOfYear], from: self)
    }
    
    /// 年
    var year: Int {
        return self.dateComponents.day!
    }
    
    /// 月
    var month: Int {
        return self.dateComponents.month!
    }
    
    /// 日
    var day: Int {
        return self.dateComponents.day!
    }
    
    /// 时
    var hour: Int {
        return self.dateComponents.hour!
    }
    
    /// 分
    var minute: Int {
        return self.dateComponents.minute!
    }
    
    /// 秒
    var second: Int {
        return self.dateComponents.second!
    }
    
    /// 纳秒
    var nanosecond: Int {
        return self.dateComponents.nanosecond!
    }
    
    /// 周
    var weekDay: Int {
        return self.dateComponents.weekday!
    }
    
    var weekdayOrdinal: Int {
        return self.dateComponents.weekdayOrdinal!
    }
    
    var weekOfMonth: Int {
        return self.dateComponents.weekOfMonth!
    }
    
    var weekOfYear: Int {
        return self.dateComponents.weekOfYear!
    }
    
    /// 季度
    var quarter: Int {
        return self.dateComponents.quarter!
    }
    
    var yearForWeekOfYear: Int {
        return self.dateComponents.yearForWeekOfYear!
    }
    
    /// 是否闰月
    var isLeapMonth: Bool {
        return self.dateComponents.isLeapMonth!
    }
    
    /// 是否闰年
    var isLeapYear: Bool {
        return (year % 400  == 0) || ((year % 4 == 0 ) && (year % 100 != 0))
    }
    
    /// 是否今天
    var isToday: Bool {
        if fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24 {
            return false
        }
        return Date().day == self.day
    }
    
    /// 当前时间的10位时间戳
    ///
    /// - returns: 返回一个10位时间戳
    static func currentTenTimeSamp() -> String {
        return String(format: "%.0f", Date().timeIntervalSince1970)
    }
    
    /// 当前时间的13位时间戳
    ///
    /// - returns: 返回一个13位时间戳
    static func currentThirteenTimeSamp() -> String {
        return String(format: "%.0f", Date().timeIntervalSince1970 * 1000)
    }
    
    /// 10位时间戳
    ///
    /// - returns: 返回一个10位时间戳
    func tenTimeSamp() -> String {
        return String(format: "%.0f", self.timeIntervalSince1970)
    }
    /// 13位时间戳
    ///
    /// - returns: 返回一个13位时间戳
    func thirdteenTimeSamp() -> String {
        return String(format: "%.0f", self.timeIntervalSince1970 * 1000)
    }
    
    /// 增加减少年
    ///
    /// - parameter year: 增加减少的年
    ///
    /// - returns: 返回一个新的日期
    func dateByAddingYears(year: Int) -> Date? {
        var component = DateComponents()
        component.year = year
        return Calendar.current.date(byAdding: component, to: self)
    }
    
    /// 增加减少月
    ///
    /// - parameter month: 增加减少的月
    ///
    /// - returns: 返回新的日期
    func dateByAddingMonths(month: Int) -> Date? {
        var component = DateComponents()
        component.month = month
        return Calendar.current.date(byAdding: component, to: self)
    }
    
    /// 增加减少周
    ///
    /// - parameter month: 增加减少的月
    ///
    /// - returns: 返回新的日期
    func dateByAddingWeeks(week: Int) -> Date? {
        var component = DateComponents()
        component.weekOfYear = week
        return Calendar.current.date(byAdding: component, to: self)
    }
    
    /// 增加减少日
    ///
    /// - parameter month: 增加减少的日
    ///
    /// - returns: 返回新的日期
    func dateByAddingDays(day: Int) -> Date? {
        let time: TimeInterval = self.timeIntervalSince1970 + Double(day * 86400)
        return Date(timeIntervalSince1970: time)
    }
    
    /// 增加减少小时
    ///
    /// - parameter hour: 增加减少的小时
    ///
    /// - returns: 返回新的日期
    func dateByAddingHours(hour: Int) -> Date? {
        let time: TimeInterval = self.timeIntervalSince1970 + Double(hour * 60 * 60)
        return Date(timeIntervalSince1970: time)
    }
    
    /// 增加减少分钟
    ///
    /// - parameter minute: 增加减少的分钟
    ///
    /// - returns: 返回新的日期
    func dateByAddingMinutes(minute: Int) -> Date? {
        let time: TimeInterval = self.timeIntervalSince1970 + Double(minute * 60)
        return Date(timeIntervalSince1970: time)
    }
    
    /// 增加减少秒
    ///
    /// - parameter second: 增加减少的秒
    ///
    /// - returns: 返回新的日期
    func dateByAddingSeconds(second: Int) -> Date? {
        let time: TimeInterval = self.timeIntervalSince1970 + Double(second)
        return Date(timeIntervalSince1970: time)
    }
    
    /// 格式化日期--->字符串
    ///
    /// - parameter formatter: 格式
    ///
    /// - returns: 返回日期字符串
    func stringForDateWithFormatter(formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    
    /// 返回常用SQL数据库日期格式字符串 yyyy-MM-dd HH:mm:ss
    ///
    /// - returns: 返回字符串如:    2016-08-05 13:42:30
    func stringForDateWithSQLDataFormatter() -> String {
        return self.stringForDateWithFormatter(formatter: SQLDataFormatter)
    }
    
    /// 根据格式从字符串返回日期
    ///
    /// - parameter string:    日期字符串
    /// - parameter formatter: 格式
    ///
    /// - returns: 返回一个日期
    static func dateFromString(string: String, formatter: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: string)
    }
}
