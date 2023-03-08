//
//  DataModel.swift
//  Elevator
//
//  Created by Aashish Bansal on 28/02/23.
//

import Foundation
import SwiftUI

// We need a class to hold the data.

class DataModel: ObservableObject{
    /**
       The @State Property is used to pass properties to the Vie to display the data to the user. This was limited because the @State Property Wrapper can store the values of the States that control a Single View. We cannot pass them around to another struct as they work they in only one struct.
       We also use the @Binding to re-establish the connection to other Views or structs with a bi-directional link which could not be done with the @State Property. This will not work globally to pass the data to the Application.
       This problem can be solved with the help of ObservableObject as:
        1. The @StateObject listens for changes in an ObservableObject and receives the new values.
        2. The @ObservedObject listens for changes in the @StateObject property and receives those new values.
        3. The @Published reports all the changes to the system and publishes those changes to the views.
       Using this, we can update more than one view with the changes.
     */
    @Published var doorsOpened = false
    @Published var floor1 = false
    @Published var floor2 = false
    @Published var goingUp = false
    
    @Published var doorOpenTimer: Timer? = nil
    @Published var chimesTimer: Timer? = nil
    @Published var doorSoundTimer: Timer? = nil
    
    /** These properties will be accessed by creating an instance of DataModel in other Views.*/
    
    // Now, we will create functions to trigger the timings for the doors, lights, sounds, etc.
    
    // MARK: - DOOR OPEN TIMER
    func openDoors(){
        /** This function sets the doorOpenTimer Object value to the value specified by the scheduleTimer with the interval method. The scheduleTimer will execute the block of code within after that certain amount of time has passed (in this case 8 seconds).
            We want the buttons to be triggered when we press the button for the doors to open and not every 8 seconds.
         */
        doorOpenTimer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { _ in
            self.doorsOpened.toggle()
        })
    }
    
    // MARK: - CHIM SOUND EFFECT SIGNIFYING ELEVATOR HAS REACHED ITS DESTINATION
    func playChimeSound(){
        chimesTimer = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false){ _ in
            playSound(sound: "elevatorChime", type: "m4a")
            /** The playSound() function is present in a new Swift File named PlaySound.swift */
        }
    }
    
    // MARK: - PLAY DOOR OPEN-CLOSE SOUND
    func playDoorOpenCloseSound(interval: Double){
        doorSoundTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in
            playSound(sound: "doorsOpenClose", type: "m4a")
        })
    }
    
    // MARK: - FLOOR LIGHT INDICATOR
    func floorNumbers(){
        /// Light up floor 1 as soon as the button is pressed, making sure floor 2 is not lit first
        if !floor2{
            floor1.toggle()
        } // end of it condition for "if not floor 1"
        
        /// check if the doors are opened, if not, open the doors and play the chime sound
        if !doorsOpened{
            openDoors()
            playChimeSound()
            
            /// going up - wait 4 seconds and turn on the floor 2 light, and turn off the floor 1 light
            if goingUp{
                withAnimation(Animation.default.delay(4.0)){
                    floor2 = true
                    floor1 = false
                }
                
                /// once at the top, and the button is pressed again to go down, wait five seconds then turn off the floor 2 light and turn on the floor 1 light
                withAnimation(Animation.default.delay(5.0)){
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
            } // end of if condition for "if going up"
            /// if not goingUp, keep the floor 2 light on for 5 seconds until the elevator doors close, and then turn it off and turn on the floor 1 lights, and play the chimes and door sound files.
            else if !goingUp{
                withAnimation(Animation.default.delay(5.0)){
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
                withAnimation(Animation.default.delay(5.0)){
                    floor2 = true
                    floor1 = false
                }
            }// end of if condition for "if not going up"
        } // end of if condition for "if doors not opened"
        
    } // end of function floorNumbers()
    
    func stopTimer(){
        doorOpenTimer?.invalidate()
        doorOpenTimer = nil
        chimesTimer?.invalidate()
        chimesTimer = nil
        doorSoundTimer?.invalidate()
        doorSoundTimer = nil
        
        /// The invalidate() function stops the Timer from ever starting again and requests the removal from the RunLoop.
        /// This method will be called at the beginning of the elevator application, so that any on going Timers from before could be stopped.
    } // end of function stopTimer()
}
