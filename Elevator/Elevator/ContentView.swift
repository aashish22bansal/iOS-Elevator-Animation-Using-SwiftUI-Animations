//
//  ContentView.swift
//  Elevator
//
//  Created by Aashish Bansal on 28/02/23.
//
/**
 We will create a Data Model using ObsevableObject Protocol and we will be passing it to our View as needed. And the Data Model is also separate from the Application's User Interface in which we will create our Views. This creates Modularity and Testability. The code for this is stored in the DataModel.swift File.
 We will create and assemble the elevator in a separate SwiftUI File named ElevatorAndPeopleView.swift.
 */

import SwiftUI

struct ContentView: View {
    
    // Creating an @ObservedObject for the ContentView() to take values.
    @ObservedObject var appData: DataModel // Instance of DataModel class
    
    let backgroundColor = Color(.black)
    
    var body: some View {
        ZStack{ // Level 1
            // MARK: - SETTING THE BACKGROUND COLOR
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            // MARK: - ADDING PEOPLE IN THE ELEVATOR
            ElevatorAndPeopleView(doorsOpened: $appData.doorsOpened)
            
            // MARK: - BUTTON TO TOGGLE() OPENING AND CLOSING OF DOORS
            GeometryReader{ geo in // Level 2
                Button(action: {
                    // MARK: - MAKEING THE ELEVATOR WORK
                    appData.stopTimer()
                    appData.playDoorOpenCloseSound(interval: 0.5)
                    appData.doorsOpened.toggle()
                    appData.goingUp.toggle()
                    appData.floorNumbers()
                }){
                    /// if the doors are opened, make the button white, otherwise make it black
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(appData.doorsOpened ? .white:.black)
                        .overlay(Circle().stroke(Color.red, lineWidth: 1))
                        .padding(5)
                        .background(Color.black)
                        .cornerRadius(30)
                } // end of Elevator Button Level 3
                .position(x: (geo.size.width/33), y: (geo.size.height/2))
                
                // MARK: - ADDING THE FLOOR NUMBER LIGHTS
                HStack{ // Level 3
                    Image(systemName: "1.circle")
                        .foregroundColor(appData.floor1 ? .red:.black)
                        .opacity(appData.floor1 ? 1:0.3)
                    Image(systemName: "2.circle")
                        .foregroundColor(appData.floor2 ? .red:.black)
                        .opacity(appData.floor2 ? 1:0.3)
                } // end of HStack for Floor Number Lights Level 3
                .position(x: (geo.size.width/2), y: (geo.size.height*0.02)+2)
            } // end of GeometryReader for Opening and Closing of Doors - Level 2
        } // end of ZStack Level 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appData: DataModel())
    }
}
