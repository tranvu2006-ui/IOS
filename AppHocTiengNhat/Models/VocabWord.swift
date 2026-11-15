//
//  VocabWord.swift
//  AppHocTiengNhat
//

import Foundation

public struct VocabTopic: Identifiable, Codable {
    public let id: String
    public let title: String
    public let iconName: String
    public let detail: String
    
    public init(id: String, title: String, iconName: String, detail: String) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.detail = detail
    }
}

public struct VocabWord: Identifiable, Codable {
    public let id: String
    public let kanji: String?
    public let kana: String
    public let romaji: String
    public let meaningVi: String
    public let topicId: String
    public let lessonNumber: Int?
    public let grammarNote: String?
    public let exampleJp: String?
    public let exampleVi: String?
    
    public init(
        kanji: String?,
        kana: String,
        romaji: String,
        meaningVi: String,
        topicId: String,
        lessonNumber: Int? = nil,
        grammarNote: String? = nil,
        exampleJp: String? = nil,
        exampleVi: String? = nil
    ) {
        if let lessonNumber = lessonNumber {
            self.id = "vocab_b\(lessonNumber)_\(kana)_\(romaji)"
        } else {
            self.id = "vocab_\(topicId)_\(kana)"
        }
        self.kanji = kanji
        self.kana = kana
        self.romaji = romaji
        self.meaningVi = meaningVi
        self.topicId = topicId
        self.lessonNumber = lessonNumber
        self.grammarNote = grammarNote
        self.exampleJp = exampleJp
        self.exampleVi = exampleVi
    }
    
    public var displayText: String {
        if let kanji = kanji, !kanji.isEmpty {
            return kanji
        }
        return kana
    }
    
    public var speechText: String {
        return kana
    }
}

/// Một bài học từ vựng trong giáo trình 50 bài Minna no Nihongo (N5 & N4)
public struct VocabLesson: Identifiable, Codable {
    public let id: String
    public let lessonNumber: Int
    public let title: String
    public let subtitle: String
    public let partTag: String
    public let words: [VocabWord]
    
    public var jlptLevel: String {
        return lessonNumber <= 25 ? "N5" : "N4"
    }
    
    public init(
        lessonNumber: Int,
        title: String,
        subtitle: String,
        partTag: String,
        words: [VocabWord]
    ) {
        self.id = "vlesson_\(lessonNumber)"
        self.lessonNumber = lessonNumber
        self.title = title
        self.subtitle = subtitle
        self.partTag = partTag
        self.words = words
    }
}
