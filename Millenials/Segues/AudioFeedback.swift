//
//  AudioFeedback.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import AVFoundation
import UIKit

public class AudioFeedback {
    
    init() { self.soundEnabled = true }
    
    static let shared = AudioFeedback()
    
    private var audioPlayer: AVAudioPlayer?
    
    var soundEnabled: Bool {
        
        didSet { }
        
    }
    
    func sucessFeedback() {
        
        guard (soundEnabled) else { return }
        
        guard let successSoundLocation = Bundle.main.url(forResource: "correct", withExtension: "mp3") else { return print("error") }
        
        audioPlayerWith(successSoundLocation)
        
        audioPlayer?.play()
        
    }
    
    func errorFeedback() {
        
        guard (soundEnabled) else { return }
        
        guard let errorSoundLocation = Bundle.main.url(forResource: "wrong", withExtension: "mp3") else { return print("error") }
        
        audioPlayerWith(errorSoundLocation)
        
        audioPlayer?.play()
        
    }
    
    func playWarningSound() {
        
        guard (soundEnabled) else { return }
        
        guard let warningSoundLocation = Bundle.main.url(forResource: "", withExtension: "") else { return }
        
        audioPlayerWith(warningSoundLocation)
        
        audioPlayer?.play()
        
    }
    
    func noAnswerFeedback() {
        
        guard (soundEnabled) else { return }
        
        guard let noAnswerSoundLocation = Bundle.main.url(forResource: "noAnswer", withExtension: "mp3") else { return }
        
        audioPlayerWith(noAnswerSoundLocation)
        
        audioPlayer?.play()
        
    }
    
    private func audioPlayerWith(_ file: URL) {
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: file, fileTypeHint: AVFileType.mp3.rawValue)
            
        } catch let error { print(error.localizedDescription) }
        
    }
    
}
