//
//  GrammarModel.swift
//  AppHocTiengNhat
//

import Foundation

/// Phân loại dạng bài tập trắc nghiệm ngữ pháp
public enum GrammarQuizType: String, Codable, CaseIterable {
    case particleFill = "Điền trợ từ & Chia thể"
    case sentenceMatch = "Nối câu & Hoàn thành câu"
}

/// Một mẫu ngữ pháp chuẩn Minna no Nihongo N5
public struct GrammarPoint: Identifiable, Codable {
    public let id: String
    public let lessonNumber: Int
    public let title: String
    public let structure: String
    public let meaning: String
    public let explanation: String
    public let exampleJp: String
    public let exampleReading: String
    public let exampleVi: String

    public init(
        lessonNumber: Int,
        index: Int,
        title: String,
        structure: String,
        meaning: String,
        explanation: String,
        exampleJp: String,
        exampleReading: String,
        exampleVi: String
    ) {
        self.id = "grammar_b\(lessonNumber)_\(index)"
        self.lessonNumber = lessonNumber
        self.title = title
        self.structure = structure
        self.meaning = meaning
        self.explanation = explanation
        self.exampleJp = exampleJp
        self.exampleReading = exampleReading
        self.exampleVi = exampleVi
    }
}

/// Câu hỏi trắc nghiệm ngữ pháp (Điền trợ từ/Chia thể hoặc Nối câu)
public struct GrammarQuizQuestion: Identifiable, Codable {
    public let id: String
    public let lessonNumber: Int
    public let quizType: GrammarQuizType
    public let promptJp: String
    public let promptVi: String
    public let correctAnswer: String
    public let options: [String]
    public let explanation: String
    public let fullSentenceJp: String

    public init(
        lessonNumber: Int,
        index: Int,
        quizType: GrammarQuizType,
        promptJp: String,
        promptVi: String,
        correctAnswer: String,
        options: [String],
        explanation: String,
        fullSentenceJp: String
    ) {
        self.id = "gquiz_b\(lessonNumber)_\(index)"
        self.lessonNumber = lessonNumber
        self.quizType = quizType
        self.promptJp = promptJp
        self.promptVi = promptVi
        self.correctAnswer = correctAnswer
        self.options = options
        self.explanation = explanation
        self.fullSentenceJp = fullSentenceJp
    }
}

/// Một bài học ngữ pháp trong giáo trình 50 bài Minna no Nihongo I & II (N5 & N4)
public struct GrammarLesson: Identifiable, Codable {
    public let id: String
    public let lessonNumber: Int
    public let title: String
    public let summary: String
    public let groupTag: String
    public let points: [GrammarPoint]
    public let quizzes: [GrammarQuizQuestion]

    public var jlptLevel: String {
        return lessonNumber <= 25 ? "N5" : "N4"
    }

    public init(
        lessonNumber: Int,
        title: String,
        summary: String,
        groupTag: String,
        points: [GrammarPoint],
        quizzes: [GrammarQuizQuestion]
    ) {
        self.id = "lesson_\(lessonNumber)"
        self.lessonNumber = lessonNumber
        self.title = title
        self.summary = summary
        self.groupTag = groupTag
        self.points = points
        self.quizzes = quizzes
    }
}
