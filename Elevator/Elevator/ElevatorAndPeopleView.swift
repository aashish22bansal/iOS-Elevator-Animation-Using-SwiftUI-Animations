//
//  ElevatorAndPeopleView.swift
//  Elevator
//
//  Created by Aashish Bansal on 01/03/23.
//

import SwiftUI

struct ElevatorAndPeopleView: View {
    /** Here, we just need one Binding variale so that we can use this in the ContentView*/
    @Binding var doorsOpened: Bool
    /** This Binding Variable will need to be updated in the Preview.*/
    
    var body: some View {
        // Creating the Elevator
        ZStack{ // Level 1
            GeometryReader{ geo in // Level 2 - Elevator Inside
                // MARK: - INSIDE ELEVATOR SCENE
                Image("inside")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                
                // MARK: - ADDING THE PEOPLE
                Image("man")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: geo.size.width - 200, maxHeight: geo.size.height - 300)
                    .shadow(color: .black, radius: 30, x: 5, y: 5)
                    .offset(x: 0, y: 250)
                Image("man2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height - 290)
                    .shadow(color: .black, radius: 30, x: 5, y: 5)
                    .offset(x: 40, y: 230)
                    .rotation3DEffect(Angle(degrees: 20), axis: (x: 0, y: -1, z: 0))
                Image("man3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: geo.size.width - 100, maxHeight: geo.size.height - 250)
                    .shadow(color: .black, radius: 30, x: 5, y: 5)
                    .offset(x: 130, y: 255)
                
                Image("man4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: geo.size.width - 0, maxHeight: geo.size.height - 280)
                    .shadow(color: .black, radius: 30, x: 5, y: 5)
                    .offset(x: -80, y: 265)
                
                // MARK: - ADDING THE ELEVATOR DOORS
                HStack{ // Level 3
                    // MARK: - LEFT DOOR
                    Image("leftDoor")
                        .resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpened ? -geo.size.width/2:4)
                    
                    // MARK: - RIGHT DOOR
                    Image("rightDoor")
                        .resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpened ? geo.size.width/2:-4)
                } // end of HStack Level 3
                
                // MARK: - CREATING THE OUTER FRAME FOR BUTTON
                Image("doorFrame")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
            } // end of GeometryReader Level 2 - Elevator Inside
            .animation(Animation.easeInOut.speed(0.09).delay(0.3), value: doorsOpened)
            
        } // end of ZStack Level 1 - Creating the Elevator
        
    }
}

struct ElevatorAndPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorAndPeopleView(doorsOpened: .constant(false))
    }
}
