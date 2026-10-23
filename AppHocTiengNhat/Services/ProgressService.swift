//
//  ProgressService.swift
//  AppHocTiengNhat
//

import Foundation

public final class ProgressService {
    public static let shared = ProgressService()
    
    private let defaults = UserDefaults.standard
    private let masteredKey = "AppHocTiengNhat_MasteredIds"
    private let lastStudyDateKey = "AppHocTiengNhat_LastStudyDate"
    private let streakKey = "AppHocTiengNhat_StreakDays"
    private let quizTotalCorrectKey = "AppHocTiengNhat_QuizTotalCorrect"
    private let quizTotalAnsweredKey = "AppHocTiengNhat_QuizTotalAnswered"
    
    private init() {
        checkAndUpdateStreak()
    }
    
    // MARK: - Quản lý thẻ đã thuộc
    public func isMastered(id: String) -> Bool {
        let set = Set(defaults.stringArray(forKey: masteredKey) ?? [])
        return set.contains(id)
    }
    
    public func toggleMastered(id: String) -> Bool {
        var set = Set(defaults.stringArray(forKey: masteredKey) ?? [])
        let newState: Bool
        if set.contains(id) {
            set.remove(id)
            newState = false
        } else {
            set.insert(id)
            newState = true
        }
        defaults.set(Array(set), forKey: masteredKey)
        recordStudyActivity()
        return newState
    }
    
    public func getMasteredCount(prefix: String? = nil) -> Int {
        let list = defaults.stringArray(forKey: masteredKey) ?? []
        if let prefix = prefix {
            return list.filter { $0.hasPrefix(prefix) }.count
        }
        return list.count
    }
    
    // MARK: - Kết quả luyện nghe (Quiz Score)
    public func recordQuizResult(correct: Int, total: Int) {
        let currentCorrect = defaults.integer(forKey: quizTotalCorrectKey)
        let currentTotal = defaults.integer(forKey: quizTotalAnsweredKey)
        defaults.set(currentCorrect + correct, forKey: quizTotalCorrectKey)
        defaults.set(currentTotal + total, forKey: quizTotalAnsweredKey)
        recordStudyActivity()
    }
    
    public func getQuizAccuracyPercentage() -> Int {
        let total = defaults.integer(forKey: quizTotalAnsweredKey)
        guard total > 0 else { return 0 }
        let correct = defaults.integer(forKey: quizTotalCorrectKey)
        return Int((Double(correct) / Double(total)) * 100)
    }
    
    // MARK: - Chuỗi ngày học liên tục (Streak)
    public func getStreak() -> Int {
        return max(1, defaults.integer(forKey: streakKey))
    }
    
    private func recordStudyActivity() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastDate = defaults.object(forKey: lastStudyDateKey) as? Date {
            let lastDay = calendar.startOfDay(for: lastDate)
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            
            if diff == 1 {
                let currentStreak = defaults.integer(forKey: streakKey)
                defaults.set(currentStreak + 1, forKey: streakKey)
            } else if diff > 1 {
                defaults.set(1, forKey: streakKey)
            }
        } else {
            defaults.set(1, forKey: streakKey)
        }
        defaults.set(Date(), forKey: lastStudyDateKey)
    }
    
    private func checkAndUpdateStreak() {
        if let lastDate = defaults.object(forKey: lastStudyDateKey) as? Date {
            let calendar = Calendar.current
            let lastDay = calendar.startOfDay(for: lastDate)
            let today = calendar.startOfDay(for: Date())
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if diff > 1 {
                defaults.set(1, forKey: streakKey)
            }
        }
    }
}
