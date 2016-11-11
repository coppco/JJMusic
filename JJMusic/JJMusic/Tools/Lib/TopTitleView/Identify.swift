//
//  Identify.swift
//  TypeManger
//
//  Created by coco on 16/11/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import CoreGraphics
public protocol Identify {
    //identify 标示符
    var identify_string: String {get}
}

// MARK: - 判断标示符是否相等
extension Identify {
    func equal(to other: Identify) -> Bool {
        return self.identify_string == other.identify_string && type(of: self) == type(of: other)
    }
}
/*
 Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64, Double, Float, CGFloat, String, NSString, NSNumber
 */
// MARK: - Extension
extension Int: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Int8: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Int16: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Int32: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Int64: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension UInt: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension UInt8: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension UInt16: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension UInt32: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension UInt64: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Double: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension Float: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension CGFloat: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension String: Identify {
    public var identify_string: String {
        return self
    }
}

extension NSString: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}

extension NSNumber: Identify {
    public var identify_string: String {
        return "\(self)"
    }
}
