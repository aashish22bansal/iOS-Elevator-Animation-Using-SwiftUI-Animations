//
//  PlaySound.swift
//  Elevator
//
//  Created by Aashish Bansal on 28/02/23.
//

import Foundation
import AVFoundation

// Creating an Audio Player
var audioPlayer: AVAudioPlayer?

// Function to look for the Sound File in the Application Bundle
func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        // Handling Exception
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }
        catch{
            print("ERROR: Could not find and play the sound file!")
        }
    } // end of if condition for file path
}
