//
//  AudioService.swift
//  AppHocTiengNhat
//

import Foundation
import AVFoundation
import UIKit

public final class AudioService: NSObject {
    public static let shared = AudioService()
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var feedbackGenerator = UINotificationFeedbackGenerator()
    
    private override init() {
        super.init()
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    /// Phát âm tiếng Nhật chuẩn
    public func speak(text: String, rate: Float = 0.45) {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = rate
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        speechSynthesizer.speak(utterance)
    }
    
    /// Rung xúc giác khi chọn đúng
    public func playCorrectFeedback() {
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(.success)
    }
    
    /// Rung xúc giác khi chọn sai
    public func playWrongFeedback() {
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(.error)
    }
}
