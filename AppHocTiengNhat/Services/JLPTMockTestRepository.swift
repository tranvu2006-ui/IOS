//
//  JLPTMockTestRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class JLPTMockTestRepository {
    public static let shared = JLPTMockTestRepository()
    
    private init() {}
    
    /// Sinh đề thi thử JLPT 25 câu chuẩn hóa cho cấp độ N5 hoặc N4
    public func generateMockTest(level: JLPTLevel) -> [JLPTQuestion] {
        var questions: [JLPTQuestion] = []
        let levelStr = level.rawValue
        
        // MARK: - Phần 1: Chữ Hán - Từ vựng (10 câu)
        let kanjiPool = KanjiRepository.shared.getKanji(for: levelStr).shuffled()
        let vocabLessons = VocabRepository.shared.getLessons(level: levelStr)
        var allVocabPool: [VocabWord] = []
        for lesson in vocabLessons {
            allVocabPool.append(contentsOf: lesson.words)
        }
        allVocabPool.shuffle()
        
        // 5 câu Kanji
        for i in 0..<min(5, kanjiPool.count) {
            let kanji = kanjiPool[i]
            let prompt = "Chọn cách đọc Hiragana đúng của chữ Hán:"
            let targetExample = kanji.examples.first ?? KanjiExample(word: kanji.kanji, reading: kanji.kunyomi, meaning: kanji.meaningVi)
            
            // Tìm 3 đáp án nhiễu từ các ví dụ khác
            var options: [String] = [targetExample.reading]
            for otherKanji in kanjiPool where otherKanji.kanji != kanji.kanji {
                if let ex = otherKanji.examples.first, !options.contains(ex.reading) {
                    options.append(ex.reading)
                }
                if options.count == 4 { break }
            }
            while options.count < 4 {
                options.append("\(kanji.kanji)_\(options.count)")
            }
            options.shuffle()
            let correctIdx = options.firstIndex(of: targetExample.reading) ?? 0
            
            let exp = "Chữ Hán【\(kanji.kanji)】âm Hán Việt là [\(kanji.hanViet)]. Trong từ「\(targetExample.word)」, cách đọc là: \(targetExample.reading) (nghĩa: \(targetExample.meaning))."
            
            questions.append(
                JLPTQuestion(
                    id: "mock_\(levelStr)_kanji_\(i+1)",
                    section: .vocabKanji,
                    prompt: prompt,
                    contentJp: targetExample.word,
                    audioText: targetExample.word,
                    options: options,
                    correctIndex: correctIdx,
                    explanation: exp,
                    relatedWordId: kanji.id
                )
            )
        }
        
        // 5 câu Từ vựng
        for i in 0..<min(5, allVocabPool.count) {
            let word = allVocabPool[i]
            let isJpToVi = (i % 2 == 0)
            
            if isJpToVi {
                let prompt = "Chọn nghĩa tiếng Việt chính xác của từ vựng:"
                var options: [String] = [word.meaningVi]
                for other in allVocabPool where other.id != word.id && !options.contains(other.meaningVi) {
                    options.append(other.meaningVi)
                    if options.count == 4 { break }
                }
                while options.count < 4 { options.append("Đáp án phụ \(options.count)") }
                options.shuffle()
                let correctIdx = options.firstIndex(of: word.meaningVi) ?? 0
                let exp = "Từ「\(word.displayText)」(\(word.kana)) có nghĩa là: \(word.meaningVi)." + (word.grammarNote.map { " Lưu ý: \($0)." } ?? "")
                
                questions.append(
                    JLPTQuestion(
                        id: "mock_\(levelStr)_vocab_\(i+1)",
                        section: .vocabKanji,
                        prompt: prompt,
                        contentJp: word.displayText,
                        audioText: word.speechText,
                        options: options,
                        correctIndex: correctIdx,
                        explanation: exp,
                        relatedWordId: word.id
                    )
                )
            } else {
                let prompt = "Chọn từ tiếng Nhật tương ứng với nghĩa:"
                var options: [String] = [word.displayText]
                for other in allVocabPool where other.id != word.id && !options.contains(other.displayText) {
                    options.append(other.displayText)
                    if options.count == 4 { break }
                }
                while options.count < 4 { options.append("の選択肢 \(options.count)") }
                options.shuffle()
                let correctIdx = options.firstIndex(of: word.displayText) ?? 0
                let exp = "Nghĩa: '\(word.meaningVi)' trong tiếng Nhật là「\(word.displayText)」(/\(word.romaji)/)."
                
                questions.append(
                    JLPTQuestion(
                        id: "mock_\(levelStr)_vocab_\(i+1)",
                        section: .vocabKanji,
                        prompt: prompt,
                        contentJp: word.meaningVi,
                        audioText: word.speechText,
                        options: options,
                        correctIndex: correctIdx,
                        explanation: exp,
                        relatedWordId: word.id
                    )
                )
            }
        }
        
        // MARK: - Phần 2: Ngữ pháp (10 câu)
        let grammarLessons = GrammarRepository.shared.getLessons(level: levelStr)
        var allGrammarQuizzes: [GrammarQuizQuestion] = []
        for lesson in grammarLessons {
            allGrammarQuizzes.append(contentsOf: lesson.quizzes)
        }
        allGrammarQuizzes.shuffle()
        
        for i in 0..<min(10, allGrammarQuizzes.count) {
            let q = allGrammarQuizzes[i]
            let prompt = q.quizType == .particleFill ? "Điền trợ từ hoặc thể chia đúng vào chỗ trống (___):" : "Nối câu / Hoàn thành mẫu câu phù hợp:"
            let correctIdx = q.options.firstIndex(of: q.correctAnswer) ?? 0
            
            questions.append(
                JLPTQuestion(
                    id: "mock_\(levelStr)_grammar_\(i+1)",
                    section: .grammar,
                    prompt: prompt,
                    contentJp: q.promptJp,
                    audioText: q.fullSentenceJp,
                    options: q.options,
                    correctIndex: correctIdx,
                    explanation: "Đáp án đúng:【\(q.correctAnswer)】.\nCâu hoàn chỉnh: \(q.fullSentenceJp)\nNghĩa: \(q.promptVi)\nGiải thích: \(q.explanation)",
                    relatedWordId: nil
                )
            )
        }
        
        // MARK: - Phần 3: Luyện nghe hiểu (5 câu)
        let listeningCandidates = allVocabPool.shuffled()
        for i in 0..<min(5, listeningCandidates.count) {
            let item = listeningCandidates[i]
            let prompt = "Nghe âm thanh và chọn ý nghĩa tiếng Việt chính xác:"
            let speechSentence = item.exampleJp ?? "\(item.displayText)です。"
            
            var options: [String] = [item.exampleVi ?? item.meaningVi]
            for other in listeningCandidates where other.id != item.id {
                let text = other.exampleVi ?? other.meaningVi
                if !options.contains(text) {
                    options.append(text)
                }
                if options.count == 4 { break }
            }
            while options.count < 4 { options.append("Ý nghĩa khác \(options.count)") }
            options.shuffle()
            let correctIdx = options.firstIndex(of: item.exampleVi ?? item.meaningVi) ?? 0
            
            let exp = "Câu nghe được:「\(speechSentence)」\nCách đọc: \(item.kana)\nÝ nghĩa: \(item.exampleVi ?? item.meaningVi)"
            
            questions.append(
                JLPTQuestion(
                    id: "mock_\(levelStr)_listening_\(i+1)",
                    section: .listening,
                    prompt: prompt,
                    contentJp: "🔊 Hãy nghe kỹ đoạn phát âm tiếng Nhật...",
                    audioText: speechSentence,
                    options: options,
                    correctIndex: correctIdx,
                    explanation: exp,
                    relatedWordId: item.id
                )
            )
        }
        
        return questions
    }
}
