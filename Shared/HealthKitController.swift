//
//  HealthKitController.swift
//  Runic
//
//  Created by Travis Luckenbaugh on 3/1/21.
//

import Foundation
#if !os(macOS)
import HealthKit
#endif



enum HealthKitControllerState {
    case none
    case waiting(busy: HealthKitControllerBusy)
    case failed(error: HealthKitControllerError)
    case ready
}

enum HealthKitControllerBusy: Int {
    case isFound = 404
    case supportsMethod = 405
}

enum HealthKitControllerError: Int {
    case notFound = 404
    case supportsMethod = 405
}

class HealthKitController: ObservableObject {
    let toShare: Set<HKSampleType> = []
    let toRead: Set<HKSampleType> = [HKObjectType.workoutType()]
    @Published var state: HealthKitControllerState = .none
    @Published var error: Error?
    
    func onReady(execute: () -> Void) {
        switch state {
        case .none:
            state = .waiting(busy: .isFound)
            onReady(execute: execute)
        case .waiting(let busy):
            switch busy {
            case .isFound:
                state = HKHealthStore.isHealthDataAvailable() ? .waiting(busy: .supportsMethod) : .failed(error: .notFound)
                onReady(execute: execute)
            case .supportsMethod:
                HKHealthStore().requestAuthorization(toShare: toShare, read: toRead) { (success, error) in
                    DispatchQueue.main.async {
                        if success {
                            self.state = .ready
                        } else if let error = error {
                            self.error = error
                            self.state = .failed(error: .supportsMethod)
                        }
                    }
                }
            }
        case .failed:
            return
        case .ready:
            execute()
            return
        }
        
    }
    
    func checkAccess() {
        onReady {
            // Wait for it
        }
    }
}
