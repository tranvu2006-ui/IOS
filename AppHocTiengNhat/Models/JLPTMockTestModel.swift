//
//  JLPTMockTestModel.swift
//  AppHocTiengNhat
//

import Foundation

public enum JLPTLevel: String, Codable, CaseIterable {
    case n5 = "N5"
    case n4 = "N4"
    
    public var title: String {
        switch self {
        case .n5: return "JLPT N5 (Sơ cấp 1)"
        case .n4: return "JLPT N4 (Sơ cấp 2)"
        }
    }
    
    public var passingTotalScore: Int {
        switch self {
        case .n5: return 80   // N5: 80 / 180 điểm
        case .n4: return 90   // N4: 90 / 180 điểm
        }
    }
}

public enum JLPTSection: String, Codable, CaseIterable {
    case vocabKanji = "vocab_kanji"
    case grammar = "grammar"
    case listening = "listening"
    
    public var titleVi: String {
        switch self {
        case .vocabKanji: return "Chữ Hán - Từ vựng"
        case .grammar: return "Ngữ pháp"
        case .listening: return "Luyện nghe hiểu"
        }
    }
    
    public var titleJp: String {
        switch self {
        case .vocabKanji: return "文字・語彙"
        case .grammar: return "文法"
        case .listening: return "聴解"
        }
    }
}

public struct JLPTQuestion: Identifiable {
    public let id: String
    public let section: JLPTSection
    public let prompt: String
    public let contentJp: String
    public let audioText: String?
    public let options: [String]
    public let correctIndex: Int
    public let explanation: String
    public let relatedWordId: String?

    public init(
        id: String,
        section: JLPTSection,
        prompt: String,
        contentJp: String,
        audioText: String? = nil,
        options: [String],
        correctIndex: Int,
        explanation: String,
        relatedWordId: String? = nil
    ) {
        self.id = id
        self.section = section
        self.prompt = prompt
        self.contentJp = contentJp
        self.audioText = audioText
        self.options = options
        self.correctIndex = correctIndex
        self.explanation = explanation
        self.relatedWordId = relatedWordId
    }
}

public struct JLPTSectionScore {
    public let section: JLPTSection
    public let correctCount: Int
    public let totalCount: Int
    public let scoreOnScale60: Int
    public let isPassing: Bool
}

public struct JLPTTestResult {
    public let level: JLPTLevel
    public let totalScore: Int       // Thang 180 điểm chuẩn JLPT
    public let isPassed: Bool
    public let sectionScores: [JLPTSectionScore]
    public let timeSpentSeconds: Int
    public let wrongQuestions: [(question: JLPTQuestion, userChoiceIndex: Int?)]
}
