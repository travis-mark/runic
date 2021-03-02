//
//  FakeHealthKit.swift
//  Runic
//
//  Created by Travis Luckenbaugh on 3/1/21.
//  Let's define a bunch of stub classes to let this compile on macOS
//  FFS, Apple.

import Foundation

#if os(macOS)
open class HKObjectType : NSObject {
    open class func workoutType() -> HKWorkoutType {
        return HKWorkoutType()
    }
}
open class HKSampleType : HKObjectType {}
open class HKWorkoutType : HKSampleType {}
open class HKHealthStore : NSObject {
    open class func isHealthDataAvailable() -> Bool {
        return false
    }
    open func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {}
}
#endif
