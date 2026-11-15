//
//  AppHocTiengNhatTests.swift
//  AppHocTiengNhatTests
//
//  Created by  User on 23.10.2026.
//

import XCTest
@testable import AppHocTiengNhat

final class AppHocTiengNhatTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
    }

    func testGrammarRepositoryHasComplete50MinnaLessons() throws {
        let repo = GrammarRepository.shared
        XCTAssertEqual(repo.lessons.count, 50, "Phải có đầy đủ 50 bài Minna no Nihongo N5 & N4")
        XCTAssertEqual(repo.lessons.map(\.lessonNumber), Array(1...50), "Số thứ tự bài học phải liên tục từ 1 đến 50")
        XCTAssertEqual(repo.getLessons(level: "N5").count, 25, "Cấp độ N5 gồm Bài 1-25")
        XCTAssertEqual(repo.getLessons(level: "N4").count, 25, "Cấp độ N4 gồm Bài 26-50")

        var pointIds = Set<String>()
        var quizIds = Set<String>()

        for lesson in repo.lessons {
            XCTAssertFalse(lesson.title.isEmpty, "Bài \(lesson.lessonNumber) phải có tiêu đề")
            XCTAssertFalse(lesson.summary.isEmpty, "Bài \(lesson.lessonNumber) phải có tóm tắt")
            XCTAssertTrue(GrammarRepository.groupTags.contains(lesson.groupTag), "Bài \(lesson.lessonNumber) phải thuộc nhóm hợp lệ")
            XCTAssertGreaterThanOrEqual(lesson.points.count, 3, "Bài \(lesson.lessonNumber) phải có ít nhất 3 mẫu ngữ pháp")
            XCTAssertGreaterThanOrEqual(lesson.quizzes.count, 3, "Bài \(lesson.lessonNumber) phải có ít nhất 3 câu hỏi trắc nghiệm")

            let hasParticleFill = lesson.quizzes.contains { $0.quizType == .particleFill }
            let hasSentenceMatch = lesson.quizzes.contains { $0.quizType == .sentenceMatch }
            XCTAssertTrue(hasParticleFill, "Bài \(lesson.lessonNumber) phải có bài tập điền trợ từ / chia thể")
            XCTAssertTrue(hasSentenceMatch, "Bài \(lesson.lessonNumber) phải có bài tập nối câu")

            for point in lesson.points {
                XCTAssertEqual(point.lessonNumber, lesson.lessonNumber)
                XCTAssertTrue(point.id.hasPrefix("grammar_b\(lesson.lessonNumber)_"))
                XCTAssertTrue(pointIds.insert(point.id).inserted, "Trùng ID mẫu ngữ pháp: \(point.id)")
                XCTAssertFalse(point.structure.isEmpty)
                XCTAssertFalse(point.exampleJp.isEmpty)
            }

            for quiz in lesson.quizzes {
                XCTAssertEqual(quiz.lessonNumber, lesson.lessonNumber)
                XCTAssertTrue(quizIds.insert(quiz.id).inserted, "Trùng ID câu hỏi: \(quiz.id)")
                XCTAssertEqual(quiz.options.count, 4, "Câu hỏi \(quiz.id) phải có 4 lựa chọn")
                XCTAssertEqual(Set(quiz.options).count, 4, "Các lựa chọn trong \(quiz.id) không được trùng nhau")
                XCTAssertTrue(quiz.options.contains(quiz.correctAnswer), "Đáp án đúng phải nằm trong danh sách options của \(quiz.id)")
                XCTAssertFalse(quiz.fullSentenceJp.isEmpty)
                XCTAssertFalse(quiz.explanation.isEmpty)
            }
        }

        let particleQuizzes = repo.getAllQuizzes(type: .particleFill)
        let matchQuizzes = repo.getAllQuizzes(type: .sentenceMatch)
        XCTAssertGreaterThanOrEqual(particleQuizzes.count, 50)
        XCTAssertGreaterThanOrEqual(matchQuizzes.count, 50)
        XCTAssertEqual(particleQuizzes.count + matchQuizzes.count, repo.getAllQuizzes().count)

        let lesson49Match = repo.getQuizzes(forLesson: 49, type: .sentenceMatch)
        XCTAssertFalse(lesson49Match.isEmpty)
        XCTAssertTrue(lesson49Match.allSatisfy { $0.lessonNumber == 49 && $0.quizType == .sentenceMatch })
    }

    func testVocabRepositoryHasComplete50MinnaLessons() throws {
        let repo = VocabRepository.shared
        XCTAssertEqual(repo.lessons.count, 50, "Phải có đầy đủ 50 bài từ vựng Minna no Nihongo")
        XCTAssertEqual(repo.lessons.map(\.lessonNumber), Array(1...50), "Số thứ tự bài học từ vựng phải liên tục 1...50")
        XCTAssertEqual(repo.getLessons(level: "N5").count, 25)
        XCTAssertEqual(repo.getLessons(level: "N4").count, 25)
        XCTAssertEqual(repo.topics.count, 5, "Giữ nguyên 5 chủ đề giao tiếp cơ bản")

        var wordIds = Set<String>()
        for lesson in repo.lessons {
            XCTAssertFalse(lesson.title.isEmpty)
            XCTAssertTrue(VocabRepository.partTags.contains(lesson.partTag), "Bài \(lesson.lessonNumber) phải thuộc phần hợp lệ")
            XCTAssertGreaterThanOrEqual(lesson.words.count, 6, "Bài \(lesson.lessonNumber) phải có ít nhất 6 từ vựng")

            for word in lesson.words {
                XCTAssertEqual(word.lessonNumber, lesson.lessonNumber)
                XCTAssertTrue(wordIds.insert(word.id).inserted, "Trùng ID từ vựng: \(word.id)")
                XCTAssertFalse(word.kana.isEmpty)
                XCTAssertFalse(word.meaningVi.isEmpty)
                XCTAssertFalse(word.exampleJp?.isEmpty ?? true)
                XCTAssertFalse(word.exampleVi?.isEmpty ?? true)
            }
        }

        XCTAssertEqual(repo.getAllLessonWords().count, 300)
        XCTAssertEqual(repo.vocabList.count, repo.topicWords.count + repo.getAllLessonWords().count)
    }

    func testProgressServiceNeedReviewAndMasteredWorkflow() throws {
        let testDefaults = UserDefaults(suiteName: "TestProgressServiceWorkflow")!
        testDefaults.removePersistentDomain(forName: "TestProgressServiceWorkflow")
        let progress = ProgressService(defaults: testDefaults)

        let testWordId = "test_word_123"

        XCTAssertFalse(progress.isWordInReview(id: testWordId))
        XCTAssertFalse(progress.isMastered(id: testWordId))
        XCTAssertEqual(progress.getNeedReviewCount(), 0)

        // Mark for review
        progress.markWordForReview(id: testWordId)
        XCTAssertTrue(progress.isWordInReview(id: testWordId))
        XCTAssertEqual(progress.getNeedReviewCount(), 1)

        // When mastered, it should auto remove from need review
        let isNowMastered = progress.toggleMastered(id: testWordId)
        XCTAssertTrue(isNowMastered)
        XCTAssertTrue(progress.isMastered(id: testWordId))
        XCTAssertFalse(progress.isWordInReview(id: testWordId))
        XCTAssertEqual(progress.getNeedReviewCount(), 0)

        // Vocab test score recording
        progress.recordVocabTestScore(score: 85)
        XCTAssertEqual(progress.getLastVocabScore(), 85)
    }

    func testKanjiRepositoryN5AndN4Sync() throws {
        let repo = KanjiRepository.shared
        XCTAssertEqual(repo.n5KanjiList.count, 27, "Kanji N5 gồm 27 chữ căn bản")
        XCTAssertEqual(repo.n4KanjiList.count, 41, "Kanji N4 gồm 41 chữ trọng tâm")
        XCTAssertEqual(repo.allKanji.count, 68, "Tổng cộng 68 chữ Hán N5 & N4")

        XCTAssertEqual(repo.getKanji(for: "N5").count, 27)
        XCTAssertEqual(repo.getKanji(for: "N4").count, 41)
        XCTAssertEqual(repo.getKanji(for: nil).count, 68)

        var kanjiSet = Set<String>()
        for kanji in repo.allKanji {
            XCTAssertFalse(kanji.kanji.isEmpty)
            XCTAssertFalse(kanji.hanViet.isEmpty)
            XCTAssertFalse(kanji.meaningVi.isEmpty)
            XCTAssertTrue(kanji.strokeCount > 0)
            XCTAssertTrue(kanji.jlptLevel == "N5" || kanji.jlptLevel == "N4")
            XCTAssertFalse(kanji.examples.isEmpty)
            XCTAssertTrue(kanjiSet.insert(kanji.kanji).inserted, "Trùng chữ Hán: \(kanji.kanji)")

            for ex in kanji.examples {
                XCTAssertFalse(ex.word.isEmpty)
                XCTAssertFalse(ex.reading.isEmpty)
                XCTAssertFalse(ex.meaning.isEmpty)
            }
        }
    }

    func testJLPTMockTestGenerationN5AndN4() throws {
        let repo = JLPTMockTestRepository.shared

        // Test đề thi N5
        let n5Questions = repo.generateMockTest(level: .n5)
        XCTAssertEqual(n5Questions.count, 25, "Đề thi N5 chuẩn gồm 25 câu hỏi")
        let n5Vocab = n5Questions.filter { $0.section == .vocabKanji }
        let n5Grammar = n5Questions.filter { $0.section == .grammar }
        let n5Listen = n5Questions.filter { $0.section == .listening }
        XCTAssertEqual(n5Vocab.count, 10, "Phần chữ Hán - Từ vựng gồm 10 câu")
        XCTAssertEqual(n5Grammar.count, 10, "Phần Ngữ pháp gồm 10 câu")
        XCTAssertEqual(n5Listen.count, 5, "Phần Nghe hiểu gồm 5 câu")

        // Test đề thi N4
        let n4Questions = repo.generateMockTest(level: .n4)
        XCTAssertEqual(n4Questions.count, 25, "Đề thi N4 chuẩn gồm 25 câu hỏi")
        let n4Vocab = n4Questions.filter { $0.section == .vocabKanji }
        let n4Grammar = n4Questions.filter { $0.section == .grammar }
        let n4Listen = n4Questions.filter { $0.section == .listening }
        XCTAssertEqual(n4Vocab.count, 10)
        XCTAssertEqual(n4Grammar.count, 10)
        XCTAssertEqual(n4Listen.count, 5)

        // Kiểm tra tính hợp lệ của từng câu hỏi
        for q in n5Questions + n4Questions {
            XCTAssertEqual(q.options.count, 4, "Mỗi câu hỏi phải có 4 phương án")
            XCTAssertTrue(q.correctIndex >= 0 && q.correctIndex < 4, "Chỉ số đáp án đúng phải từ 0 đến 3")
            XCTAssertFalse(q.contentJp.isEmpty)
            XCTAssertFalse(q.explanation.isEmpty)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
