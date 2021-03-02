//
//  Runes.swift
//  Runic
//
//  Created by Travis Luckenbaugh on 3/1/21.
//

import SwiftUI

func runeColor(for state: HealthKitControllerState) -> Color {
    switch state {
    case .none: return .gray
    case .waiting: return .yellow
    case .failed: return .red
    case .ready: return .green
    }
}

struct Runes: View {
    @StateObject var ctl = HealthKitController()
    
    var body: some View {
        Button("<3", action: {
            ctl.checkAccess()
        })
        .padding(8.0)
        .background(runeColor(for: self.ctl.state))
        .cornerRadius(3.0)
    }
}

struct Runes_Previews: PreviewProvider {
    static var previews: some View {
        Runes()
    }
}
