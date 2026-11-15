//
//  ProgressService.swift
//  AppHocTiengNhat
//

import Foundation

public final class ProgressService {
    public static let shared = ProgressService()
    
    private let defaults: UserDefaults
    private let masteredKey = "AppHocTiengNhat_MasteredIds"
    private let needReviewKey = "AppHocTiengNhat_NeedReviewWordIds"
    private let lastStudyDateKey = "AppHocTiengNhat_LastStudyDate"
    private let streakKey = "AppHocTiengNhat_StreakDays"
    private let quizTotalCorrectKey = "AppHocTiengNhat_QuizTotalCorrect"
    private let quizTotalAnsweredKey = "AppHocTiengNhat_QuizTotalAnswered"
    private let lastGrammarScoreKey = "AppHocTiengNhat_LastGrammarScore"
    private let lastVocabScoreKey = "AppHocTiengNhat_LastVocabScore"

    private let calendar: Calendar
    private let now: () -> Date

    public init(defaults: UserDefaults = .standard, calendar: Calendar = .current, now: @escaping () -> Date = Date.init) {
        self.defaults = defaults
        self.calendar = calendar
        self.now = now
        checkAndUpdateStreak()
    }
    
    // MARK: - Quản lý thẻ đã thuộc (Mastered)
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
            // Khi đã thuộc thì tự động gỡ khỏi danh sách chưa nhớ
            unmarkWordForReview(id: id)
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
    
    public func getMasteredWords() -> [VocabWord] {
        let ids = Set(defaults.stringArray(forKey: masteredKey) ?? [])
        guard !ids.isEmpty else { return [] }
        return VocabRepository.shared.vocabList.filter { ids.contains($0.id) }
    }
    
    public func unmarkMastered(id: String) {
        var set = Set(defaults.stringArray(forKey: masteredKey) ?? [])
        set.remove(id)
        defaults.set(Array(set), forKey: masteredKey)
        recordStudyActivity()
    }
    
    // MARK: - Danh sách từ chưa nhớ, chưa thuộc (Need Review)
    public func isWordInReview(id: String) -> Bool {
        let set = Set(defaults.stringArray(forKey: needReviewKey) ?? [])
        return set.contains(id)
    }
    
    public func markWordForReview(id: String) {
        var set = Set(defaults.stringArray(forKey: needReviewKey) ?? [])
        set.insert(id)
        defaults.set(Array(set), forKey: needReviewKey)
    }
    
    public func unmarkWordForReview(id: String) {
        var set = Set(defaults.stringArray(forKey: needReviewKey) ?? [])
        set.remove(id)
        defaults.set(Array(set), forKey: needReviewKey)
    }
    
    public func toggleNeedReview(id: String) -> Bool {
        var set = Set(defaults.stringArray(forKey: needReviewKey) ?? [])
        let newState: Bool
        if set.contains(id) {
            set.remove(id)
            newState = false
        } else {
            set.insert(id)
            newState = true
        }
        defaults.set(Array(set), forKey: needReviewKey)
        recordStudyActivity()
        return newState
    }
    
    public func getNeedReviewCount() -> Int {
        return (defaults.stringArray(forKey: needReviewKey) ?? []).count
    }
    
    public func getNeedReviewWords() -> [VocabWord] {
        let ids = Set(defaults.stringArray(forKey: needReviewKey) ?? [])
        guard !ids.isEmpty else { return [] }
        return VocabRepository.shared.vocabList.filter { ids.contains($0.id) }
    }
    
    // MARK: - Kết quả luyện tập & Điểm thi
    public func recordQuizResult(correct: Int, total: Int) {
        let currentCorrect = defaults.integer(forKey: quizTotalCorrectKey)
        let currentTotal = defaults.integer(forKey: quizTotalAnsweredKey)
        defaults.set(currentCorrect + correct, forKey: quizTotalCorrectKey)
        defaults.set(currentTotal + total, forKey: quizTotalAnsweredKey)
        recordStudyActivity()
    }
    
    public func recordGrammarTestScore(score: Int) {
        defaults.set(score, forKey: lastGrammarScoreKey)
        recordStudyActivity()
    }
    
    public func getLastGrammarScore() -> Int? {
        if defaults.object(forKey: lastGrammarScoreKey) != nil {
            return defaults.integer(forKey: lastGrammarScoreKey)
        }
        return nil
    }
    
    public func recordVocabTestScore(score: Int) {
        defaults.set(score, forKey: lastVocabScoreKey)
        recordStudyActivity()
    }
    
    public func getLastVocabScore() -> Int? {
        if defaults.object(forKey: lastVocabScoreKey) != nil {
            return defaults.integer(forKey: lastVocabScoreKey)
        }
        return nil
    }
    
    public func getQuizAccuracyPercentage() -> Int {
        let total = defaults.integer(forKey: quizTotalAnsweredKey)
        guard total > 0 else { return 0 }
        let correct = defaults.integer(forKey: quizTotalCorrectKey)
        return Int((Double(correct) / Double(total)) * 100)
    }
    
    // MARK: - Chuỗi ngày học liên tục (Streak)
    public func getStreak() -> Int {
        if let lastDate = defaults.object(forKey: lastStudyDateKey) as? Date {
            let lastDay = calendar.startOfDay(for: lastDate)
            let today = calendar.startOfDay(for: now())
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if diff > 1 {
                defaults.set(0, forKey: streakKey)
                return 0
            }
        }
        return max(0, defaults.integer(forKey: streakKey))
    }
    
    private func recordStudyActivity() {
        let currentDate = now()
        let today = calendar.startOfDay(for: currentDate)
        
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
        defaults.set(currentDate, forKey: lastStudyDateKey)
    }
    
    private func checkAndUpdateStreak() {
        if let lastDate = defaults.object(forKey: lastStudyDateKey) as? Date {
            let lastDay = calendar.startOfDay(for: lastDate)
            let today = calendar.startOfDay(for: now())
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if diff > 1 {
                defaults.set(0, forKey: streakKey)
            }
        }
    }
}
