//
//  Runes.swift
//  Runic
//
//  Created by Travis Luckenbaugh on 3/1/21.
//

import SwiftUI

func runeForeground(for state: HealthKitControllerState) -> Color {
    return Color.white
}

func runeBackground(for state: HealthKitControllerState) -> Color {
    switch state {
    case .none: return .gray
    case .waiting: return .yellow
    case .failed: return .red
    case .ready: return .green
    }
}

struct RuneView: View {
    @StateObject var ctl = HealthKitController()
    
    var body: some View {
        Button("<3", action: {
            ctl.checkAccess()
        })
        .foregroundColor(runeForeground(for: self.ctl.state))
        .padding(8.0)
        .background(runeBackground(for: self.ctl.state))
        .cornerRadius(3.0)
    }
}

fileprivate let rlvColumn = GridItem(.flexible(), spacing: 20.0, alignment: .center)
fileprivate let rlvColumns = [rlvColumn, rlvColumn, rlvColumn, rlvColumn]
struct RuneListView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: rlvColumns, alignment: .center) {
                ForEach(0..<8) { index in
                    RuneView()
                }
            }
        }
    }
}

struct Runes_Previews: PreviewProvider {
    static var previews: some View {
        RuneListView()
    }
}
