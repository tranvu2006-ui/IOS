//
//  KanjiCharacter.swift
//  AppHocTiengNhat
//

import Foundation

public struct KanjiExample: Codable {
    public let word: String        // Ví dụ: "日本"
    public let reading: String     // Ví dụ: "にほん (nihon)"
    public let meaning: String     // Ví dụ: "Nước Nhật"
    
    public init(word: String, reading: String, meaning: String) {
        self.word = word
        self.reading = reading
        self.meaning = meaning
    }
}

public struct KanjiCharacter: Identifiable, Codable {
    public let id: String
    public let kanji: String           // e.g. "日"
    public let hanViet: String         // e.g. "NHẬT"
    public let onyomi: String          // e.g. "ニチ, ジツ"
    public let kunyomi: String         // e.g. "ひ, -び, -か"
    public let meaningVi: String       // e.g. "Ngày, Mặt trời"
    public let strokeCount: Int        // e.g. 4
    public let examples: [KanjiExample]
    
    public init(
        kanji: String,
        hanViet: String,
        onyomi: String,
        kunyomi: String,
        meaningVi: String,
        strokeCount: Int,
        examples: [KanjiExample]
    ) {
        self.id = "kanji_\(kanji)"
        self.kanji = kanji
        self.hanViet = hanViet
        self.onyomi = onyomi
        self.kunyomi = kunyomi
        self.meaningVi = meaningVi
        self.strokeCount = strokeCount
        self.examples = examples
    }
}
