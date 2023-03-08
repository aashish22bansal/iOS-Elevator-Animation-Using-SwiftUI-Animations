//
//  ElevatorApp.swift
//  Elevator
//
//  Created by Aashish Bansal on 28/02/23.
//

import SwiftUI

@main
struct ElevatorApp: App {
    
    // Creating an instance of the DataModel
    @StateObject private var appData = DataModel()
    
    var body: some Scene {
        WindowGroup {
            // Passing the instance of DataModel to the ContentView()
            ContentView(appData: appData) // This is where the View is created
        }
    }
}
