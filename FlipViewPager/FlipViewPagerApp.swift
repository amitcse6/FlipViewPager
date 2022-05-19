//
//  FlipViewPagerApp.swift
//  FlipViewPager
//
//  Created by AMIT on 5/19/22.
//

import SwiftUI

@main
struct FlipViewPagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
