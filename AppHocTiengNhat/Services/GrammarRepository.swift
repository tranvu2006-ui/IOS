//
//  GrammarRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class GrammarRepository {
    public static let shared = GrammarRepository()

    public static let groupTags: [String] = [
        "Bài 1-8: Cơ bản & Trợ từ",
        "Bài 9-13: Sở thích & Tồn tại",
        "Bài 14-19: Chia thể V (て・ない・辞書・た)",
        "Bài 20-25: Thể thông thường & Nối câu",
        "Bài 26-32: Giải thích, Khả năng, Tự/Tha & Ý chí",
        "Bài 33-38: Mệnh lệnh, Điều kiện, Bị động & Danh hóa",
        "Bài 39-44: Nguyên nhân, Hỏi lồng, Cho nhận & Phỏng đoán",
        "Bài 45-50: Trường hợp, Truyền đạt, Sai khiến & Kính ngữ"
    ]

    public let lessons: [GrammarLesson]

    private init() {
        self.lessons =
            Self.buildLessons1To5()
            + Self.buildLessons6To10()
            + Self.buildLessons11To15()
            + Self.buildLessons16To20()
            + Self.buildLessons21To25()
            + Self.buildLessons26To30()
            + Self.buildLessons31To35()
            + Self.buildLessons36To40()
            + Self.buildLessons41To45()
            + Self.buildLessons46To50()
    }

    public func getLessons(level: String? = nil) -> [GrammarLesson] {
        guard let level = level else { return lessons }
        return lessons.filter { $0.jlptLevel == level }
    }

    public func getAllPoints(level: String? = nil) -> [GrammarPoint] {
        return getLessons(level: level).flatMap { $0.points }
    }

    public func getAllQuizzes(type: GrammarQuizType? = nil, level: String? = nil) -> [GrammarQuizQuestion] {
        let all = getLessons(level: level).flatMap { $0.quizzes }
        guard let type = type else { return all }
        return all.filter { $0.quizType == type }
    }

    public func getQuizzes(forLesson lessonNumber: Int?, type: GrammarQuizType? = nil, level: String? = nil) -> [GrammarQuizQuestion] {
        let base: [GrammarQuizQuestion]
        if let lessonNumber = lessonNumber,
           let lesson = lessons.first(where: { $0.lessonNumber == lessonNumber }) {
            base = lesson.quizzes
        } else {
            base = getLessons(level: level).flatMap { $0.quizzes }
        }
        guard let type = type else { return base }
        return base.filter { $0.quizType == type }
    }

    // MARK: - Bài 1 - 5
    private static func buildLessons1To5() -> [GrammarLesson] {
        let g1 = groupTags[0]
        return [
            GrammarLesson(
                lessonNumber: 1,
                title: "Giới thiệu bản thân (は・も・の・か)",
                summary: "Câu danh từ khẳng định/phủ định です, trợ từ chủ đề は, cũng も, sở hữu の và câu hỏi か.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 1, index: 1,
                        title: "N1 は N2 です / じゃありません",
                        structure: "N1 は N2 です。\nN1 は N2 じゃありません。",
                        meaning: "N1 là N2 / N1 không phải là N2",
                        explanation: "Trợ từ 「は」 (đọc là wa) đánh dấu chủ đề của câu. 「です」 biểu thị khẳng định lịch sự; 「じゃありません」 (hoặc trang trọng hơn là 「ではありません」) biểu thị phủ định.",
                        exampleJp: "わたしは ベトナムじんです。かいしゃいんじゃありません。",
                        exampleReading: "Watashi wa Betonamu-jin desu. Kaishain ja arimasen.",
                        exampleVi: "Tôi là người Việt Nam. Tôi không phải là nhân viên công ty."
                    ),
                    GrammarPoint(
                        lessonNumber: 1, index: 2,
                        title: "Câu nghi vấn S か & N1 も",
                        structure: "N1 は N2 ですか。\nN1 も N2 です。",
                        meaning: "Câu hỏi với か / N1 cũng là N2",
                        explanation: "Thêm 「か」 vào cuối câu để tạo câu hỏi. Khi lặp lại cùng vị ngữ cho một danh từ khác, thay 「は」 bằng 「も」 (cũng).",
                        exampleJp: "ミラーさんは エンジニアですか。グプタさんも エンジニアです。",
                        exampleReading: "Miraa-san wa enjinia desu ka. Guputa-san mo enjinia desu.",
                        exampleVi: "Anh Miller là kỹ sư phải không? Anh Gupta cũng là kỹ sư."
                    ),
                    GrammarPoint(
                        lessonNumber: 1, index: 3,
                        title: "Trợ từ nối danh từ N1 の N2",
                        structure: "N1 の N2",
                        meaning: "N2 thuộc về / của N1",
                        explanation: "「の」 nối 2 danh từ lại với nhau, trong đó N1 làm rõ thuộc tính, cơ quan trực thuộc hoặc chủ sở hữu cho danh từ chính N2 đứng sau.",
                        exampleJp: "サントスさんは IMC の しゃいんです。",
                        exampleReading: "Santosu-san wa IMC no shain desu.",
                        exampleVi: "Anh Santos là nhân viên của công ty IMC."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 1, index: 1, quizType: .particleFill,
                        promptJp: "わたし [ ___ ] がくせいです。",
                        promptVi: "Tôi là học sinh.",
                        correctAnswer: "は",
                        options: ["は", "の", "が", "を"],
                        explanation: "Dùng trợ từ 「は」 (đọc là wa) để đánh dấu chủ đề 'Tôi' trong câu danh từ N1 は N2 です.",
                        fullSentenceJp: "わたしは がくせいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 1, index: 2, quizType: .particleFill,
                        promptJp: "カリナさんは ふじだいがく [ ___ ] がくせいです。",
                        promptVi: "Chị Karina là sinh viên của trường Đại học Fuji.",
                        correctAnswer: "の",
                        options: ["の", "も", "は", "か"],
                        explanation: "Dùng 「の」 nối 2 danh từ để chỉ sự trực thuộc: 'sinh viên của Đại học Fuji'.",
                        fullSentenceJp: "カリナさんは ふじだいがくの がくせいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 1, index: 3, quizType: .sentenceMatch,
                        promptJp: "サントスさんは かいしゃいんです。ミラーさん [ ___ ]",
                        promptVi: "Anh Santos là nhân viên công ty. Anh Miller cũng là nhân viên công ty.",
                        correctAnswer: "も かいしゃいんです。",
                        options: ["も かいしゃいんです。", "は ぎんこういんです。", "の かいしゃいんです。", "か かいしゃいんです。"],
                        explanation: "Khi N2 có cùng danh tính/nghề nghiệp với N1 đã nêu trước đó, dùng trợ từ 「も」 (cũng).",
                        fullSentenceJp: "サントスさんは かいしゃいんです。ミラーさんも かいしゃいんです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 2,
                title: "Đại từ chỉ vật (これ・この・の)",
                summary: "Phân biệt これ/それ/あれ với この/その/あの, câu hỏi lựa chọn S1 か、S2 か và sở hữu の.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 2, index: 1,
                        title: "これ / それ / あれ は N です",
                        structure: "これ / それ / あれ は N です。",
                        meaning: "Cái này / cái đó / cái kia là N",
                        explanation: "これ (gần người nói), それ (gần người nghe), あれ (xa cả hai) đứng độc lập làm chủ ngữ để chỉ đồ vật.",
                        exampleJp: "それは わたしの じしょです。",
                        exampleReading: "Sore wa watashi no jisho desu.",
                        exampleVi: "Cái đó là từ điển của tôi."
                    ),
                    GrammarPoint(
                        lessonNumber: 2, index: 2,
                        title: "この / その / あの + Danh từ",
                        structure: "この / その / あの N は ～ です。",
                        meaning: "Cái N này / N đó / N kia ~",
                        explanation: "Khác với これ/それ/あれ đứng một mình, この/その/あの bắt buộc phải có danh từ đi ngay phía sau.",
                        exampleJp: "この かさは わたしのです。",
                        exampleReading: "Kono kasa wa watashi no desu.",
                        exampleVi: "Cái ô này là của tôi."
                    ),
                    GrammarPoint(
                        lessonNumber: 2, index: 3,
                        title: "Câu hỏi lựa chọn & Sở hữu lược bỏ",
                        structure: "S1 か、S2 か。\nN1 の (N2)",
                        meaning: "Là S1 hay là S2? / Của N1",
                        explanation: "Dùng 「S1 か、S2 か」 để hỏi chọn một trong hai. Có thể lược bỏ N2 sau 「の」 khi ngữ cảnh đã rõ đồ vật đang nói tới (VD: わたしのです).",
                        exampleJp: "これは 「い」ですか、「り」ですか。",
                        exampleReading: "Kore wa 'i' desu ka, 'ri' desu ka.",
                        exampleVi: "Đây là chữ 'i' hay chữ 'ri'?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 2, index: 1, quizType: .particleFill,
                        promptJp: "[ ___ ] ほんは わたしのです。",
                        promptVi: "Quyển sách này là của tôi.",
                        correctAnswer: "この",
                        options: ["この", "これ", "それ", "あれ"],
                        explanation: "Vì phía sau có danh từ 「ほん」 đi kèm nên phải dùng 「この」 (không dùng これ).",
                        fullSentenceJp: "この ほんは わたしのです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 2, index: 2, quizType: .particleFill,
                        promptJp: "それは なん [ ___ ] ざっしですか。",
                        promptVi: "Đó là tạp chí về cái gì vậy?",
                        correctAnswer: "の",
                        options: ["の", "を", "は", "が"],
                        explanation: "Dùng 「なんの N」 (N về cái gì) với trợ từ 「の」 nối giữa 「なん」 và danh từ 「ざっし」.",
                        fullSentenceJp: "それは なんの ざっしですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 2, index: 3, quizType: .sentenceMatch,
                        promptJp: "この かばんは だれのですか。— [ ___ ]",
                        promptVi: "Cái cặp này là của ai vậy? — Là của anh Sato.",
                        correctAnswer: "さとうさんの です。",
                        options: ["さとうさんの です。", "さとうさんは です。", "さとうさんか です。", "さとうさんも です。"],
                        explanation: "Trả lời câu hỏi sở hữu 'của ai' (だれの), ta lược bỏ danh từ 'kaban' và giữ lại 「N の です」.",
                        fullSentenceJp: "この かばんは だれのですか。さとうさんの です。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 3,
                title: "Địa điểm & Giá cả (ここ・どこ・いくら)",
                summary: "Chỉ thị từ địa điểm ここ/そこ/あそこ/こちら, hỏi nguồn gốc どこの và hỏi giá tiền いくら.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 3, index: 1,
                        title: "ここ / そこ / あそこ / こちら",
                        structure: "N は ここ / そこ / あそこ です。\nこちら / そちら / あちら",
                        meaning: "N ở chỗ này / chỗ đó / chỗ kia",
                        explanation: "ここ (chỗ tôi), そこ (chỗ bạn), あそこ (chỗ kia) dùng chỉ vị trí. こちら/そちら/あちら là dạng lịch sự hơn hoặc chỉ phương hướng.",
                        exampleJp: "トイレは あそこです。うけつけは こちらです。",
                        exampleReading: "Toire wa asoko desu. Uketsuke wa kochira desu.",
                        exampleVi: "Nhà vệ sinh ở đằng kia. Quầy lễ tân ở phía này ạ."
                    ),
                    GrammarPoint(
                        lessonNumber: 3, index: 2,
                        title: "Hỏi xuất xứ / hãng sản xuất: どこの N",
                        structure: "N1 は どこの N2 ですか。",
                        meaning: "N1 là N2 của nước nào / hãng nào?",
                        explanation: "Dùng 「どこ」 (ở đâu) kết hợp 「の」 để hỏi tên quốc gia, công ty, trường học sản xuất hoặc nơi xuất xứ của danh từ.",
                        exampleJp: "それは どこの カメラですか。— 日本の カメラです。",
                        exampleReading: "Sore wa doko no kamera desu ka. Nihon no kamera desu.",
                        exampleVi: "Đó là máy ảnh của nước nào? — Là máy ảnh của Nhật Bản."
                    ),
                    GrammarPoint(
                        lessonNumber: 3, index: 3,
                        title: "Hỏi giá tiền: いくらですか",
                        structure: "N は いくらですか。",
                        meaning: "N giá bao nhiêu tiền?",
                        explanation: "「いくら」 dùng để hỏi giá cả, kết hợp với đơn vị tiền tệ như ～えん (Yên) hoặc ～ドン (Đồng) khi trả lời.",
                        exampleJp: "この ネクタイは いくらですか。— 1,500えんです。",
                        exampleReading: "Kono nekutai wa ikura desu ka. Sen go-hyaku en desu.",
                        exampleVi: "Chiếc cà vạt này giá bao nhiêu? — 1.500 Yên ạ."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 3, index: 1, quizType: .particleFill,
                        promptJp: "エレベーター [ ___ ] どちらですか。",
                        promptVi: "Thang máy ở phía nào ạ?",
                        correctAnswer: "は",
                        options: ["は", "を", "に", "の"],
                        explanation: "Mẫu câu hỏi vị trí địa điểm dùng 「N は ここ/どこ/どちら ですか」.",
                        fullSentenceJp: "エレベーターは どちらですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 3, index: 2, quizType: .particleFill,
                        promptJp: "お国は [ ___ ] ですか。— ベトナムです。",
                        promptVi: "Quê hương / Đất nước của bạn là ở đâu? — Việt Nam.",
                        correctAnswer: "どちら",
                        options: ["どちら", "だれ", "いくら", "どれ"],
                        explanation: "Khi hỏi tên đất nước, công ty một cách lịch sự, người Nhật dùng 「お国は どちらですか」.",
                        fullSentenceJp: "お国は どちらですか。ベトナムです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 3, index: 3, quizType: .sentenceMatch,
                        promptJp: "すみません、その ワインは いくらですか。— [ ___ ]",
                        promptVi: "Xin lỗi, chai rượu vang đó giá bao nhiêu? — 2.800 Yên ạ.",
                        correctAnswer: "2,800えん です。",
                        options: ["2,800えん です。", "フランスの です。", "地下 1階 です。", "イタリアのです。"],
                        explanation: "Câu hỏi 「いくらですか」 hỏi về giá tiền nên đáp án phải chứa đơn vị tiền tệ (2,800えん).",
                        fullSentenceJp: "その ワインは いくらですか。2,800えんです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 4,
                title: "Thời gian & Chia động từ ます",
                summary: "Cách nói giờ phút, chia 4 dạng động từ lịch sự ます/ません/ました/ませんでした, trợ từ thời gian に và から～まで.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 4, index: 1,
                        title: "Chia 4 dạng Động từ ます (Hiện tại & Quá khứ)",
                        structure: "Vます (Hiện tại/Tương lai)\nVません (Phủ định HT/TL)\nVました (Quá khứ)\nVませんでした (Phủ định QK)",
                        meaning: "Làm / Không làm / Đã làm / Đã không làm",
                        explanation: "Động từ thể lịch sự (ます形) chia theo thì hiện tại-tương lai và quá khứ. Dùng với まいにち (hàng ngày), あした (ngày mai), きのう (hôm qua)...",
                        exampleJp: "きのう 10じに ねました。けさは 6じに おきました。",
                        exampleReading: "Kinou juu-ji ni nemashita. Kesa wa roku-ji ni okimashita.",
                        exampleVi: "Hôm qua tôi ngủ lúc 10 giờ. Sáng nay tôi dậy lúc 6 giờ."
                    ),
                    GrammarPoint(
                        lessonNumber: 4, index: 2,
                        title: "Trợ từ chỉ điểm thời gian: Thời gian に V",
                        structure: "Thời gian cụ thể に Vます。",
                        meaning: "Làm V vào lúc [thời gian]",
                        explanation: "Dùng 「に」 sau các danh từ chỉ thời gian có con số cụ thể (6じ, 7がつ3にち, げつようび). Lưu ý: KHÔNG dùng 「に」 sau きょう, きのう, あした, まいにち.",
                        exampleJp: "まいにち 7じはんに おきます。",
                        exampleReading: "Mainichi shichi-ji han ni okimasu.",
                        exampleVi: "Hàng ngày tôi thức dậy vào lúc 7 giờ rưỡi."
                    ),
                    GrammarPoint(
                        lessonNumber: 4, index: 3,
                        title: "Từ ~ Đến ~: N1 から N2 まで",
                        structure: "N1 から N2 まで",
                        meaning: "Từ N1 đến N2",
                        explanation: "「から」 chỉ điểm bắt đầu (từ) và 「まで」 chỉ điểm kết thúc (đến) của thời gian hoặc không gian. Có thể dùng tách rời hoặc kết hợp.",
                        exampleJp: "ひるやすみは 12じから 1じまでです。",
                        exampleReading: "Hiruyasumi wa juu-ni-ji kara ichi-ji made desu.",
                        exampleVi: "Giờ nghỉ trưa là từ 12 giờ đến 1 giờ."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 4, index: 1, quizType: .particleFill,
                        promptJp: "あさ 6じはん [ ___ ] おきます。",
                        promptVi: "Tôi thức dậy vào lúc 6 giờ rưỡi sáng.",
                        correctAnswer: "に",
                        options: ["に", "で", "を", "へ"],
                        explanation: "Thời điểm cụ thể có con số (6じはん) đi với trợ từ 「に」 trước động từ hành động.",
                        fullSentenceJp: "あさ 6じはんに おきます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 4, index: 2, quizType: .particleFill,
                        promptJp: "きのうの ばん、11じまで べんきょう [ ___ ]。",
                        promptVi: "Tối hôm qua tôi đã học bài đến 11 giờ.",
                        correctAnswer: "しました",
                        options: ["しました", "します", "しません", "しましょう"],
                        explanation: "Vì có từ chỉ quá khứ 「きのうの ばん」 (tối hôm qua) nên động từ phải chia về quá khứ 「しました」.",
                        fullSentenceJp: "きのうの ばん、11じまで べんきょうしました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 4, index: 3, quizType: .sentenceMatch,
                        promptJp: "ぎんこうは なんじから なんじまでですか。— [ ___ ]",
                        promptVi: "Ngân hàng làm việc từ mấy giờ đến mấy giờ? — Từ 9 giờ đến 3 giờ.",
                        correctAnswer: "9じから 3じまで です。",
                        options: ["9じから 3じまで です。", "9じに 3じへ です。", "9じと 3じまで です。", "9じで 3じから です。"],
                        explanation: "Trả lời khoảng thời gian bắt đầu-kết thúc chuẩn xác dùng mẫu 「N1 から N2 まで です」.",
                        fullSentenceJp: "ぎんこうは 9じから 3じまで です。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 5,
                title: "Di chuyển Đi - Đến - Về (へ・で・と)",
                summary: "Trợ từ chỉ hướng へ, phương tiện đi lại で, cùng ai と, và phủ định hoàn toàn với nghi vấn từ + も.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 5, index: 1,
                        title: "Hướng di chuyển: Địa điểm へ いきます/きます/かえります",
                        structure: "Địa điểm へ いきます / きます / かえります。",
                        meaning: "Đi / Đến / Về [Địa điểm]",
                        explanation: "Trợ từ 「へ」 (đọc là e) chỉ phương hướng nơi đến của các động từ di chuyển.",
                        exampleJp: "らいげつ 日本へ いきます。",
                        exampleReading: "Raigetsu Nihon e ikimasu.",
                        exampleVi: "Tháng sau tôi sẽ đi Nhật Bản."
                    ),
                    GrammarPoint(
                        lessonNumber: 5, index: 2,
                        title: "Phương tiện で & Cùng ai と",
                        structure: "Phương tiện で Vます。\nNgười/Động vật と Vます。",
                        meaning: "Đi bằng [phương tiện] / Làm V cùng với [ai]",
                        explanation: "「で」 đặt sau phương tiện giao thông (でんしゃで, タクシーで). Lưu ý: đi bộ dùng 「あるいて」 (không thêm で). 「と」 chỉ đối tượng cùng thực hiện hành động (hitori de là một mình).",
                        exampleJp: "ともだちと しんかんせんで きょうとへ いきます。",
                        exampleReading: "Tomodachi to shinkansen de Kyouto e ikimasu.",
                        exampleVi: "Tôi đi Kyoto cùng bạn bằng tàu Shinkansen."
                    ),
                    GrammarPoint(
                        lessonNumber: 5, index: 3,
                        title: "Phủ định hoàn toàn: どこへも いきません",
                        structure: "どこ [へ] も Vません。\nだれとも Vません。",
                        meaning: "Không đi đâu cả / Không đi với ai cả",
                        explanation: "Khi đi với động từ phủ định, gắn 「も」 vào sau nghi vấn từ (どこへも, なにも, だれとも) để phủ định toàn bộ.",
                        exampleJp: "にちようび どこへも いきませんでした。",
                        exampleReading: "Nichiyoubi doko e mo ikimasen deshita.",
                        exampleVi: "Chủ nhật tôi chẳng đi đâu cả."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 5, index: 1, quizType: .particleFill,
                        promptJp: "まいあさ バス [ ___ ] かいしゃへ いきます。",
                        promptVi: "Mỗi sáng tôi đi đến công ty bằng xe buýt.",
                        correctAnswer: "で",
                        options: ["で", "を", "へ", "に"],
                        explanation: "Dùng trợ từ 「で」 sau danh từ chỉ phương tiện giao thông (バス).",
                        fullSentenceJp: "まいあさ バスで かいしゃへ いきます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 5, index: 2, quizType: .particleFill,
                        promptJp: "かぞく [ ___ ] うちへ かえります。",
                        promptVi: "Tôi về nhà cùng với gia đình.",
                        correctAnswer: "と",
                        options: ["と", "で", "を", "へ"],
                        explanation: "Dùng trợ từ 「と」 (cùng với) để nối người cùng thực hiện hành động.",
                        fullSentenceJp: "かぞくと うちへ かえります。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 5, index: 3, quizType: .sentenceMatch,
                        promptJp: "きのう どこか へ いきましたか。— いいえ、[ ___ ]",
                        promptVi: "Hôm qua bạn có đi đâu không? — Không, tôi chẳng đi đâu cả.",
                        correctAnswer: "どこへも いきませんでした。",
                        options: ["どこへも いきませんでした。", "どこへも いきました。", "どこへ いきません。", "ひとりで いきました。"],
                        explanation: "Phủ định hoàn toàn địa điểm trong quá khứ dùng 「どこへも いきませんでした」.",
                        fullSentenceJp: "いいえ、どこへも いきませんでした。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 6 - 10
    private static func buildLessons6To10() -> [GrammarLesson] {
        let g1 = groupTags[0]
        let g2 = groupTags[1]
        return [
            GrammarLesson(
                lessonNumber: 6,
                title: "Tha động từ & Rủ rê (を・で・ませんか)",
                summary: "Tân ngữ trực tiếp với trợ từ を, nơi diễn ra hành động で, và mẫu mời mọc Vませんか / Vましょう.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 6, index: 1,
                        title: "Tân ngữ trực tiếp: N を V",
                        structure: "Danh từ を Tha động từ (たべます, のみます, みます...)",
                        meaning: "Làm hành động V lên đối tượng N",
                        explanation: "Trợ từ 「を」 (đọc là o) đứng sau danh từ làm tân ngữ trực tiếp chịu tác động của động từ.",
                        exampleJp: "あさ パンと たまごを たべます。",
                        exampleReading: "Asa pan to tamago o tabemasu.",
                        exampleVi: "Buổi sáng tôi ăn bánh mì và trứng."
                    ),
                    GrammarPoint(
                        lessonNumber: 6, index: 2,
                        title: "Nơi diễn ra hành động: Địa điểm で V",
                        structure: "Địa điểm で Vます。",
                        meaning: "Thực hiện hành động V tại [địa điểm]",
                        explanation: "Khác với 「へ」 (hướng tới) và 「に」 (tồn tại), trợ từ 「で」 đánh dấu địa điểm nơi một hành động cụ thể đang diễn ra.",
                        exampleJp: "えきの ちかくの レストランで ひるごはんを たべます。",
                        exampleReading: "Eki no chikaku no resutoran de hirugohan o tabemasu.",
                        exampleVi: "Tôi ăn trưa tại nhà hàng gần nhà ga."
                    ),
                    GrammarPoint(
                        lessonNumber: 6, index: 3,
                        title: "Mời mọc & Đề nghị: Vませんか / Vましょう",
                        structure: "いっしょに Vませんか。\n— ええ、Vましょう。",
                        meaning: "Cùng làm V với tôi không? / Vâng, cùng làm nào!",
                        explanation: "「Vませんか」 dùng để mời người nghe một cách lịch sự, tôn trọng ý kiến của họ. 「Vましょう」 dùng để hưởng ứng lời mời hoặc chủ động rủ khi cùng hội ý.",
                        exampleJp: "いっしょに コーヒーを のみませんか。— ええ、のみましょう。",
                        exampleReading: "Issho ni koohii o nomimasen ka. Ee, nomimashou.",
                        exampleVi: "Cùng uống cà phê với tôi không? — Vâng, cùng uống thôi!"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 6, index: 1, quizType: .particleFill,
                        promptJp: "としょかん [ ___ ] にほんごを べんきょうします。",
                        promptVi: "Tôi học tiếng Nhật ở thư viện.",
                        correctAnswer: "で",
                        options: ["で", "に", "へ", "を"],
                        explanation: "「べんきょうします」 là động từ hành động nên địa điểm diễn ra hành động đi với trợ từ 「で」.",
                        fullSentenceJp: "としょかんで にほんごを べんきょうします。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 6, index: 2, quizType: .particleFill,
                        promptJp: "まいにち ニュース [ ___ ] みます。",
                        promptVi: "Mỗi ngày tôi đều xem tin tức.",
                        correctAnswer: "を",
                        options: ["を", "が", "に", "で"],
                        explanation: "「ニュース」 là tân ngữ trực tiếp của động từ 「みます」(xem) nên dùng trợ từ 「を」.",
                        fullSentenceJp: "まいにち ニュースを みます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 6, index: 3, quizType: .sentenceMatch,
                        promptJp: "あした いっしょに おはなみに [ ___ ] — ええ、いいですね。",
                        promptVi: "Ngày mai cùng đi ngắm hoa anh đào không? — Vâng, hay quá.",
                        correctAnswer: "いきませんか。",
                        options: ["いきませんか。", "いきませんでしたか。", "いきましたか。", "いきます。"],
                        explanation: "Mẫu câu mời lịch sự rủ người khác cùng làm gì là 「いっしょに Vませんか」.",
                        fullSentenceJp: "あした いっしょに おはなみに いきませんか。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 7,
                title: "Công cụ & Cho - Nhận đồ vật (で・に・から)",
                summary: "Phương tiện/ngôn ngữ で, động từ cho (あげます/かします/おしえます) và nhận (もらいます/かります/ならいます), cấu trúc もう Vました.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 7, index: 1,
                        title: "Công cụ & Ngôn ngữ: Công cụ で V",
                        structure: "Công cụ / Ngôn ngữ で Vます。",
                        meaning: "Làm V bằng [công cụ / ngôn ngữ]",
                        explanation: "Trợ từ 「で」 còn dùng để chỉ dụng cụ thực hiện hành động (はしで ăn bằng đũa) hoặc ngôn ngữ giao tiếp/viết (日本語で).",
                        exampleJp: "はしで ごはんを たべます。日本語で レポートを かきます。",
                        exampleReading: "Hashi de gohan o tabemasu. Nihongo de repooto o kakimasu.",
                        exampleVi: "Tôi ăn cơm bằng đũa. Tôi viết báo cáo bằng tiếng Nhật."
                    ),
                    GrammarPoint(
                        lessonNumber: 7, index: 2,
                        title: "Cho đồ: Người に N を あげます / かします",
                        structure: "Người nhận に Vật を あげます / かします / おしえます。",
                        meaning: "Tặng / cho mượn / dạy cho ai cái gì",
                        explanation: "Đối tượng nhận đồ vật (hoặc nhận lời dạy/gọi điện) đi với trợ từ 「に」.",
                        exampleJp: "わたしは キムラさんに はなを あげました。",
                        exampleReading: "Watashi wa Kimura-san ni hana o agemashita.",
                        exampleVi: "Tôi đã tặng hoa cho chị Kimura."
                    ),
                    GrammarPoint(
                        lessonNumber: 7, index: 3,
                        title: "Nhận đồ & もう Vました",
                        structure: "Người cho に/から Vật を もらいます / かります / ならいます。\nもう Vましたか。",
                        meaning: "Nhận / mượn / học từ ai đó / Đã làm V rồi chưa?",
                        explanation: "Người cho đi với 「に」 hoặc 「から」 (nếu người cho là tổ chức/trường học thì bắt buộc dùng 「から」). 「もう Vました」 nghĩa là đã làm xong rồi.",
                        exampleJp: "ちちに とけいを もらいました。もう ひるごはんを たべました。",
                        exampleReading: "Chichi ni tokei o moraimashita. Mou hirugohan o tabemashita.",
                        exampleVi: "Tôi đã nhận đồng hồ từ bố. Tôi đã ăn trưa rồi."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 7, index: 1, quizType: .particleFill,
                        promptJp: "「ありがとう」は えいご [ ___ ] なんですか。",
                        promptVi: "'Arigatou' trong tiếng Anh là gì vậy?",
                        correctAnswer: "で",
                        options: ["で", "を", "に", "へ"],
                        explanation: "Dùng trợ từ 「で」 sau tên ngôn ngữ (えいご, にほんご) khi hỏi cách diễn đạt bằng ngôn ngữ đó.",
                        fullSentenceJp: "「ありがとう」は えいごで なんですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 7, index: 2, quizType: .particleFill,
                        promptJp: "ミラーさん [ ___ ] CDを かりました。",
                        promptVi: "Tôi đã mượn đĩa CD từ anh Miller.",
                        correctAnswer: "に",
                        options: ["に", "を", "で", "へ"],
                        explanation: "Với động từ tiếp nhận (もらいます, かります, ならいます), người cho đi với trợ từ 「に」 hoặc 「から」.",
                        fullSentenceJp: "ミラーさんに CDを かりました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 7, index: 3, quizType: .sentenceMatch,
                        promptJp: "もう にもつを おくりましたか。— いいえ、[ ___ ]",
                        promptVi: "Bạn đã gửi hành lý chưa? — Chưa, tôi vẫn chưa gửi.",
                        correctAnswer: "まだです。",
                        options: ["まだです。", "もう おくりました。", "おくりません。", "おくりましょう。"],
                        explanation: "Khi trả lời 'chưa' cho câu hỏi 「もう Vましたか」, dùng 「いいえ、まだです」 (không dùng Vませんでした).",
                        fullSentenceJp: "もう にもつを おくりましたか。いいえ、まだです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 8,
                title: "Tính từ đuôi い & đuôi な (が・どんな)",
                summary: "Phân biệt và chia thể phủ định của Tính từ い (～くない) và Tính từ な (～じゃありません), bổ nghĩa danh từ và liên từ が.",
                groupTag: g1,
                points: [
                    GrammarPoint(
                        lessonNumber: 8, index: 1,
                        title: "Khẳng định & Phủ định của Tính từ い / な",
                        structure: "A(な) です / じゃありません\nA(い) です / くないです (bỏ い + くない)",
                        meaning: "Tính từ ở dạng khẳng định và phủ định hiện tại",
                        explanation: "Tính từ な bỏ な khi đứng cuối câu, phủ định thêm 「じゃありません」. Tính từ い giữ nguyên い khi khẳng định, phủ định bỏ 「い」 thêm 「くないです」. Ngoại lệ: いいです -> よくないです.",
                        exampleJp: "さくらは きれいです。この じしょは よくないです。",
                        exampleReading: "Sakura wa kirei desu. Kono jisho wa yokunai desu.",
                        exampleVi: "Hoa anh đào đẹp. Quyển từ điển này không tốt."
                    ),
                    GrammarPoint(
                        lessonNumber: 8, index: 2,
                        title: "Tính từ bổ nghĩa cho Danh từ",
                        structure: "A(な) な + N\nA(い) + N",
                        meaning: "Danh từ có tính chất A",
                        explanation: "Khi đứng trước bổ nghĩa cho danh từ, tính từ đuôi な phải giữ lại 「な」, còn tính từ đuôi い đặt trực tiếp trước danh từ.",
                        exampleJp: "ふじさんは きれいな やまです。おもしろい えいがを みました。",
                        exampleReading: "Fuji-san wa kirei na yama desu. Omoshiroi eiga o mimashita.",
                        exampleVi: "Núi Phú Sĩ là ngọn núi đẹp. Tôi đã xem bộ phim thú vị."
                    ),
                    GrammarPoint(
                        lessonNumber: 8, index: 3,
                        title: "Nối câu tương phản: S1 が、S2",
                        structure: "S1 が、S2。",
                        meaning: "S1 nhưng S2",
                        explanation: "Trợ từ nối 「が」 nối 2 mệnh đề có ý nghĩa đối lập nhau (nhưng/tuy nhiên). Lưu ý cũng dùng phó từ 「とても」(rất) đi với khẳng định và 「あまり」(không lắm) đi với phủ định.",
                        exampleJp: "日本の たべものは おいしいですが、たかいです。",
                        exampleReading: "Nihon no tabemono wa oishii desu ga, takai desu.",
                        exampleVi: "Đồ ăn Nhật Bản ngon nhưng đắt."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 8, index: 1, quizType: .particleFill,
                        promptJp: "奈良は しずか [ ___ ] まちです。",
                        promptVi: "Nara là một thành phố yên tĩnh.",
                        correctAnswer: "な",
                        options: ["な", "の", "い", "を"],
                        explanation: "「しずか」 là tính từ đuôi な, khi bổ nghĩa cho danh từ 「まち」 đứng sau thì phải thêm 「な」.",
                        fullSentenceJp: "奈良は しずかな まちです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 8, index: 2, quizType: .particleFill,
                        promptJp: "きょうは あまり さむ [ ___ ]。",
                        promptVi: "Hôm nay trời không lạnh lắm.",
                        correctAnswer: "くないです",
                        options: ["くないです", "いじゃないです", "くあります", "いじゃありません"],
                        explanation: "「あまり」 luôn đi với câu phủ định. 「さむい」 là tính từ đuôi い nên chia phủ định là 「さむくないです」.",
                        fullSentenceJp: "きょうは あまり さむくないです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 8, index: 3, quizType: .sentenceMatch,
                        promptJp: "この へやは ひろいです [ ___ ]",
                        promptVi: "Căn phòng này rộng nhưng hơi tối.",
                        correctAnswer: "が、すこし くらいです。",
                        options: ["が、すこし くらいです。", "から、とても あかるいです。", "そして、きれいじゃありません。", "と、ひろいです。"],
                        explanation: "Hai vế tương phản (rộng vs tối) nối với nhau bằng liên từ 「が」 (nhưng).",
                        fullSentenceJp: "この へやは ひろいですが、すこし くらいです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 9,
                title: "Sở thích, Năng lực & Nguyên nhân (が・から)",
                summary: "Tính từ/động từ đi với trợ từ が (すき/じょうず/わかります/あります), phó từ chỉ mức độ và liên từ nguyên nhân から.",
                groupTag: g2,
                points: [
                    GrammarPoint(
                        lessonNumber: 9, index: 1,
                        title: "Sở thích & Năng lực: N が すき / じょうず / わかります",
                        structure: "N が すきです / きらいです / じょうずです / へたです。\nN が わかります / あります。",
                        meaning: "Thích / Ghét / Giỏi / Kém / Hiểu / Có N",
                        explanation: "Đối tượng của cảm xúc, sở thích, năng lực và sự sở hữu luôn dùng trợ từ 「が」 (KHÔNG dùng を).",
                        exampleJp: "わたしは にほんごが すこし わかります。サッカーが じょうずです。",
                        exampleReading: "Watashi wa Nihongo ga sukoshi wakarimasu. Sakkaa ga jouzu desu.",
                        exampleVi: "Tôi hiểu một chút tiếng Nhật. Tôi đá bóng giỏi."
                    ),
                    GrammarPoint(
                        lessonNumber: 9, index: 2,
                        title: "Phó từ chỉ mức độ (よく / だいたい / すこし / ぜんぜん)",
                        structure: "よく・だいたい・すこし (Khẳng định)\nあまり・ぜんぜん (Phủ định)",
                        meaning: "Rõ / Đại khái / Một chút / Không chút nào",
                        explanation: "Phó từ đặt trước động từ/tính từ để diễn đạt mức độ hiểu hay sở thích. 「ぜんぜん」 (hoàn toàn không) và 「あまり」 (không lắm) bắt buộc đi với thể phủ định.",
                        exampleJp: "ひらがなは だいたい わかりますが、かんじは ぜんぜん わかりません。",
                        exampleReading: "Hiragana wa daitai wakarimasu ga, kanji wa zenzen wakarimasen.",
                        exampleVi: "Hiragana tôi hiểu đại khái nhưng Kanji thì tôi hoàn toàn không hiểu."
                    ),
                    GrammarPoint(
                        lessonNumber: 9, index: 3,
                        title: "Câu chỉ nguyên nhân - kết quả: S1 から、S2",
                        structure: "S1 から、S2。\nどうして ですか。— ～から です。",
                        meaning: "Vì S1 nên S2 / Tại sao? — Vì ~",
                        explanation: "Đặt 「から」 ngay sau mệnh đề nguyên nhân S1. Để hỏi lý do dùng 「どうして」 và cuối câu trả lời thêm 「～からです」.",
                        exampleJp: "じかんが ありませんから、しんぶんを よみません。",
                        exampleReading: "Jikan ga arimasen kara, shinbun o yomimasen.",
                        exampleVi: "Vì không có thời gian nên tôi không đọc báo."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 9, index: 1, quizType: .particleFill,
                        promptJp: "ミラーさんは りょうり [ ___ ] じょうずです。",
                        promptVi: "Anh Miller nấu ăn giỏi.",
                        correctAnswer: "が",
                        options: ["が", "を", "で", "に"],
                        explanation: "Các tính từ đánh giá năng lực/sở thích (じょうず, すき, きらい) luôn đi với trợ từ 「が」.",
                        fullSentenceJp: "ミラーさんは りょうりが じょうずです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 9, index: 2, quizType: .particleFill,
                        promptJp: "お金が ありません [ ___ ]、タクシーに のりません。",
                        promptVi: "Vì không có tiền nên tôi không đi taxi.",
                        correctAnswer: "から",
                        options: ["から", "が", "まで", "も"],
                        explanation: "Dùng liên từ 「から」 nối vế nguyên nhân (không có tiền) với kết quả (không đi taxi).",
                        fullSentenceJp: "お金が ありませんから、タクシーに のりません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 9, index: 3, quizType: .sentenceMatch,
                        promptJp: "どうして きのう はやく かえりましたか。— [ ___ ]",
                        promptVi: "Tại sao hôm qua bạn về sớm vậy? — Vì có việc bận của gia đình.",
                        correctAnswer: "ようじが ありましたから。",
                        options: ["ようじが ありましたから。", "ようじが あります。", "ようじを しました。", "9じに かえりました。"],
                        explanation: "Trả lời câu hỏi 「どうして」 (Tại sao) phải kết thúc bằng 「～から」 hoặc 「～からです」.",
                        fullSentenceJp: "どうして きのう はやく かえりましたか。ようじが ありましたから。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 10,
                title: "Sự tồn tại (に・が・あります・います)",
                summary: "Phân biệt động từ tồn tại あります (đồ vật/cây cối) và います (người/động vật), vị trí phương hướng うえ/した/なか/となり/あいだ.",
                groupTag: g2,
                points: [
                    GrammarPoint(
                        lessonNumber: 10, index: 1,
                        title: "Phân biệt あります và います",
                        structure: "Địa điểm に Vật が あります。\nĐịa điểm に Người/Động vật が います。",
                        meaning: "Ở [địa điểm] có [vật/người]",
                        explanation: "「あります」 dùng cho vật vô tri và thực vật. 「います」 dùng cho người và động vật. Nơi tồn tại dùng trợ từ 「に」, đối tượng tồn tại dùng 「が」.",
                        exampleJp: "へやに つくえが あります。にわに いぬが います。",
                        exampleReading: "Heya ni tsukue ga arimasu. Niwa ni inu ga imasu.",
                        exampleVi: "Trong phòng có cái bàn. Ngoài vườn có con chó."
                    ),
                    GrammarPoint(
                        lessonNumber: 10, index: 2,
                        title: "Nhấn mạnh vị trí: N は Địa điểm に あります/います",
                        structure: "N は Địa điểm に あります / います。",
                        meaning: "N đang ở tại [địa điểm]",
                        explanation: "Khi N là chủ đề đã biết và muốn hỏi/trả lời xem N đang ở đâu, đưa N lên làm chủ ngữ với 「は」.",
                        exampleJp: "ミラーさんは かいぎしつに います。",
                        exampleReading: "Miraa-san wa kaigishitsu ni imasu.",
                        exampleVi: "Anh Miller đang ở trong phòng họp."
                    ),
                    GrammarPoint(
                        lessonNumber: 10, index: 3,
                        title: "Danh từ chỉ vị trí tương đối",
                        structure: "N の うえ / した / まえ / うしろ / なか / となり / あいだ に",
                        meaning: "Ở trên / dưới / trước / sau / trong / bên cạnh / giữa N",
                        explanation: "Kết hợp danh từ với 「の」 và từ chỉ vị trí, sau đó gắn trợ từ 「に」.",
                        exampleJp: "つくえの うえに パソコンが あります。",
                        exampleReading: "Tsukue no ue ni pasokon ga arimasu.",
                        exampleVi: "Ở trên bàn có máy tính xách tay."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 10, index: 1, quizType: .particleFill,
                        promptJp: "きょうしつ [ ___ ] せんせいが います。",
                        promptVi: "Trong lớp học có giáo viên.",
                        correctAnswer: "に",
                        options: ["に", "で", "を", "へ"],
                        explanation: "Động từ chỉ sự tồn tại (います/あります) dùng trợ từ 「に」 đánh dấu nơi chốn.",
                        fullSentenceJp: "きょうしつに せんせいが います。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 10, index: 2, quizType: .particleFill,
                        promptJp: "あそこに ねこが [ ___ ]。",
                        promptVi: "Ở đằng kia có một con mèo.",
                        correctAnswer: "います",
                        options: ["います", "あります", "します", "いきます"],
                        explanation: "「ねこ」 (con mèo) là động vật nên dùng động từ tồn tại 「います」 (không dùng あります).",
                        fullSentenceJp: "あそこに ねこが います。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 10, index: 3, quizType: .sentenceMatch,
                        promptJp: "ぎんこうは どこに ありますか。— [ ___ ]",
                        promptVi: "Ngân hàng ở đâu vậy? — Ở giữa bưu điện và siêu thị.",
                        correctAnswer: "ゆうびんきょくと スーパーの あいだに あります。",
                        options: ["ゆうびんきょくと スーパーの あいだに あります。", "ゆうびんきょくの なかに います。", "スーパーで あいだに あります。", "ゆうびんきょくと スーパーが あります。"],
                        explanation: "Giữa A và B dùng mẫu 「A と B の あいだに あります」.",
                        fullSentenceJp: "ぎんこうは ゆうびんきょくと スーパーの あいだに あります。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 11 - 15
    private static func buildLessons11To15() -> [GrammarLesson] {
        let g2 = groupTags[1]
        let g3 = groupTags[2]
        return [
            GrammarLesson(
                lessonNumber: 11,
                title: "Lượng từ & Tần suất (つ・にん・にかい・かかります)",
                summary: "Cách đếm đồ vật (～つ, ～まい, ～だい), đếm người (～にん), tần suất (～に ～かい) và thời gian/tiền tiêu tốn かかります.",
                groupTag: g2,
                points: [
                    GrammarPoint(
                        lessonNumber: 11, index: 1,
                        title: "Lượng từ đặt trước động từ (Không có trợ từ)",
                        structure: "N を [Lượng từ] Vます。",
                        meaning: "Làm V bao nhiêu [số lượng] N",
                        explanation: "Lượng từ (ひとつ, さんにん, 2まい, 3だい...) đứng ngay sau trợ từ 「を/が」 và trước động từ mà KHÔNG thêm trợ từ ở giữa.",
                        exampleJp: "りんごを よっつ 買いました。がくせいが 5にん います。",
                        exampleReading: "Ringo o yottsu kaimashita. Gakusei ga go-nin imasu.",
                        exampleVi: "Tôi đã mua 4 quả táo. Có 5 học sinh."
                    ),
                    GrammarPoint(
                        lessonNumber: 11, index: 2,
                        title: "Tần suất: Khoảng thời gian に ～かい V",
                        structure: "Khoảng thời gian に [Số lần] かい Vます。",
                        meaning: "Trong [khoảng thời gian] làm V mấy lần",
                        explanation: "Trợ từ 「に」 biểu thị tần suất lặp lại hành động trong một đơn vị thời gian (1しゅうかんに 2かい = 1 tuần 2 lần).",
                        exampleJp: "1か月に 2かい えいがを みます。",
                        exampleReading: "Ikkagetsu ni ni-kai eiga o mimasu.",
                        exampleVi: "Một tháng tôi xem phim 2 lần."
                    ),
                    GrammarPoint(
                        lessonNumber: 11, index: 3,
                        title: "Thời gian / Chi phí tiêu tốn: かかります",
                        structure: "Khoảng thời gian / Số tiền が かかります。",
                        meaning: "Mất / Tốn [thời gian hoặc tiền bạc]",
                        explanation: "Động từ 「かかります」 dùng cho việc tốn thời gian hoặc chi phí. Có thể kết hợp 「どのくらい」 để hỏi mất bao lâu.",
                        exampleJp: "うちから えきまで じてんしゃで 10ぷん かかります。",
                        exampleReading: "Uchi kara eki made jitensha de juppun kakarimasu.",
                        exampleVi: "Từ nhà đến ga đi bằng xe đạp mất 10 phút."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 11, index: 1, quizType: .particleFill,
                        promptJp: "1しゅうかん [ ___ ] 3かい テニスを します。",
                        promptVi: "Một tuần tôi chơi tennis 3 lần.",
                        correctAnswer: "に",
                        options: ["に", "で", "を", "へ"],
                        explanation: "Mẫu chỉ tần suất dùng trợ từ 「に」 giữa đơn vị thời gian và số lần: 「Khoảng thời gian に ～かい」.",
                        fullSentenceJp: "1しゅうかんに 3かい テニスを します。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 11, index: 2, quizType: .particleFill,
                        promptJp: "きってを [ ___ ] 買いました。",
                        promptVi: "Tôi đã mua 5 con tem.",
                        correctAnswer: "5まい",
                        options: ["5まい", "5だい", "5にん", "5さつ"],
                        explanation: "Tem thư, giấy, vé, áo sơ mi là vật mỏng dẹt nên dùng đơn vị đếm 「～まい」.",
                        fullSentenceJp: "きってを 5まい 買いました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 11, index: 3, quizType: .sentenceMatch,
                        promptJp: "東京から 大阪まで しんかんせんで どのくらい [ ___ ]",
                        promptVi: "Từ Tokyo đến Osaka đi bằng Shinkansen mất khoảng bao lâu?",
                        correctAnswer: "かかりますか。",
                        options: ["かかりますか。", "いますか。", "ありますか。", "しますか。"],
                        explanation: "Hỏi mất bao lâu thời gian hoặc bao nhiêu chi phí dùng động từ 「かかりますか」.",
                        fullSentenceJp: "東京から 大阪まで しんかんせんで どのくらい かかりますか。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 12,
                title: "Quá khứ Tính từ & So sánh (より・いちばん)",
                summary: "Chia quá khứ của Danh từ và Tính từ い/な; so sánh hơn より, so sánh lựa chọn どちら và so sánh nhất いちばん.",
                groupTag: g2,
                points: [
                    GrammarPoint(
                        lessonNumber: 12, index: 1,
                        title: "Thì quá khứ của Danh từ và Tính từ い/な",
                        structure: "N / A(な): でした / じゃありませんでした\nA(い): ～かったです / ～くなかったです",
                        meaning: "Đã từng / Đã không là (trong quá khứ)",
                        explanation: "Danh từ và Tính từ な đổi です -> でした. Tính từ い bỏ い thêm かったです (khẳng định) hoặc くなかったです (phủ định). Ngoại lệ: いい -> よかったです.",
                        exampleJp: "きのうは あめでした。テストは むずかしくなかったです。",
                        exampleReading: "Kinou wa ame deshita. Tesuto wa muzukashikunakatta desu.",
                        exampleVi: "Hôm qua trời mưa. Bài kiểm tra đã không khó."
                    ),
                    GrammarPoint(
                        lessonNumber: 12, index: 2,
                        title: "So sánh hơn & So sánh lựa chọn",
                        structure: "N1 は N2 より A です。\nN1 と N2 と どちらが A ですか。",
                        meaning: "N1 thì A hơn N2 / Giữa N1 và N2 cái nào A hơn?",
                        explanation: "「より」 đứng sau đối tượng làm mốc so sánh. Khi trả lời câu hỏi 「どちらが」, dùng 「N の ほうが A です」.",
                        exampleJp: "くるまは でんしゃより はやいですか。— でんしゃの ほうが はやいです。",
                        exampleReading: "Kuruma wa densha yori hayai desu ka. Densha no hou ga hayai desu.",
                        exampleVi: "Ô tô nhanh hơn tàu điện phải không? — Tàu điện nhanh hơn."
                    ),
                    GrammarPoint(
                        lessonNumber: 12, index: 3,
                        title: "So sánh nhất: N1 の なかで N2 が いちばん A です",
                        structure: "Nhóm N1 の なかで N2 が いちばん A です。",
                        meaning: "Trong [nhóm N1] thì N2 là A nhất",
                        explanation: "Dùng để chỉ sự vượt trội nhất trong một tập hợp từ 3 đối tượng trở lên. Nghi vấn từ dùng: だれ / どこ / いつ / なに.",
                        exampleJp: "スポーツの なかで サッカーが いちばん おもしろいです。",
                        exampleReading: "Supootsu no naka de sakkaa ga ichiban omoshiroi desu.",
                        exampleVi: "Trong các môn thể thao thì bóng đá thú vị nhất."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 12, index: 1, quizType: .particleFill,
                        promptJp: "飛行機は しんかんせん [ ___ ] はやいです。",
                        promptVi: "Máy bay nhanh hơn tàu Shinkansen.",
                        correctAnswer: "より",
                        options: ["より", "ほど", "から", "まで"],
                        explanation: "Trong câu so sánh hơn 「N1 は N2 より A です」, dùng trợ từ 「より」 sau N2.",
                        fullSentenceJp: "飛行機は しんかんせんより はやいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 12, index: 2, quizType: .particleFill,
                        promptJp: "きのうの パーティーは とても たのし [ ___ ]。",
                        promptVi: "Bữa tiệc hôm qua đã rất vui.",
                        correctAnswer: "かったです",
                        options: ["かったです", "いでした", "くなかった", "でした"],
                        explanation: "「たのしい」 là tính từ đuôi い, chia quá khứ khẳng định bỏ い thêm 「かったです」.",
                        fullSentenceJp: "きのうの パーティーは とても たのしかったです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 12, index: 3, quizType: .sentenceMatch,
                        promptJp: "きせつの なかで いつが いちばん すきですか。— [ ___ ]",
                        promptVi: "Trong các mùa bạn thích nhất khi nào? — Tôi thích mùa thu nhất.",
                        correctAnswer: "あきが いちばん すきです。",
                        options: ["あきが いちばん すきです。", "あきの ほうが すきです。", "あきより すきです。", "あきも すきです。"],
                        explanation: "Trả lời câu hỏi so sánh nhất (いちばん) giữ nguyên cấu trúc 「N が いちばん A です」.",
                        fullSentenceJp: "きせつの なかで あきが いちばん すきです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 13,
                title: "Mong muốn & Mục đích (ほしい・たい・に いきます)",
                summary: "Diễn đạt muốn có đồ vật N が ほしい, muốn làm gì Vたい, và đi đâu để làm gì Vます(bỏ ます) に いきます.",
                groupTag: g2,
                points: [
                    GrammarPoint(
                        lessonNumber: 13, index: 1,
                        title: "Muốn có vật: N が ほしいです",
                        structure: "N が ほしいです / ほしくないです。",
                        meaning: "Muốn có N",
                        explanation: "「ほしい」 là tính từ đuôi い, biểu thị mong muốn sở hữu của bản thân người nói. Đối tượng mong muốn đi với trợ từ 「が」.",
                        exampleJp: "いま あたらしい くるまが ほしいです。",
                        exampleReading: "Ima atarashii kuruma ga hoshii desu.",
                        exampleVi: "Bây giờ tôi muốn có một chiếc ô tô mới."
                    ),
                    GrammarPoint(
                        lessonNumber: 13, index: 2,
                        title: "Muốn làm gì: Vます(bỏ ます) たいです",
                        structure: "V(bỏ ます) + たいです / たくないです。",
                        meaning: "Muốn làm V",
                        explanation: "Chia tương tự tính từ đuôi い. Có thể dùng trợ từ 「を」 hoặc 「が」 trước Vたい (trừ các động từ chuyển động như いきます luôn giữ へ/に).",
                        exampleJp: "日本へ いきたいです。すしを (が) たべたいです。",
                        exampleReading: "Nihon e ikitai desu. Sushi o (ga) tabetai desu.",
                        exampleVi: "Tôi muốn đi Nhật. Tôi muốn ăn sushi."
                    ),
                    GrammarPoint(
                        lessonNumber: 13, index: 3,
                        title: "Mục đích di chuyển: Địa điểm へ V(bỏ ます)/N に いきます",
                        structure: "Địa điểm へ [V(bỏ ます) / Danh động từ] に いきます / きます / かえります。",
                        meaning: "Đi / đến / về [địa điểm] để làm V",
                        explanation: "Trợ từ 「に」 đặt sau hành động mục đích (bỏ ます) hoặc danh từ sự kiện (かいもの, しょくじ) trước động từ di chuyển.",
                        exampleJp: "デパートへ くつを 買いに いきます。",
                        exampleReading: "Depaato e kutsu o kai ni ikimasu.",
                        exampleVi: "Tôi đi đến trung tâm thương mại để mua giày."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 13, index: 1, quizType: .particleFill,
                        promptJp: "日本へ けいざいの べんきょう [ ___ ] きました。",
                        promptVi: "Tôi đã đến Nhật để học kinh tế.",
                        correctAnswer: "に",
                        options: ["に", "を", "で", "と"],
                        explanation: "Dùng trợ từ 「に」 sau danh từ chỉ mục đích (べんきょう) trước động từ di chuyển (きました).",
                        fullSentenceJp: "日本へ けいざいの べんきょうに きました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 13, index: 2, quizType: .particleFill,
                        promptJp: "のどが かわきましたから、なにか つめたい ものを [ ___ ]。",
                        promptVi: "Vì khát nước nên tôi muốn uống cái gì đó mát lạnh.",
                        correctAnswer: "のみたいです",
                        options: ["のみたいです", "ほしいです", "のみます", "のみました"],
                        explanation: "Muốn thực hiện hành động uống dùng V(bỏ ます) + たいです -> 「のみたいです」.",
                        fullSentenceJp: "のどが かわきましたから、なにか つめたい ものを のみたいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 13, index: 3, quizType: .sentenceMatch,
                        promptJp: "なつやすみに どこへ いきたいですか。— [ ___ ]",
                        promptVi: "Kỳ nghỉ hè bạn muốn đi đâu? — Tôi muốn đi Hokkaido.",
                        correctAnswer: "ほっかいどうへ いきたいです。",
                        options: ["ほっかいどうへ いきたいです。", "ほっかいどうが ほしいです。", "ほっかいどうに います。", "ほっかいどうへ いきました。"],
                        explanation: "Câu hỏi dùng 「いきたいですか」 (muốn đi) nên câu trả lời tương ứng là 「ほっかいどうへ いきたいです」.",
                        fullSentenceJp: "なつやすみに ほっかいどうへ いきたいです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 14,
                title: "Động từ thể て (て形・ください・ています)",
                summary: "Quy tắc chia động từ thể て cả 3 nhóm, câu nhờ vả Vて ください, đang diễn ra Vて います và đề nghị giúp đỡ Vましょうか.",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 14, index: 1,
                        title: "Quy tắc chia Động từ thể て (Nhóm I, II, III)",
                        structure: "Nhóm I: い・ち・り -> って / み・び・に -> んで / き -> いて (Biệt lệ: いきます->いって) / ぎ -> いで / し -> して\nNhóm II: Bỏ ます + て (たべます -> たべて)\nNhóm III: きます -> きて / します -> して",
                        meaning: "Cách biến đổi từ thể ます sang thể て",
                        explanation: "Đây là nền tảng quan trọng nhất trong sơ cấp N5 để ghép với rất nhiều mẫu câu ngữ pháp phía sau.",
                        exampleJp: "かきます -> かいて、のみます -> のんで、みます -> みて",
                        exampleReading: "Kakimasu -> kaite, nomimasu -> nonde, mimasu -> mite",
                        exampleVi: "Viết -> kaite, Uống -> nonde, Xem -> mite"
                    ),
                    GrammarPoint(
                        lessonNumber: 14, index: 2,
                        title: "Yêu cầu, nhờ vả lịch sự: Vて ください",
                        structure: "Vて ください。",
                        meaning: "Xin hãy làm V",
                        explanation: "Dùng để đề nghị, nhờ vả hoặc hướng dẫn người nghe làm một việc gì đó một cách lịch sự.",
                        exampleJp: "すみません、ちょっと てつだって ください。",
                        exampleReading: "Sumimasen, chotto tetsudatte kudasai.",
                        exampleVi: "Xin lỗi, hãy giúp tôi một chút."
                    ),
                    GrammarPoint(
                        lessonNumber: 14, index: 3,
                        title: "Hành động đang diễn ra & Đề nghị giúp đỡ",
                        structure: "Vて います (Đang làm V)\nV(bỏ ます) ましょうか (Tôi làm V giúp bạn nhé?)",
                        meaning: "Đang diễn ra ngay lúc nói / Để tôi làm giúp bạn nhé",
                        explanation: "「Vて います」 diễn tả hành động đang tiếp diễn tại thời điểm nói. 「Vましょうか」 là lời ngỏ ý giúp đỡ.",
                        exampleJp: "いま あめが ふって います。かさを かしましょうか。",
                        exampleReading: "Ima ame ga futte imasu. Kasa o kashimashou ka.",
                        exampleVi: "Trời đang mưa đấy. Để tôi cho bạn mượn ô nhé?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 14, index: 1, quizType: .particleFill,
                        promptJp: "ここに お名前を [ ___ ] ください。",
                        promptVi: "Xin hãy viết tên vào đây.",
                        correctAnswer: "書いて",
                        options: ["書いて", "書って", "書んで", "書きて"],
                        explanation: "「かきます」(viết) thuộc Nhóm I đuôi き -> chia thể て là 「かいて (書いて)」.",
                        fullSentenceJp: "ここに お名前を 書いて ください。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 14, index: 2, quizType: .particleFill,
                        promptJp: "ミラーさんは いま コーヒーを [ ___ ]。",
                        promptVi: "Anh Miller hiện đang uống cà phê.",
                        correctAnswer: "のんで います",
                        options: ["のんで います", "のいて います", "のみて います", "のって います"],
                        explanation: "「のみます」 (Nhóm I đuôi み) -> thể て là 「のんで」. Đang uống là 「のんで います」.",
                        fullSentenceJp: "ミラーさんは いま コーヒーを のんで います。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 14, index: 3, quizType: .sentenceMatch,
                        promptJp: "にもつが おもそうですね。[ ___ ] — すみません、おねがいします。",
                        promptVi: "Hành lý có vẻ nặng nhỉ. Để tôi mang giúp nhé? — Cảm ơn, phiền bạn nhé.",
                        correctAnswer: "もちましょうか。",
                        options: ["もちましょうか。", "もって ください。", "もって います。", "もちたいですか。"],
                        explanation: "Mở lời đề nghị giúp đỡ người khác dùng cấu trúc 「Vましょうか」.",
                        fullSentenceJp: "にもつが おもそうですね。もちましょうか。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 15,
                title: "Xin phép, Cấm đoán & Trạng thái (てもいい・てはいけない)",
                summary: "Xin phép Vて も いいですか, cấm đoán Vて は いけません và Vて います chỉ trạng thái kéo dài/nghề nghiệp.",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 15, index: 1,
                        title: "Xin phép & Cho phép: Vて も いいですか",
                        structure: "Vて も いいです / いいですか。",
                        meaning: "Được phép làm V / Tôi làm V có được không?",
                        explanation: "Dùng khi muốn xin phép ai đó làm việc gì, hoặc cho phép người khác thực hiện hành động.",
                        exampleJp: "ここで しゃしんを とっても いいですか。— ええ、いいですよ。",
                        exampleReading: "Koko de shashin o totte mo ii desu ka. Ee, ii desu yo.",
                        exampleVi: "Tôi chụp ảnh ở đây có được không? — Vâng, được chứ."
                    ),
                    GrammarPoint(
                        lessonNumber: 15, index: 2,
                        title: "Cấm đoán: Vて は いけません",
                        structure: "Vて は いけません。",
                        meaning: "Không được phép làm V / Cấm làm V",
                        explanation: "Biểu thị quy tắc, luật lệ cấm đoán hoặc từ chối thẳng lời xin phép (lưu ý: từ chối lịch sự thường dùng 「すみません、ちょっと…」).",
                        exampleJp: "びょういんで たばこを すっては いけません。",
                        exampleReading: "Byouin de tabako o sutte wa ikemasen.",
                        exampleVi: "Không được phép hút thuốc trong bệnh viện."
                    ),
                    GrammarPoint(
                        lessonNumber: 15, index: 3,
                        title: "Vて います chỉ Trạng thái / Nghề nghiệp",
                        structure: "しっています / すんでいます / けっこんしています / もっています",
                        meaning: "Biết / Đang sống ở / Đã kết hôn / Có giữ",
                        explanation: "Với một số động từ như biết (しる), sống (すむ), kết hôn (けっこんする), làm việc (つとめる), thể ています diễn tả trạng thái kết quả duy trì đến hiện tại. Lưu ý phủ định của しっています là 「しりません」.",
                        exampleJp: "わたしは ホーチミンに すんでいます。けっこんしています。",
                        exampleReading: "Watashi wa Hoochimin ni sunde imasu. Kekkon shite imasu.",
                        exampleVi: "Tôi đang sống ở TP. Hồ Chí Minh. Tôi đã kết hôn rồi."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 15, index: 1, quizType: .particleFill,
                        promptJp: "この へやに はいって [ ___ ] いいですか。",
                        promptVi: "Tôi vào căn phòng này có được không?",
                        correctAnswer: "も",
                        options: ["も", "は", "が", "を"],
                        explanation: "Mẫu câu xin phép là 「Vて も いいですか」 dùng trợ từ 「も」.",
                        fullSentenceJp: "この へやに はいっても いいですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 15, index: 2, quizType: .particleFill,
                        promptJp: "としょかんで おおきい こえで はなして [ ___ ] いけません。",
                        promptVi: "Ở thư viện không được phép nói chuyện lớn tiếng.",
                        correctAnswer: "は",
                        options: ["は", "も", "が", "に"],
                        explanation: "Mẫu câu cấm đoán là 「Vて は いけません」 dùng trợ từ 「は」.",
                        fullSentenceJp: "としょかんで おおきい こえで はなしては いけません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 15, index: 3, quizType: .sentenceMatch,
                        promptJp: "ミラーさんの でんわばんごうを しっていますか。— いいえ、[ ___ ]",
                        promptVi: "Bạn có biết số điện thoại của anh Miller không? — Không, tôi không biết.",
                        correctAnswer: "しりません。",
                        options: ["しりません。", "しって いません。", "しりませんでした。", "しっても いいです。"],
                        explanation: "Lưu ý đặc biệt của Minna Bài 15: phủ định của 「しっています」 (biết) là 「しりません」 (KHÔNG dùng しっていません).",
                        fullSentenceJp: "いいえ、しりません。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 16 - 20
    private static func buildLessons16To20() -> [GrammarLesson] {
        let g3 = groupTags[2]
        let g4 = groupTags[3]
        return [
            GrammarLesson(
                lessonNumber: 16,
                title: "Nối câu với thể て, Tính từ & Danh từ (てから)",
                summary: "Nối chuỗi hành động V1て、V2て, sau khi V1 thì V2 (V1て から), nối tính từ い (～くて) và tính từ な / danh từ (～で).",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 16, index: 1,
                        title: "Nối chuỗi hành động: V1て、V2て & V1て から、V2",
                        structure: "V1て、V2て、V3ます。\nV1て から、V2ます。",
                        meaning: "Làm V1 rồi V2 rồi V3 / Sau khi làm V1 thì làm V2",
                        explanation: "Dùng thể て để liệt kê các hành động xảy ra theo trình tự thời gian. Thì của cả câu phụ thuộc vào động từ cuối cùng. 「V1て から」 nhấn mạnh sau khi kết thúc V1 mới tới V2.",
                        exampleJp: "朝 7じに おきて、朝ごはんを たべて、かいしゃへ いきます。",
                        exampleReading: "Asa shichi-ji ni okite, asagohan o tabete, kaisha e ikimasu.",
                        exampleVi: "Buổi sáng tôi dậy lúc 7 giờ, ăn sáng rồi đi công ty."
                    ),
                    GrammarPoint(
                        lessonNumber: 16, index: 2,
                        title: "Nối Tính từ & Danh từ: A(い)くて / A(な)で / Nで",
                        structure: "A(い) (bỏ い) + くて、～\nA(な) / Danh từ + で、～",
                        meaning: "Vừa A vừa... / Là N và...",
                        explanation: "Khi nối 2 tính từ hoặc danh từ trong một câu: tính từ đuôi い đổi thành くて (いい -> よくて), tính từ な và danh từ thêm で.",
                        exampleJp: "サントスさんは わかくて、げんきです。カリナさんは きれいで、しんせつです。",
                        exampleReading: "Santosu-san wa wakakute, genki desu. Karina-san wa kirei de, shinsetsu desu.",
                        exampleVi: "Anh Santos trẻ trung và khỏe mạnh. Chị Karina xinh đẹp và tốt bụng."
                    ),
                    GrammarPoint(
                        lessonNumber: 16, index: 3,
                        title: "Mô tả đặc điểm bộ phận: N1 は N2 が A です",
                        structure: "N1 は N2 が A(い/な) です。",
                        meaning: "N1 thì có đặc điểm N2 như thế nào",
                        explanation: "N1 là chủ thể lớn (con người, thành phố...), N2 là bộ phận hoặc thuộc tính cụ thể của N1 đi với trợ từ 「が」.",
                        exampleJp: "マリアさんは かみが ながいです。",
                        exampleReading: "Maria-san wa kami ga nagai desu.",
                        exampleVi: "Chị Maria có mái tóc dài."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 16, index: 1, quizType: .particleFill,
                        promptJp: "この レストランは やす [ ___ ]、おいしいです。",
                        promptVi: "Nhà hàng này vừa rẻ vừa ngon.",
                        correctAnswer: "くて",
                        options: ["くて", "いで", "く", "で"],
                        explanation: "「やすい」 là tính từ đuôi い, khi nối câu thì bỏ い thêm 「くて」 -> 「やすくて」.",
                        fullSentenceJp: "この レストランは やすくて、おいしいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 16, index: 2, quizType: .particleFill,
                        promptJp: "しごとが おわって [ ___ ]、ともだちと のみに いきます。",
                        promptVi: "Sau khi kết thúc công việc, tôi sẽ đi uống cùng bạn bè.",
                        correctAnswer: "から",
                        options: ["から", "まで", "より", "ほど"],
                        explanation: "Mẫu câu 「Vて から、V2」 diễn tả hành động V2 diễn ra sau khi V1 hoàn tất.",
                        fullSentenceJp: "しごとが おわってから、ともだちと のみに いきます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 16, index: 3, quizType: .sentenceMatch,
                        promptJp: "大阪は どんな まちですか。— [ ___ ]",
                        promptVi: "Osaka là thành phố như thế nào? — Là thành phố náo nhiệt và đồ ăn ngon.",
                        correctAnswer: "にぎやかで、たべものが おいしい まちです。",
                        options: ["にぎやかで、たべものが おいしい まちです。", "にぎやかくて、たべものが おいしい まちです。", "にぎやかなで、たべものが おいしい まちです。", "にぎやか、たべものを おいしい まちです。"],
                        explanation: "「にぎやか」 là tính từ đuôi な nên khi nối vế câu phải đổi thành 「にぎやかで」.",
                        fullSentenceJp: "大阪は にぎやかで、たべものが おいしい まちです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 17,
                title: "Động từ thể ない (ないでください・なければなりません)",
                summary: "Quy tắc chia thể ない cả 3 nhóm, yêu cầu đừng làm (ないでください), phải làm (なければなりません) và không cần làm (なくてもいい).",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 17, index: 1,
                        title: "Quy tắc chia Động từ thể ない (ない形)",
                        structure: "Nhóm I: Hàng い -> Hàng あ + ない (Biệt lệ: います->わない, あります->ない)\nNhóm II: Bỏ ます + ない (たべます -> たべない)\nNhóm III: きます -> こない / します -> しない",
                        meaning: "Cách biến đổi từ thể ます sang thể ない",
                        explanation: "Với Nhóm I kết thúc bằng chữ い (như かいます, すいます) đổi thành わ + ない (かわない, すわない), không phải あ.",
                        exampleJp: "かきます -> かかない、かいます -> かわない、きます -> こない",
                        exampleReading: "Kakimasu -> kakanai, kaimasu -> kawanai, kimasu -> konai",
                        exampleVi: "Viết -> không viết, Mua -> không mua, Đến -> không đến"
                    ),
                    GrammarPoint(
                        lessonNumber: 17, index: 2,
                        title: "Đề nghị đừng làm: Vないで ください",
                        structure: "Vない + で ください。",
                        meaning: "Xin đừng làm V",
                        explanation: "Dùng để yêu cầu hoặc nhắc nhở người nghe không làm một hành động nào đó.",
                        exampleJp: "ここで しゃしんを とらないで ください。",
                        exampleReading: "Koko de shashin o toranaide kudasai.",
                        exampleVi: "Xin đừng chụp ảnh ở đây."
                    ),
                    GrammarPoint(
                        lessonNumber: 17, index: 3,
                        title: "Bắt buộc & Không cần thiết",
                        structure: "V(bỏ い) ければ なりません (Phải làm)\nV(bỏ い) くても いいです (Không cần làm cũng được)",
                        meaning: "Phải làm V / Không cần phải làm V",
                        explanation: "Từ thể ない bỏ 「い」 ghép với 「ければなりません」 nghĩa là bắt buộc phải làm; ghép với 「くてもいいです」 nghĩa là không cần thiết.",
                        exampleJp: "くすりを のまなければ なりません。あしたは こなくても いいです。",
                        exampleReading: "Kusuri o nomanakereba narimasen. Ashita wa konakute mo ii desu.",
                        exampleVi: "Phải uống thuốc. Ngày mai không cần đến cũng được."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 17, index: 1, quizType: .particleFill,
                        promptJp: "あぶないですから、きかいを [ ___ ] ください。",
                        promptVi: "Vì nguy hiểm nên xin đừng chạm vào máy móc.",
                        correctAnswer: "さわらないで",
                        options: ["さわらないで", "さわって", "さわりないで", "さわらない"],
                        explanation: "「さわります」 (Nhóm I đuôi り) -> thể ない là 「さわらない」 -> đừng chạm là 「さわらないで ください」.",
                        fullSentenceJp: "あぶないですから、きかいを さわらないで ください。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 17, index: 2, quizType: .particleFill,
                        promptJp: "テストが ありますから、べんきょう [ ___ ] なりません。",
                        promptVi: "Vì có bài kiểm tra nên phải học bài.",
                        correctAnswer: "しなければ",
                        options: ["しなければ", "しないでは", "しなくても", "しては"],
                        explanation: "「べんきょうします」 -> thể ない là 「しない」 -> bỏ い thêm ければなりません: 「しなければ なりません」.",
                        fullSentenceJp: "テストが ありますから、べんきょうしなければ なりません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 17, index: 3, quizType: .sentenceMatch,
                        promptJp: "くつを ぬがなければ なりませんか。— いいえ、[ ___ ]",
                        promptVi: "Có phải cởi giày không ạ? — Không, bạn không cần phải cởi đâu.",
                        correctAnswer: "ぬがなくても いいです。",
                        options: ["ぬがなくても いいです。", "ぬいでは いけません。", "ぬがないで ください。", "ぬがなければ なりません。"],
                        explanation: "Trả lời phủ định cho câu hỏi 'có phải làm không' dùng mẫu 'không cần làm cũng được': 「Vなくても いいです」.",
                        fullSentenceJp: "いいえ、ぬがなくても いいです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 18,
                title: "Động từ thể từ điển (辞書形・ことができます・まえに)",
                summary: "Quy tắc chia thể từ điển (Vる), diễn tả khả năng (ことができます), sở thích (ことです) và hành động trước đó (まえに).",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 18, index: 1,
                        title: "Quy tắc chia Thể từ điển (辞書形 / Vる)",
                        structure: "Nhóm I: Hàng い -> Hàng う (かきます -> かく, のみます -> のむ)\nNhóm II: Bỏ ます + る (たべます -> たべる)\nNhóm III: きます -> くる / します -> する",
                        meaning: "Dạng nguyên mẫu tra từ điển của động từ",
                        explanation: "Thể từ điển là dạng nguyên thể dùng để tra từ điển và ghép với nhiều mẫu câu trung-sơ cấp.",
                        exampleJp: "はなします -> はなす、みます -> みる、します -> する",
                        exampleReading: "Hanashimasu -> hanasu, mimasu -> miru, shimasu -> suru",
                        exampleVi: "Nói -> hanasu, Xem -> miru, Làm -> suru"
                    ),
                    GrammarPoint(
                        lessonNumber: 18, index: 2,
                        title: "Khả năng & Sở thích: ことができます / ことです",
                        structure: "[Vる / Danh từ] ことが できます。\nしゅみは [Vる こと / Danh từ] です。",
                        meaning: "Có thể làm V / Sở thích là...",
                        explanation: "Thêm 「こと」 sau động từ thể từ điển (Vる) để danh từ hóa động từ đó.",
                        exampleJp: "わたしは かんじを よむことが できます。しゅみは えいがを みることです。",
                        exampleReading: "Watashi wa kanji o yomu koto ga dekimasu. Shumi wa eiga o miru koto desu.",
                        exampleVi: "Tôi có thể đọc được Kanji. Sở thích của tôi là xem phim."
                    ),
                    GrammarPoint(
                        lessonNumber: 18, index: 3,
                        title: "Trước khi làm gì: Vる / Nの / Thời gian まえに",
                        structure: "V1る + まえに、V2。\nN の + まえに、V2。\nKhoảng thời gian + まえに、V2。",
                        meaning: "Trước khi làm V1 / Trước N / Cách đây [khoảng thời gian]",
                        explanation: "Luôn dùng V1 ở thể từ điển (Vる) kể cả khi V2 ở thì quá khứ.",
                        exampleJp: "ねる まえに、にっきを かきます。しょくじの まえに、てを あらいます。",
                        exampleReading: "Neru mae ni, nikki o kakimasu. Shokuji no mae ni, te o araimasu.",
                        exampleVi: "Trước khi ngủ tôi viết nhật ký. Trước bữa ăn tôi rửa tay."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 18, index: 1, quizType: .particleFill,
                        promptJp: "ミラーさんは ピアノを [ ___ ] ことが できます。",
                        promptVi: "Anh Miller có thể chơi đàn piano.",
                        correctAnswer: "ひく",
                        options: ["ひく", "ひき", "ひいて", "ひいた"],
                        explanation: "Trước 「ことが できます」, động từ phải chia về thể từ điển (Vる): 「ひきます」 -> 「ひく」.",
                        fullSentenceJp: "ミラーさんは ピアノを ひくことが できます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 18, index: 2, quizType: .particleFill,
                        promptJp: "日本へ くる [ ___ ]、日本語を べんきょうしました。",
                        promptVi: "Trước khi đến Nhật Bản, tôi đã học tiếng Nhật.",
                        correctAnswer: "まえに",
                        options: ["まえに", "あとで", "から", "ときに"],
                        explanation: "Mẫu câu 「V1る まえに、V2」 (Trước khi V1 thì V2), lưu ý V1 luôn giữ nguyên ở thể từ điển (くる).",
                        fullSentenceJp: "日本へ くる まえに、日本語を べんきょうしました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 18, index: 3, quizType: .sentenceMatch,
                        promptJp: "ワットさんの しゅみは なんですか。— [ ___ ]",
                        promptVi: "Sở thích của thầy Watt là gì? — Là sưu tầm tem.",
                        correctAnswer: "きってを あつめる こと です。",
                        options: ["きってを あつめる こと です。", "きってを あつめて います。", "きってを あつめる ことが できます。", "きってが ほしいです。"],
                        explanation: "Hỏi sở thích có hành động dùng 「Vる こと です」 (việc sưu tầm tem).",
                        fullSentenceJp: "ワットさんの しゅみは きってを あつめる ことです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 19,
                title: "Động từ thể た (た形・ことがあります・たり～たり)",
                summary: "Quy tắc chia thể た, kinh nghiệm đã từng (Vた ことがあります), liệt kê hành động tiêu biểu (Vたり～たりします) và sự biến đổi なります.",
                groupTag: g3,
                points: [
                    GrammarPoint(
                        lessonNumber: 19, index: 1,
                        title: "Quy tắc chia Động từ thể た (た形) & Vた ことが あります",
                        structure: "Chia giống hệt thể て, chỉ đổi て -> た / で -> だ\nVた + ことが あります / ありません",
                        meaning: "Đã từng làm V (kinh nghiệm trong quá khứ)",
                        explanation: "Thể た dùng để nói về trải nghiệm từng có trong đời (không nhấn mạnh thời điểm cụ thể). Ví dụ: かいて->かいた, のんで->のんだ, みて->みた.",
                        exampleJp: "わたしは すもうを みた ことが あります。",
                        exampleReading: "Watashi wa sumou o mita koto ga arimasu.",
                        exampleVi: "Tôi đã từng xem đấu vật Sumo."
                    ),
                    GrammarPoint(
                        lessonNumber: 19, index: 2,
                        title: "Liệt kê hành động tiêu biểu: V1たり、V2たり します",
                        structure: "V1(thể た)り、V2(thể た)り します / しました。",
                        meaning: "Nào là làm V1, nào là làm V2...",
                        explanation: "Liệt kê một vài hành động tiêu biểu trong số nhiều hoạt động, không nhất thiết theo trình tự thời gian. Chia thì ở động từ 「します」 cuối câu.",
                        exampleJp: "にちようびは そうじしたり、せんたくしたり します。",
                        exampleReading: "Nichiyoubi wa souji shitari, sentaku shitari shimasu.",
                        exampleVi: "Chủ nhật tôi nào là dọn dẹp, nào là giặt giũ."
                    ),
                    GrammarPoint(
                        lessonNumber: 19, index: 3,
                        title: "Sự biến đổi trạng thái: なります",
                        structure: "A(い) (bỏ い) + く なります\nA(な) / Danh từ + に なります",
                        meaning: "Trở nên / Trở thành...",
                        explanation: "Diễn tả sự thay đổi tự nhiên hoặc chuyển biến trạng thái (ấm lên, khỏe lên, thành bác sĩ...).",
                        exampleJp: "さむく なりました。むすこは いしゃに なりました。",
                        exampleReading: "Samuku narimashita. Musuko wa isha ni narimashita.",
                        exampleVi: "Trời đã trở lạnh rồi. Con trai tôi đã trở thành bác sĩ."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 19, index: 1, quizType: .particleFill,
                        promptJp: "わたしは ふじさんに [ ___ ] ことが あります。",
                        promptVi: "Tôi đã từng leo núi Phú Sĩ.",
                        correctAnswer: "のぼった",
                        options: ["のぼった", "のぼる", "のぼって", "のぼり"],
                        explanation: "「のぼります」 -> thể た là 「のぼった」 trong mẫu kinh nghiệm 「Vた ことが あります」.",
                        fullSentenceJp: "わたしは ふじさんに のぼった ことが あります。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 19, index: 2, quizType: .particleFill,
                        promptJp: "ことしの はるから だいがくせい [ ___ ] なりました。",
                        promptVi: "Từ mùa xuân năm nay tôi đã trở thành sinh viên đại học.",
                        correctAnswer: "に",
                        options: ["に", "く", "と", "を"],
                        explanation: "Danh từ (だいがくせい) và tính từ な kết hợp với 「なります」 dùng trợ từ 「に」.",
                        fullSentenceJp: "ことしの はるから だいがくせいに なりました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 19, index: 3, quizType: .sentenceMatch,
                        promptJp: "しゅうまつは なにを しましたか。— [ ___ ]",
                        promptVi: "Cuối tuần bạn đã làm gì? — Tôi nào là mua sắm, nào là xem phim.",
                        correctAnswer: "かいものしたり、えいがを みたり しました。",
                        options: ["かいものしたり、えいがを みたり しました。", "かいものして、えいがを みた ことが あります。", "かいものする、えいがを みる しました。", "かいものしたり、えいがを みったり します。"],
                        explanation: "Liệt kê các hành động trong quá khứ dùng 「V1たり、V2たり しました」.",
                        fullSentenceJp: "しゅうまつは かいものしたり、えいがを みたり しました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 20,
                title: "Thể thông thường (普通形 - Futsuukei)",
                summary: "Chuyển đổi từ Thể lịch sự (丁寧形) sang Thể thông thường (普通形) cho Động từ, Tính từ い/な và Danh từ trong giao tiếp thân mật.",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 20, index: 1,
                        title: "Quy tắc đổi Động từ sang Thể thông thường",
                        structure: "Vます -> Vる (Từ điển)\nVません -> Vない\nVました -> Vた\nVませんでした -> Vなかった",
                        meaning: "Thể thông thường của Động từ ở 4 thì",
                        explanation: "Thể thông thường dùng khi nói chuyện với bạn bè, người thân, và là thành phần bắt buộc trong nhiều mệnh đề ngữ pháp từ Bài 21 trở đi.",
                        exampleJp: "あした 東京へ いく。/ きのう 東京へ いった。",
                        exampleReading: "Ashita Tokyo e iku. Kinou itta.",
                        exampleVi: "Ngày mai tớ đi Tokyo. / Hôm qua tớ đã đi."
                    ),
                    GrammarPoint(
                        lessonNumber: 20, index: 2,
                        title: "Thể thông thường của Tính từ & Danh từ",
                        structure: "A(い): bỏ です (おいしい / おいしくない / おいしかった / おいしくなかった)\nA(な) & N: です -> だ / じゃありません -> じゃない / でした -> だった / じゃありませんでした -> じゃなかった",
                        meaning: "Thể thông thường của Aい, Aな và Danh từ",
                        explanation: "Lưu ý tuyệt đối KHÔNG thêm 「だ」 sau tính từ đuôi い. Trong câu hỏi thông thường, bỏ 「か」 và lên giọng ở cuối câu (câu N/Aな bỏ cả だ).",
                        exampleJp: "あした ひま？ — ううん、ひまじゃない。(Bận không? - Không, không rảnh)",
                        exampleReading: "Ashita hima? Uun, hima ja nai.",
                        exampleVi: "Mai cậu rảnh không? — Không, không rảnh đâu."
                    ),
                    GrammarPoint(
                        lessonNumber: 20, index: 3,
                        title: "Hội thoại thân mật: うん / ううん & Lược trợ từ",
                        structure: "はい -> うん / いいえ -> ううん\nごはん(を) たべる？",
                        meaning: "Ừ / Không, trong hội thoại bạn bè",
                        explanation: "Trong hội thoại thông thường, trợ từ 「を・は・へ」 thường được lược bỏ, nhưng 「が・に・で・から」 vẫn hay giữ lại.",
                        exampleJp: "きのう どこへ いった？ — どこへも いかなかったよ。",
                        exampleReading: "Kinou doko e itta? Doko e mo ikanakatta yo.",
                        exampleVi: "Hôm qua cậu đi đâu thế? — Tớ chẳng đi đâu cả."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 20, index: 1, quizType: .particleFill,
                        promptJp: "きのうの テストは あまり [ ___ ]。(Thể thông thường của よくなかったです)",
                        promptVi: "Bài kiểm tra hôm qua không tốt lắm.",
                        correctAnswer: "よくなかった",
                        options: ["よくなかった", "いいじゃなかった", "よくなかっただ", "よくないだった"],
                        explanation: "「いい」 chia phủ định quá khứ thể thông thường là 「よくなかった」 (không thêm だ sau tính từ い).",
                        fullSentenceJp: "きのうの テストは あまり よくなかった。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 20, index: 2, quizType: .particleFill,
                        promptJp: "きのうは いいてんき [ ___ ]。(Thể thông thường của でした)",
                        promptVi: "Hôm qua thời tiết đã rất đẹp.",
                        correctAnswer: "だった",
                        options: ["だった", "だ", "でした", "じゃない"],
                        explanation: "Quá khứ khẳng định của danh từ ở thể thông thường là 「だった」.",
                        fullSentenceJp: "きのうは いいてんき だった。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 20, index: 3, quizType: .sentenceMatch,
                        promptJp: "あした パーティーに いく？ — ううん、[ ___ ]",
                        promptVi: "Ngày mai cậu có đi tiệc không? — Không, tớ không đi đâu.",
                        correctAnswer: "いかない。",
                        options: ["いかない。", "いきません。", "いかなかった。", "いくない。"],
                        explanation: "Câu hỏi dùng thể thông thường (いく？) nên trả lời thân mật dùng 「ううん、いかない」.",
                        fullSentenceJp: "あした パーティーに いく？ううん、いかない。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 21 - 25
    private static func buildLessons21To25() -> [GrammarLesson] {
        let g4 = groupTags[3]
        return [
            GrammarLesson(
                lessonNumber: 21,
                title: "Trích dẫn suy nghĩ & Phỏng đoán (とおもいます・といいます)",
                summary: "Diễn đạt suy nghĩ cá nhân (普通形 と おもいます), trích dẫn lời nói (といいます) và câu hỏi xác nhận phỏng đoán (でしょう？).",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 21, index: 1,
                        title: "Nêu suy nghĩ, dự đoán: 普通形 と おもいます",
                        structure: "[Mệnh đề thể thông thường] と おもいます。",
                        meaning: "Tôi nghĩ rằng ~ / Tôi cho là ~",
                        explanation: "Mệnh đề trước 「と おもいます」 bắt buộc ở thể thông thường. Lưu ý: Danh từ & Tính từ な ở hiện tại khẳng định phải có 「だ」 trước と (～だと おもいます).",
                        exampleJp: "あした あめが ふると おもいます。ミラーさんは げんきだと おもいます。",
                        exampleReading: "Ashita ame ga furu to omoimasu. Miraa-san wa genki da to omoimasu.",
                        exampleVi: "Tôi nghĩ ngày mai trời sẽ mưa. Tôi nghĩ anh Miller khỏe."
                    ),
                    GrammarPoint(
                        lessonNumber: 21, index: 2,
                        title: "Trích dẫn lời nói: 「～」/ 普通形 と いいます",
                        structure: "「Nguyên văn lời nói」と いいました。\n[Thể thông thường] と いいました。",
                        meaning: "Ai đó nói rằng...",
                        explanation: "Trích dẫn trực tiếp giữ nguyên trong ngoặc 「」 (kể cả です/ます). Trích dẫn gián tiếp chuyển mệnh đề về thể thông thường trước 「と いいます」.",
                        exampleJp: "先生は あした テストが あると いいました。",
                        exampleReading: "Sensei wa ashita tesuto ga aru to iimashita.",
                        exampleVi: "Thầy giáo nói rằng ngày mai có bài kiểm tra."
                    ),
                    GrammarPoint(
                        lessonNumber: 21, index: 3,
                        title: "Hỏi xác nhận đồng tình: 普通形 でしょう？",
                        structure: "[V / A(い) / A(な bỏ だ) / N(bỏ だ)] + でしょう？",
                        meaning: "~ phải không nhỉ?",
                        explanation: "Lên giọng ở 「でしょう？」 khi muốn xác nhận lại với người nghe điều mà cả hai có thể đoán được hoặc kỳ vọng sự đồng tình.",
                        exampleJp: "日本の 物価は たかい でしょう？ — ええ、そうですね。",
                        exampleReading: "Nihon no bukka wa takai deshou? Ee, sou desu ne.",
                        exampleVi: "Giá cả ở Nhật đắt phải không? — Vâng, đúng thế đấy."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 21, index: 1, quizType: .particleFill,
                        promptJp: "この 仕事は とても たいへん [ ___ ] おもいます。",
                        promptVi: "Tôi nghĩ công việc này rất vất vả.",
                        correctAnswer: "だと",
                        options: ["だと", "と", "なと", "ですと"],
                        explanation: "「たいへん」 là tính từ đuôi な, trước 「と おもいます」 ở hiện tại khẳng định bắt buộc có 「だ」 -> 「たいへんだと おもいます」.",
                        fullSentenceJp: "この 仕事は とても たいへんだと おもいます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 21, index: 2, quizType: .particleFill,
                        promptJp: "ねる まえに、「おやすみなさい」 [ ___ ] いいます。",
                        promptVi: "Trước khi đi ngủ nói câu 'Chúc ngủ ngon'.",
                        correctAnswer: "と",
                        options: ["と", "を", "が", "に"],
                        explanation: "Trợ từ trích dẫn 「と」 đặt trước động từ 「いいます」.",
                        fullSentenceJp: "ねる まえに、「おやすみなさい」と いいます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 21, index: 3, quizType: .sentenceMatch,
                        promptJp: "新しい くつですね。たかかった [ ___ ] — いいえ、やすかったですよ。",
                        promptVi: "Giày mới nhỉ. Chắc đắt lắm phải không? — Không, rẻ lắm đấy.",
                        correctAnswer: "でしょう？",
                        options: ["でしょう？", "とおもいますか？", "といいましたか？", "ですか？"],
                        explanation: "Câu hỏi xác nhận phỏng đoán 'Chắc là đã đắt phải không?' dùng 「たかかった でしょう？」.",
                        fullSentenceJp: "たかかった でしょう？いいえ、やすかったですよ。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 22,
                title: "Mệnh đề bổ nghĩa cho Danh từ (普通形 + 名詞)",
                summary: "Biến cả một mệnh đề thể thông thường thành cụm định ngữ đứng trước bổ nghĩa cho Danh từ, và cách dùng trợ từ が làm chủ ngữ mệnh đề phụ.",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 22, index: 1,
                        title: "Cấu trúc Mệnh đề bổ nghĩa Danh từ",
                        structure: "[Mệnh đề thể thông thường] + Danh từ",
                        meaning: "Danh từ mà [mệnh đề mô tả]",
                        explanation: "Trong tiếng Nhật, phần giải thích/bổ nghĩa luôn đặt TRƯỚC danh từ. Lưu ý: Tính từ な giữ 「な」, Danh từ giữ 「の」 khi đứng trước danh từ được bổ nghĩa.",
                        exampleJp: "これは ミラーさんが つくった ケーキです。",
                        exampleReading: "Kore wa Miraa-san ga tsukutta keeki desu.",
                        exampleVi: "Đây là chiếc bánh kem mà anh Miller đã làm."
                    ),
                    GrammarPoint(
                        lessonNumber: 22, index: 2,
                        title: "Chủ ngữ của mệnh đề phụ dùng trợ từ が",
                        structure: "[Người が V(thể thông thường)] + Danh từ",
                        meaning: "Lưu ý đổi は thành が trong mệnh đề bổ nghĩa",
                        explanation: "Khi một câu có chủ ngữ là 「N は」 được đưa vào làm mệnh đề phụ bổ nghĩa cho danh từ, trợ từ 「は」 phải đổi thành 「が」.",
                        exampleJp: "わたしが すんでいる まちは しずかです。",
                        exampleReading: "Watashi ga sunde iru machi wa shizuka desu.",
                        exampleVi: "Thành phố nơi tôi đang sống rất yên tĩnh."
                    ),
                    GrammarPoint(
                        lessonNumber: 22, index: 3,
                        title: "Bổ nghĩa cho じかん / やくそく / ようじ",
                        structure: "Vる + じかん / やくそく / ようじ が あります (ありません)。",
                        meaning: "Có (không có) thời gian / cuộc hẹn / việc bận làm V",
                        explanation: "Dùng động từ thể từ điển (Vる) đặt ngay trước các danh từ chỉ thời gian/việc cần làm.",
                        exampleJp: "あさ ごはんを たべる じかんが ありません。",
                        exampleReading: "Asa gohan o taberu jikan ga arimasen.",
                        exampleVi: "Buổi sáng tôi không có thời gian ăn cơm."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 22, index: 1, quizType: .particleFill,
                        promptJp: "きのう わたし [ ___ ] とった しゃしんを みせます。",
                        promptVi: "Tôi cho bạn xem bức ảnh mà hôm qua tôi đã chụp.",
                        correctAnswer: "が",
                        options: ["が", "は", "を", "に"],
                        explanation: "Chủ thể hành động nằm trong mệnh đề bổ nghĩa cho danh từ (しゃしん) phải dùng trợ từ 「が」 thay vì 「は」.",
                        fullSentenceJp: "きのう わたしが とった しゃしんを みせます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 22, index: 2, quizType: .particleFill,
                        promptJp: "きょねん 大阪で [ ___ ] かばんです。",
                        promptVi: "Là chiếc cặp tôi đã mua ở Osaka năm ngoái.",
                        correctAnswer: "買った",
                        options: ["買った", "買います", "買って", "買うな"],
                        explanation: "Bổ nghĩa cho danh từ 「かばん」 trong quá khứ (きょねん) dùng thể thông thường quá khứ 「買った」.",
                        fullSentenceJp: "きょねん 大阪で 買った かばんです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 22, index: 3, quizType: .sentenceMatch,
                        promptJp: "きょうは ともだちと [ ___ ]",
                        promptVi: "Hôm nay tôi có hẹn đi xem phim cùng bạn bè.",
                        correctAnswer: "えいがを みる やくそくが あります。",
                        options: ["えいがを みる やくそくが あります。", "えいがを みて やくそくです。", "えいがを みた やくそくに なります。", "えいがを みます やくそくが あります。"],
                        explanation: "Bổ nghĩa cho 「やくそく」 (cuộc hẹn sắp tới) dùng động từ thể từ điển 「みる」 + やくそくが あります.",
                        fullSentenceJp: "きょうは ともだちと えいがを みる やくそくが あります。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 23,
                title: "Mệnh đề thời gian とき & Điều kiện tất yếu と",
                summary: "Phân biệt Vる/Vた とき (lúc/khi), điều kiện tự nhiên Vる と (hễ ~ thì) và trợ từ を chỉ nơi đi qua.",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 23, index: 1,
                        title: "Khi / Lúc: ～とき、～",
                        structure: "Vる / Vた / Vない / A(い) / A(な)な / Nの + とき、～",
                        meaning: "Khi / Lúc làm V hoặc ở trạng thái A, N",
                        explanation: "Thể trước 「とき」 là hiện tại (tương lai) hay quá khứ tùy thuộc vào ý nghĩa: 「Vる とき」 là trước khi/lúc đang chuẩn bị làm V; 「Vた とき」 là sau khi đã làm xong V đó.",
                        exampleJp: "うちへ かえる とき、パンを 買います。(Lúc trên đường về) / うちへ かえった とき、ただいま と いいます。(Khi đã về tới nhà)",
                        exampleReading: "Uchi e kaeru toki, pan o kaimasu. / Kaetta toki, tadaima to iimasu.",
                        exampleVi: "Lúc đi về nhà (trước khi tới nhà) tôi mua bánh mì. / Lúc về tới nhà nói Tadaima."
                    ),
                    GrammarPoint(
                        lessonNumber: 23, index: 2,
                        title: "Điều kiện tất yếu / Chỉ đường: Vる / Vない と、～",
                        structure: "Vる / Vない + と、～",
                        meaning: "Hễ làm V thì tất yếu xảy ra kết quả ~",
                        explanation: "Diễn tả kết quả tự nhiên, quy luật tất yếu (xoay nút thì tiếng to lên), hoặc dùng để chỉ đường (rẽ phải thì thấy nhà ga). Lưu ý: vế sau KHÔNG dùng câu yêu cầu/ý chí.",
                        exampleJp: "この ボタンを おすと、おつりが でます。",
                        exampleReading: "Kono botan o osu to, otsuri ga demasu.",
                        exampleVi: "Hễ ấn nút này thì tiền thừa sẽ rơi ra."
                    ),
                    GrammarPoint(
                        lessonNumber: 23, index: 3,
                        title: "Trợ từ を chỉ địa điểm đi qua",
                        structure: "Địa điểm (はし / こうえん / みち / かど) を あるきます / わたります / まがります。",
                        meaning: "Đi bộ trên đường / Băng qua cầu / Rẽ ở góc phố",
                        explanation: "Với các động từ di chuyển qua lại một không gian (あるく, わたる, とおる, まがる), nơi đi qua dùng trợ từ 「を」.",
                        exampleJp: "あの しんごうを みぎへ まがってください。",
                        exampleReading: "Ano shingou o migi e magatte kudasai.",
                        exampleVi: "Xin hãy rẽ phải ở chỗ đèn tín hiệu đằng kia."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 23, index: 1, quizType: .particleFill,
                        promptJp: "この つまみを 右へ [ ___ ] と、音が おおきく なります。",
                        promptVi: "Hễ vặn núm này sang phải thì âm thanh sẽ to lên.",
                        correctAnswer: "まわす",
                        options: ["まわす", "まわした", "まわして", "まわさない"],
                        explanation: "Mẫu điều kiện tất yếu 「Vる と」 luôn sử dụng động từ ở thể từ điển (Vる) hoặc thể ない -> 「まわす」.",
                        fullSentenceJp: "この つまみを 右へ まわすと、音が おおきく なります。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 23, index: 2, quizType: .particleFill,
                        promptJp: "こうえん [ ___ ] さんぽします。",
                        promptVi: "Tôi đi dạo trong công viên.",
                        correctAnswer: "を",
                        options: ["を", "に", "へ", "と"],
                        explanation: "Động từ di chuyển xuyên qua một không gian (さんぽします, わたります) dùng trợ từ 「を」.",
                        fullSentenceJp: "こうえんを さんぽします。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 23, index: 3, quizType: .sentenceMatch,
                        promptJp: "としょかんで 本を かりる とき、[ ___ ]",
                        promptVi: "Khi mượn sách ở thư viện thì cần có thẻ.",
                        correctAnswer: "カードが いります。",
                        options: ["カードが いります。", "カードが いりません。", "カードを あげます。", "カードを かしました。"],
                        explanation: "Quy trình tất yếu khi đi mượn sách: trước khi mượn (かりる とき) thì cần thẻ thư viện (カードが いります).",
                        fullSentenceJp: "としょかんで 本を かりる とき、カードが いります。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 24,
                title: "Cho và Nhận hành động (てあげます・てもらいます・てくれます)",
                summary: "Phân biệt 3 động từ cho-nhận hành động: Vて あげます (làm cho ai), Vて もらいます (nhờ ai làm cho mình), Vて くれます (ai đó làm giúp mình).",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 24, index: 1,
                        title: "Làm giúp ai: Vて あげます",
                        structure: "Người nhận に Vて あげます。",
                        meaning: "Tôi (hoặc người thân) làm V giúp cho [Người nhận]",
                        explanation: "Người thực hiện hành động là chủ ngữ (thường là わたし). Lưu ý tránh dùng thẳng với cấp trên vì dễ gây cảm giác ban ơn (dùng Vましょうか lịch sự hơn).",
                        exampleJp: "わたしは おばあさんに にもつを もって あげました。",
                        exampleReading: "Watashi wa obaasan ni nimotsu o motte agemashita.",
                        exampleVi: "Tôi đã xách giúp bà hành lý."
                    ),
                    GrammarPoint(
                        lessonNumber: 24, index: 2,
                        title: "Nhờ / Được ai làm giúp: Vて もらいます",
                        structure: "Người làm giúp に/から Vて もらいます。",
                        meaning: "Tôi nhờ / được [Người làm] làm V cho",
                        explanation: "Chủ ngữ là người nhận lợi ích (わたし), người thực hiện hành động đi với 「に」 hoặc 「から」.",
                        exampleJp: "わたしは 先生に にほんごを なおして もらいました。",
                        exampleReading: "Watashi wa sensei ni Nihongo o naoshite moraimashita.",
                        exampleVi: "Tôi đã được thầy giáo sửa giúp tiếng Nhật."
                    ),
                    GrammarPoint(
                        lessonNumber: 24, index: 3,
                        title: "Ai đó làm giúp tôi: Vて くれます",
                        structure: "Người làm giúp が (わたしに) Vて くれます。",
                        meaning: "[Người làm] đã làm giúp tôi việc V",
                        explanation: "Khi người khác làm việc gì có lợi cho BẢN THÂN tôi (hoặc người nhà tôi), dùng 「くれます」. Chủ ngữ là người làm (đi với が/は) và 「わたしに」 thường được lược bỏ.",
                        exampleJp: "カリナさんが わたしの うちへ つれて いって くれました。",
                        exampleReading: "Karina-san ga watashi no uchi e tsurete itte kuremashita.",
                        exampleVi: "Chị Karina đã dẫn tôi về nhà."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 24, index: 1, quizType: .particleFill,
                        promptJp: "ともだちが わたしに 日本の じしょを かして [ ___ ]。",
                        promptVi: "Người bạn đã cho tôi mượn quyển từ điển tiếng Nhật.",
                        correctAnswer: "くれました",
                        options: ["くれました", "あげました", "もらいました", "しました"],
                        explanation: "Khi người khác (ともだち) làm điều tốt cho mình (わたしに), bắt buộc dùng 「Vて くれます/くれました」.",
                        fullSentenceJp: "ともだちが わたしに 日本の じしょを かして くれました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 24, index: 2, quizType: .particleFill,
                        promptJp: "わたしは 先生 [ ___ ] すばらしい ほんを しょうかいして もらいました。",
                        promptVi: "Tôi đã được thầy giáo giới thiệu cho một quyển sách tuyệt vời.",
                        correctAnswer: "に",
                        options: ["に", "が", "を", "で"],
                        explanation: "Trong cấu trúc 「Vて もらいます」, người thực hiện hành động giúp mình đi với trợ từ 「に」 (hoặc から).",
                        fullSentenceJp: "わたしは 先生に すばらしい ほんを しょうかいして もらいました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 24, index: 3, quizType: .sentenceMatch,
                        promptJp: "おとうとが バイクを なおせませんでしたから、わたしが [ ___ ]",
                        promptVi: "Vì em trai không sửa được xe máy nên tôi đã sửa giúp cho em ấy.",
                        correctAnswer: "なおして あげました。",
                        options: ["なおして あげました。", "なおして くれました。", "なおして もらいました。", "なおして いました。"],
                        explanation: "Chủ ngữ là 「わたし」 (tôi) làm giúp cho người khác (おとうと) nên dùng 「Vて あげます」.",
                        fullSentenceJp: "わたしが おとうとに バイクを なおして あげました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 25,
                title: "Điều kiện giả định たら & Nghịch đảo ても",
                summary: "Câu điều kiện giả định và trình tự sau khi làm xong (Vたら), và câu nhượng bộ 'cho dù ~ vẫn' (Vても / Aても / Nでも).",
                groupTag: g4,
                points: [
                    GrammarPoint(
                        lessonNumber: 25, index: 1,
                        title: "Giả định điều kiện: ～たら、～ (Nếu ~ thì)",
                        structure: "V(thể た) + ら\nA(い)かった + ら\nA(な) / Danh từ + だった + ら",
                        meaning: "Nếu... thì... (giả định điều kiện)",
                        explanation: "Lấy thể quá khứ thông thường (た形/だった) thêm 「ら」. Dùng để đặt giả thiết cho một điều kiện có thể xảy ra hoặc trái thực tế.",
                        exampleJp: "お金が あったら、せかいを りょこうしたいです。",
                        exampleReading: "Okane ga attara, sekai o ryokou shitai desu.",
                        exampleVi: "Nếu có tiền, tôi muốn đi du lịch vòng quanh thế giới."
                    ),
                    GrammarPoint(
                        lessonNumber: 25, index: 2,
                        title: "Trình tự tương lai: Sau khi V1 thì V2 (V1たら、V2)",
                        structure: "V1たら、V2ます。",
                        meaning: "Sau khi xong việc V1 thì sẽ làm V2",
                        explanation: "Khác với nghĩa 'nếu', khi V1 chắc chắn sẽ xảy ra trong tương lai (như đến giờ, về đến nhà, xong việc), 「V1たら」 mang nghĩa 'sau khi / khi nào V1 hoàn thành'.",
                        exampleJp: "駅に ついたら、でんわを かけて ください。",
                        exampleReading: "Eki ni tsuitara, denwa o kakete kudasai.",
                        exampleVi: "Khi nào đến nhà ga thì hãy gọi điện cho tôi nhé."
                    ),
                    GrammarPoint(
                        lessonNumber: 25, index: 3,
                        title: "Nhượng bộ nghịch đảo: ～ても、～ (Cho dù ~ vẫn)",
                        structure: "Vて + も\nA(い)くて + も\nA(な) / Danh từ + で + も",
                        meaning: "Cho dù ~ đi nữa thì vẫn...",
                        explanation: "Diễn đạt kết quả ở vế 2 không thay đổi cho dù điều kiện ở vế 1 có xảy ra như thế nào (thường đi kèm với 「いくら」 = cho dù bao nhiêu đi nữa).",
                        exampleJp: "あめが ふっても、サッカーを します。いくら たかくても、買います。",
                        exampleReading: "Ame ga futte mo, sakkaa o shimasu. Ikura takakute mo, kaimasu.",
                        exampleVi: "Cho dù trời có mưa, tôi vẫn đá bóng. Cho dù đắt thế nào tôi cũng mua."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 25, index: 1, quizType: .particleFill,
                        promptJp: "あした いい てんき [ ___ ]、やまへ のぼりましょう。",
                        promptVi: "Nếu ngày mai thời tiết đẹp, chúng ta cùng leo núi nhé.",
                        correctAnswer: "だったら",
                        options: ["だったら", "ても", "なら", "から"],
                        explanation: "「てんき」 là danh từ, giả định điều kiện 'Nếu là thời tiết đẹp' dùng 「てんき だったら」.",
                        fullSentenceJp: "あした いい てんき だったら、やまへ のぼりましょう。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 25, index: 2, quizType: .particleFill,
                        promptJp: "いくら くすりを [ ___ ]、よくなりません。",
                        promptVi: "Cho dù uống thuốc thế nào đi nữa thì vẫn không khỏe lên được.",
                        correctAnswer: "のんでも",
                        options: ["のんでも", "のんだら", "のむ まえに", "のんでから"],
                        explanation: "「いくら ～ ても」 diễn đạt 'cho dù ~ đi nữa vẫn không...'. 「のみます」 (Nhóm I) chia thể ても là 「のんでも」.",
                        fullSentenceJp: "いくら くすりを のんでも、よくなりません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 25, index: 3, quizType: .sentenceMatch,
                        promptJp: "5じに なったら、[ ___ ]",
                        promptVi: "Khi nào đến 5 giờ thì hãy về nhà nhé.",
                        correctAnswer: "うちへ かえりましょう。",
                        options: ["うちへ かえりましょう。", "うちへ かえりません。", "うちへ かえっても いい。", "うちへ かえりました。"],
                        explanation: "Vế 1 là 「5じに なったら」 (khi đến 5 giờ) chỉ mốc thời gian tương lai, vế 2 nêu dự định/rủ rê 「うちへ かえりましょう」.",
                        fullSentenceJp: "5じに なったら、うちへ かえりましょう。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 26 - 30 (N4)
    private static func buildLessons26To30() -> [GrammarLesson] {
        let g5 = groupTags[4]
        return [
            GrammarLesson(
                lessonNumber: 26,
                title: "Giải thích ～んです & Nhờ vả / Hỏi ý kiến",
                summary: "Nhấn mạnh/giải thích lý do với ～んです, nhờ lịch sự với Vて いただけませんか và hỏi lời khuyên ～たら いいですか.",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 26, index: 1,
                        title: "Giải thích & nhấn mạnh: ～んです (～のです)",
                        structure: "V(thường) / A(い) + んです\nA(な) / Danh từ + な + んです",
                        meaning: "Là vì... / Chuyện là... (dùng khi hỏi hoặc giải thích lý do)",
                        explanation: "「～んです」 dùng khi thấy tình huống thực tế và muốn hỏi nguyên nhân (～んですか), trình bày lý do (どうして ～んですか -> ～んです), hoặc mào đầu chủ đề nhẹ nhàng với 「～んですが、…」. Lưu ý: Trước んです, Aな và Danh từ phải thêm 「な」.",
                        exampleJp: "どうしたんですか。… おなかが いたいんです。",
                        exampleReading: "Dou shita n desu ka. ... Onaka ga itai n desu.",
                        exampleVi: "Bạn làm sao thế? ... Tôi bị đau bụng ạ."
                    ),
                    GrammarPoint(
                        lessonNumber: 26, index: 2,
                        title: "Nhờ vả lịch sự: Vて いただけませんか",
                        structure: "Vて いただけませんか。",
                        meaning: "Anh/chị có thể vui lòng làm V giúp tôi được không ạ?",
                        explanation: "Là cách nhờ cậy trang trọng, lịch sự hơn 「Vて ください」, thường dùng với cấp trên, thầy cô hoặc người lạ. Trước đó hay mào đầu bằng 「～んですが」.",
                        exampleJp: "すみませんが、かんじの よみかたを おしえて いただけませんか。",
                        exampleReading: "Sumimasen ga, kanji no yomikata o oshiete itadakemasen ka.",
                        exampleVi: "Xin lỗi, anh/chị có thể chỉ giúp tôi cách đọc chữ Kanji này được không ạ?"
                    ),
                    GrammarPoint(
                        lessonNumber: 26, index: 3,
                        title: "Xin lời khuyên: Từ để hỏi + Vたら いいですか",
                        structure: "Từ để hỏi (どこで / だれに / どう…) + Vたら いいですか。",
                        meaning: "Tôi nên làm V ở đâu / với ai / như thế nào thì được?",
                        explanation: "Dùng để xin lời khuyên, chỉ dẫn về cách thức, địa điểm hay việc cần làm. Câu trả lời thường dùng 「Vたら いいですよ」 hoặc 「Vてください」.",
                        exampleJp: "パスポートを なくしたんですが、どう したら いいですか。",
                        exampleReading: "Pasupooto o nakushita n desu ga, dou shitara ii desu ka.",
                        exampleVi: "Tôi làm mất hộ chiếu rồi, bây giờ tôi nên làm thế nào ạ?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 26, index: 1, quizType: .particleFill,
                        promptJp: "あした ようじが [ ___ ] んですが、はやく かえっても いいですか。",
                        promptVi: "Ngày mai tôi có chút việc bận nên về sớm được không ạ?",
                        correctAnswer: "ある",
                        options: ["ある", "あります", "あったの", "あるな"],
                        explanation: "Trước 「んです」 động từ phải chia về thể thông thường (辞書形/ない形/た形). Vì là ngày mai nên dùng 「ある」.",
                        fullSentenceJp: "あした ようじが あるんですが、はやく かえっても いいですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 26, index: 2, quizType: .particleFill,
                        promptJp: "ちかくで けいたいを じゅうでんしたいんですが、どこで [ ___ ] いいですか。",
                        promptVi: "Tôi muốn sạc điện thoại ở gần đây thì sạc ở đâu được ạ?",
                        correctAnswer: "したら",
                        options: ["したら", "して", "する", "しない"],
                        explanation: "Cấu trúc hỏi lời khuyên/chỉ dẫn: 「Từ để hỏi + Vたら いいですか」. Động từ 「します」 -> 「したら」.",
                        fullSentenceJp: "どこで したら いいですか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 26, index: 3, quizType: .sentenceMatch,
                        promptJp: "にほんごで 手紙を かいたんですが、[ ___ ]",
                        promptVi: "Tôi đã viết thư bằng tiếng Nhật, cô có thể xem kiểm tra giúp em được không ạ?",
                        correctAnswer: "みて いただけませんか。",
                        options: ["みて いただけませんか。", "みて くださいません。", "みて いいですか。", "みましたか。"],
                        explanation: "Mào đầu bằng 「～んですが」 rồi đưa ra lời nhờ lịch sự dùng 「Vて いただけませんか」.",
                        fullSentenceJp: "にほんごで 手紙を かいたんですが、みて いただけませんか。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 27,
                title: "Thể khả năng & Động từ tự nhiên (見えます・聞こえます)",
                summary: "Cách chia động từ khả năng (nhóm I: い→え, nhóm II: +られる, くる→こられる, する→できる), Vが できます, 見えます/聞こえます và しか～ない.",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 27, index: 1,
                        title: "Động từ thể khả năng (Thay を thành が)",
                        structure: "Nhóm I: đuôi い → え + ます (かきます → かけます)\nNhóm II: bỏ ます + られます (たべます → たべられます)\nNhóm III: きます → こられます / します → できます",
                        meaning: "Có thể làm V (năng lực hoặc điều kiện cho phép)",
                        explanation: "Động từ khả năng đều chia như động từ Nhóm II. Tân ngữ trực tiếp vốn đi với 「を」 phải chuyển sang trợ từ 「が」. Ví dụ: かんじが かけます (viết được chữ Hán).",
                        exampleJp: "わたしは ひらがなと カタカナが よめます。",
                        exampleReading: "Watashi wa hiragana to katakana ga yomemasu.",
                        exampleVi: "Tôi có thể đọc được chữ Hiragana và Katakana."
                    ),
                    GrammarPoint(
                        lessonNumber: 27, index: 2,
                        title: "Phân biệt 見えます / 聞こえます với 見られます / 聞けます",
                        structure: "N が 見えます / 聞こえます (đập vào mắt/tai tự nhiên)\nN が 見られます / 聞けます (có thể xem/nghe có chủ đích)",
                        meaning: "Nhìn thấy / nghe thấy (tự nhiên) vs có thể xem / nghe",
                        explanation: "「見えます / 聞こえます」 dùng khi cảnh vật hoặc âm thanh tự nhiên lọt vào tầm mắt/tai dù không chủ động tìm xem (Ví dụ: từ cửa sổ thấy núi Phú Sĩ). Còn 「見られます / 聞けます」 nhấn mạnh điều kiện, cơ hội để chủ động xem/nghe.",
                        exampleJp: "へやから ふじさんが 見えます。きょうは レコードが 聞けません。",
                        exampleReading: "Heya kara Fujisan ga miemasu. Kyou wa rekoodo ga kikemasen.",
                        exampleVi: "Từ phòng có thể nhìn thấy núi Phú Sĩ. Hôm nay không thể nghe đĩa nhạc."
                    ),
                    GrammarPoint(
                        lessonNumber: 27, index: 3,
                        title: "Giới hạn 「しか～ない」 & Khẳng định hoàn thành 「できます」",
                        structure: "N しか V(phủ định)\nN が できます (xong / hoàn thành)",
                        meaning: "Chỉ có N thôi (nhấn mạnh ít ỏi) / N đã hoàn thành xong",
                        explanation: "「しか」 luôn đi với động từ PHỦ ĐỊNH và mang sắc thái 'chỉ có ~ mà thôi' (ít hơn mong đợi). Khác với 「だけ」 đi được với khẳng định. Ngoài ra, 「できます」 còn mang nghĩa 'xây xong / hoàn thành xong / có thêm cái mới'.",
                        exampleJp: "ベトナムごしか 話せません。あたらしい スーパーが できました。",
                        exampleReading: "Betonamu-go shika hanasemasen. Atarashii suupaa ga dekimashita.",
                        exampleVi: "Tôi chỉ nói được mỗi tiếng Việt thôi. Siêu thị mới đã xây xong rồi."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 27, index: 1, quizType: .particleFill,
                        promptJp: "さいふに 千円 [ ___ ] ありません。",
                        promptVi: "Trong ví chỉ có 1000 yên thôi.",
                        correctAnswer: "しか",
                        options: ["しか", "だけ", "ごろ", "も"],
                        explanation: "Động từ cuối câu ở dạng phủ định 「ありません」 nên phải dùng trợ từ 「しか」 để mang nghĩa 'chỉ ~ mà thôi'.",
                        fullSentenceJp: "さいふに 千円しか ありません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 27, index: 2, quizType: .particleFill,
                        promptJp: "あそこに 大きな ビルの うえに ふじさんが [ ___ ]。",
                        promptVi: "Ở đằng kia, phía trên tòa nhà lớn có thể nhìn thấy (tự nhiên) núi Phú Sĩ.",
                        correctAnswer: "見えます",
                        options: ["見えます", "見ます", "見られます", "見させます"],
                        explanation: "Núi Phú Sĩ tự nhiên hiện ra trong tầm mắt từ phía xa -> dùng tự động từ 「見えます」.",
                        fullSentenceJp: "あそこに 大きな ビルの うえに ふじさんが 見えます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 27, index: 3, quizType: .sentenceMatch,
                        promptJp: "インターネットがあれば、うちで [ ___ ]",
                        promptVi: "Nếu có Internet thì có thể mua sắm ngay tại nhà.",
                        correctAnswer: "かいものが できます。",
                        options: ["かいものが できます。", "かいものを みます。", "かいものしか できません。", "かいものが きこえます。"],
                        explanation: "「かいもの」 đi với khả năng của 「します」 là 「できます」, trợ từ 「を」 đổi thành 「が」 -> 「かいものが できます」.",
                        fullSentenceJp: "インターネットがあれば、うちで かいものが できます。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 28,
                title: "Song song ながら・Thói quen ています・Liệt kê ～し",
                summary: "Làm hai việc đồng thời (V1(ます)ながらV2), thói quen (Vています) và liệt kê nhiều lý do/tính chất (～し、～し).",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 28, index: 1,
                        title: "Vừa V1 vừa V2: V1(bỏ ます) ながら V2",
                        structure: "V1(bỏ ます) ながら V2ます。",
                        meaning: "Vừa làm V1 vừa làm V2 (V2 là hành động chính)",
                        explanation: "Hai hành động xảy ra đồng thời bởi cùng một chủ ngữ, trong đó hành động nhấn mạnh/chính nằm ở vế sau (V2). Có thể dùng cho một khoảnh khắc hoặc kéo dài một giai đoạn (vừa đi làm vừa học).",
                        exampleJp: "おんがくを ききながら べんきょうします。",
                        exampleReading: "Ongaku o kikinagara benkyou shimasu.",
                        exampleVi: "Tôi vừa nghe nhạc vừa học bài."
                    ),
                    GrammarPoint(
                        lessonNumber: 28, index: 2,
                        title: "Thói quen lặp đi lặp lại: Vています",
                        structure: "Thời gian / まいにち + Vています。",
                        meaning: "Thường hay làm V (thói quen đều đặn)",
                        explanation: "Ngoài diễn tả hành động đang xảy ra hay trạng thái nghề nghiệp, 「Vています」 còn dùng nói về thói quen được lặp lại đều đặn trong thời gian dài (quá khứ dùng 「ていました」).",
                        exampleJp: "まいあさ ジョギングを しています。",
                        exampleReading: "Maiasa jogingu o shite imasu.",
                        exampleVi: "Sáng nào tôi cũng chạy bộ."
                    ),
                    GrammarPoint(
                        lessonNumber: 28, index: 3,
                        title: "Liệt kê nhiều tính chất / lý do: ～し、～し",
                        structure: "Thể thông thường + し、Thể thông thường + し、(それで～)",
                        meaning: "Vừa ~ lại vừa ~ / Đã thế lại còn ~ (nên là...)",
                        explanation: "Liệt kê từ 2 đặc điểm, sự kiện hoặc lý do trở lên. Chú ý khác 「て」: 「し」 luôn nối sau THỂ THÔNG THƯỜNG (Aな/N thì thêm だ: きれいだ + し). Dùng 「それに」 để thêm ý và 「それで」 để dẫn ra kết quả tự nhiên.",
                        exampleJp: "この 店は やすいし、おいしいし、それに てんいんも しんせつです。",
                        exampleReading: "Kono mise wa yasui shi, oishii shi, soreni ten'in mo shinsetsu desu.",
                        exampleVi: "Quán này vừa rẻ, vừa ngon, hơn nữa nhân viên cũng thân thiện."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 28, index: 1, quizType: .particleFill,
                        promptJp: "コーヒーを [ ___ ]、しんぶんを よみます。",
                        promptVi: "Tôi vừa uống cà phê vừa đọc báo.",
                        correctAnswer: "のみながら",
                        options: ["のみながら", "のんでながら", "のむながら", "のんだながら"],
                        explanation: "Cấu trúc 「ながら」 ghép trực tiếp vào gốc động từ thể ます (bỏ ます): 「のみ(ます) + ながら」.",
                        fullSentenceJp: "コーヒーを のみながら、しんぶんを よみます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 28, index: 2, quizType: .particleFill,
                        promptJp: "田中さんは まじめ [ ___ ]、けいけんも あるし、いい 人です。",
                        promptVi: "Anh Tanaka vừa chăm chỉ lại vừa có kinh nghiệm, là một người tốt.",
                        correctAnswer: "だし",
                        options: ["だし", "なし", "てし", "し"],
                        explanation: "Trước 「し」 là thể thông thường. 「まじめ」 là tính từ đuôi な nên phải chia thành 「まじめだ + し」.",
                        fullSentenceJp: "田中さんは まじめだし、けいけんも あるし、いい 人です。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 28, index: 3, quizType: .sentenceMatch,
                        promptJp: "きょうは 天気も いいし、じかんも あるし、[ ___ ]",
                        promptVi: "Hôm nay thời tiết lại đẹp mà cũng có thời gian nữa, nên chúng ta đi dạo nhé.",
                        correctAnswer: "それで、こうえんへ さんぽに いきましょう。",
                        options: ["それで、こうえんへ さんぽに いきましょう。", "しかし、どこへも いきません。", "だから、家で ねていました。", "それでも、やすみませんでした。"],
                        explanation: "Hai lý do thuận lợi nối bằng 「～し、～し」 dẫn tới kết quả hợp lý với 「それで」.",
                        fullSentenceJp: "きょうは 天気も いいし、じかんも あるし、それで、こうえんへ さんぽに いきましょう。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 29,
                title: "Trạng thái tự động từ ています & Hoàn tất てしまいます",
                summary: "Diễn tả kết quả đang tồn tại của tự động từ (NがVています), hành động hoàn tất hoặc nuối tiếc (Vてしまいました).",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 29, index: 1,
                        title: "Trạng thái kết quả: N が V(tự động từ) ています",
                        structure: "N(vật) が + Tự động từ(て) + います。",
                        meaning: "N đang ở trong trạng thái... (mở, đóng, bật, tắt, vỡ, rách...)",
                        explanation: "Mô tả kết quả đang hiện hữu trước mắt của một sự việc xảy ra trước đó. Phải dùng TỰ ĐỘNG TỪ (không có tân ngữ を) đi với trợ từ 「が」 hoặc 「は」 (khi đưa chủ đề lên đầu).",
                        exampleJp: "でんきが ついています。まどが あいています。コップが われています。",
                        exampleReading: "Denki ga tsuite imasu. Mado ga aite imasu. Koppu ga warete imasu.",
                        exampleVi: "Đèn đang bật. Cửa sổ đang mở. Cái cốc bị vỡ rồi."
                    ),
                    GrammarPoint(
                        lessonNumber: 29, index: 2,
                        title: "Hoàn thành triệt để: Vて しまいます",
                        structure: "Vて しまいます / Vて しまいました (chỉ sự hoàn tất)",
                        meaning: "Làm xong hết / hoàn tất toàn bộ V",
                        explanation: "Nhấn mạnh hành động đã được thực hiện trọn vẹn 100% hoặc chắc chắn sẽ làm xong hoàn toàn vào một thời điểm tương lai.",
                        exampleJp: "しゅくだいは もう やって しまいました。",
                        exampleReading: "Shukudai wa mou yatte shimaimashita.",
                        exampleVi: "Bài tập về nhà tôi đã làm xong xuôi hết rồi."
                    ),
                    GrammarPoint(
                        lessonNumber: 29, index: 3,
                        title: "Tiếc nuối / lỡ mất: Vて しまいました",
                        structure: "Vて しまいました。",
                        meaning: "Lỡ... mất rồi / Trót... mất tiêu rồi (bối rối, hối tiếc)",
                        explanation: "Biểu thị cảm giác hối tiếc, lúng túng khi lỡ làm hỏng việc gì đó ngoài ý muốn (quên, đánh mất, hỏng, đi nhầm tàu...). Khi nói thân mật hay rút gọn thành 「～ちゃった / ～じゃった」.",
                        exampleJp: "でんしゃに かさを わすれて しまいました。",
                        exampleReading: "Densha ni kasa o wasurete shimaimashita.",
                        exampleVi: "Tôi lỡ bỏ quên cái ô trên tàu điện mất rồi."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 29, index: 1, quizType: .particleFill,
                        promptJp: "この じどうしゃの ドアが [ ___ ] いますね。",
                        promptVi: "Cửa của chiếc ô tô này đang mở kia nhỉ.",
                        correctAnswer: "あいて",
                        options: ["あいて", "あけて", "あいてあり", "あけられて"],
                        explanation: "Trạng thái tự nhiên trước mắt dùng 「N が + Tự động từ ています」. 「あきます」 (tự mở) chia thể て là 「あいて」; còn 「あけます」 là tha động từ.",
                        fullSentenceJp: "この じどうしゃの ドアが あいて いますね。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 29, index: 2, quizType: .particleFill,
                        promptJp: "だいじな ファイルを まちがえて けして [ ___ ]。",
                        promptVi: "Tôi lỡ tay xóa nhầm mất tệp tài liệu quan trọng rồi.",
                        correctAnswer: "しまいました",
                        options: ["しまいました", "ありました", "おきました", "みました"],
                        explanation: "Diễn tả sự tiếc nuối khi làm hỏng việc ngoài ý muốn dùng 「Vて しまいました」.",
                        fullSentenceJp: "だいじな ファイルを まちがえて けして しまいました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 29, index: 3, quizType: .sentenceMatch,
                        promptJp: "この 本は とても おもしろかったので、[ ___ ]",
                        promptVi: "Vì quyển sách này rất thú vị nên tôi đã đọc xong hết trong 1 ngày.",
                        correctAnswer: "一日で よんで しまいました。",
                        options: ["一日で よんで しまいました。", "一日で よんで ありました。", "一日で よみません。", "一日で よまれて います。"],
                        explanation: "Nhấn mạnh việc đã đọc hết sạch cả quyển sách dùng 「よんで しまいました」.",
                        fullSentenceJp: "この 本は とても おもしろかったので、一日で よんで しまいました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 30,
                title: "Trạng thái có chủ đích てあります & Chuẩn bị ておきます",
                summary: "Phân biệt tha động từ để lại kết quả (Vてあります), làm sẵn để chuẩn bị/giữ nguyên (Vておきます) và まだ V(khẳng định).",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 30, index: 1,
                        title: "Kết quả do ai đó chủ đích làm: N が V(tha) てあります",
                        structure: "N が + Tha động từ(て) + あります。",
                        meaning: "N đã được làm sẵn / đang được đặt trong trạng thái...",
                        explanation: "Khác với 「ていきます/ています」 (tự động từ), 「Vてあります」 dùng THA ĐỘNG TỪ (nhưng tân ngữ vẫn chuyển thành 「が」 hoặc 「は」) để nhấn mạnh trạng thái hiện tại là kết quả do ai đó ĐÃ CHỦ ĐÍCH LÀM trước đó.",
                        exampleJp: "かべに カレンダーが かけて あります。",
                        exampleReading: "Kabe ni karendaa ga kakete arimasu.",
                        exampleVi: "Trên tường có treo sẵn một tờ lịch (ai đó đã treo lên)."
                    ),
                    GrammarPoint(
                        lessonNumber: 30, index: 2,
                        title: "Chuẩn bị sẵn / Để nguyên: Vて おきます",
                        structure: "N を + Vて おきます (nói tắt: ～ときます / ～どきます)",
                        meaning: "Làm sẵn trước cho việc sắp tới / Giữ nguyên như vậy",
                        explanation: "Có 3 sắc thái chính: (1) Chuẩn bị sẵn trước một sự kiện; (2) Thu dọn, xử lý xong sau một việc; (3) Để nguyên trạng thái hiện tại không thay đổi (Ví dụ: cứ bật đèn giữ nguyên đó nhé).",
                        exampleJp: "りょこうの まえに、きっぷを かって おきます。",
                        exampleReading: "Ryokou no mae ni, kippu o katte okimasu.",
                        exampleVi: "Trước chuyến đi du lịch, tôi mua sẵn vé trước."
                    ),
                    GrammarPoint(
                        lessonNumber: 30, index: 3,
                        title: "Vẫn còn đang...: まだ V(khẳng định)",
                        structure: "まだ + V(ています / てあります / です)",
                        meaning: "Vẫn đang / vẫn còn...",
                        explanation: "Khi 「まだ」 đi với câu KHẲNG ĐỊNH mang nghĩa 'vẫn còn' (ví dụ trời vẫn đang mưa). Ngược lại khi 「まだ」 đi với Vて いません mới mang nghĩa 'vẫn chưa' (Bài 31).",
                        exampleJp: "もう ５時ですが、まだ あかるいです。",
                        exampleReading: "Mou go-ji desu ga, mada akarui desu.",
                        exampleVi: "Đã 5 giờ rồi nhưng trời vẫn còn sáng."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 30, index: 1, quizType: .particleFill,
                        promptJp: "テーブルの うえに はなが かざって [ ___ ]。",
                        promptVi: "Trên bàn có cắm/trang trí hoa sẵn rồi.",
                        correctAnswer: "あります",
                        options: ["あります", "います", "おきます", "しまいます"],
                        explanation: "「かざります」 (trang trí) là tha động từ. Khi nêu trạng thái hoa đang được cắm sẵn bởi ai đó dùng 「Vて あります」.",
                        fullSentenceJp: "テーブルの うえに はなが かざって あります。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 30, index: 2, quizType: .particleFill,
                        promptJp: "あした 会議が あるので、しりょうを コピーして [ ___ ] なければなりません。",
                        promptVi: "Vì ngày mai có cuộc họp nên tôi phải photo sẵn tài liệu trước.",
                        correctAnswer: "おか",
                        options: ["おか", "おいて", "あり", "しまわ"],
                        explanation: "Ghép 「ておきます」 với 「なければなりません」: 「おきます」 chia thể ない bỏ ない là 「おか」 -> 「コピーして おかなければなりません」.",
                        fullSentenceJp: "しりょうを コピーして おかなければなりません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 30, index: 3, quizType: .sentenceMatch,
                        promptJp: "あした また つかいますから、はさみは ここに [ ___ ]",
                        promptVi: "Vì ngày mai lại dùng tiếp nên hãy cứ để nguyên cái kéo ở đây nhé.",
                        correctAnswer: "おいて おいて ください。",
                        options: ["おいて おいて ください。", "おいて あります。", "おいて しまいました。", "おいて いません。"],
                        explanation: "「おきます」 (đặt) kết hợp 「Vて おく」 (để nguyên giữ trạng thái cho lần dùng tới) -> 「おいて おいて ください」.",
                        fullSentenceJp: "あした また つかいますから、はさみは ここに おいて おいて ください。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 31 - 35 (N4)
    private static func buildLessons31To35() -> [GrammarLesson] {
        let g5 = groupTags[4]
        let g6 = groupTags[5]
        return [
            GrammarLesson(
                lessonNumber: 31,
                title: "Thể ý chí (Vよう)・Dự định (つもりです・予定です)",
                summary: "Cách chia thể ý chí Vよう, diễn đạt dự định với Vようとおもいます/おもっています, Vるつもりです và Nの/Vる予定です.",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 31, index: 1,
                        title: "Thể ý chí & Dự định: Vよう と おもっています",
                        structure: "Nhóm I: đuôi い → お + う (いきます → いこう)\nNhóm II: bỏ ます + よう (たべます → たべよう)\nNhóm III: くる → こよう / する → しよう",
                        meaning: "Tôi định sẽ làm V / Hãy cùng làm V (suồng sã của ましょう)",
                        explanation: "「Vよう と おもいます」 diễn đạt ý định vừa nảy ra tại thời điểm nói; còn 「Vよう と おもっています」 diễn đạt ý định đã ấp ủ từ trước và tiếp tục cho đến nay (có thể dùng cho ngôi thứ 3).",
                        exampleJp: "らいねん 日本へ りゅうがくしようと おもっています。",
                        exampleReading: "Rainen Nihon e ryuugaku shiyou to omotte imasu.",
                        exampleVi: "Tôi đang dự định sang năm sẽ đi du học Nhật Bản."
                    ),
                    GrammarPoint(
                        lessonNumber: 31, index: 2,
                        title: "Kế hoạch chắc chắn: Vる/Vない つもりです & 予定です",
                        structure: "Vる / Vない + つもりです (dự định cá nhân khá chắc chắn)\nVる / Nの + 予定です (lịch trình, kế hoạch đã lên lịch)",
                        meaning: "Có dự định (không) làm V / Theo kế hoạch dự kiến là...",
                        explanation: "「つもりです」 nhấn mạnh ý chí chủ quan rõ ràng hơn 「ようとおもっています」. 「予定です」 thường dùng cho lịch trình công ty, chuyến bay, kế hoạch đã ấn định ngày giờ (không dùng thể ない).",
                        exampleJp: "あしたは どこへも いかない つもりです。会議は 3時の 予定です。",
                        exampleReading: "Ashita wa doko e mo ikanai tsumori desu. Kaigi wa san-ji no yotei desu.",
                        exampleVi: "Ngày mai tôi dự định không đi đâu cả. Cuộc họp dự kiến vào lúc 3 giờ."
                    ),
                    GrammarPoint(
                        lessonNumber: 31, index: 3,
                        title: "Vẫn chưa hoàn thành: まだ Vて いません",
                        structure: "まだ + Vて いません。",
                        meaning: "Vẫn chưa làm V (tính đến hiện tại)",
                        explanation: "Diễn đạt một việc đáng lẽ nên làm hoặc đã đến lúc làm nhưng tính đến thời điểm hiện tại vẫn chưa xảy ra hoặc chưa xong. Trả lời cho câu hỏi 「もう ～ましたか」: 「いいえ、まだです / まだ Vていません」.",
                        exampleJp: "ひるごはんを まだ たべて いません。",
                        exampleReading: "Hirugohan o mada tabete imasen.",
                        exampleVi: "Tôi vẫn chưa ăn cơm trưa."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 31, index: 1, quizType: .particleFill,
                        promptJp: "なつやすみに くにへ [ ___ ] と おもっています。",
                        promptVi: "Tôi đang dự định kỳ nghỉ hè sẽ về nước.",
                        correctAnswer: "かえろう",
                        options: ["かえろう", "かえるよう", "かえりよう", "かえってよう"],
                        explanation: "「かえります」 là động từ Nhóm I (đuôi り). Đổi hàng い (り) sang hàng お (ろ) + う -> 「かえろう」.",
                        fullSentenceJp: "なつやすみに くにへ かえろうと おもっています。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 31, index: 2, quizType: .particleFill,
                        promptJp: "しゅっちょうは １しゅうかん [ ___ ] よていです。",
                        promptVi: "Chuyến công tác theo lịch dự kiến sẽ kéo dài 1 tuần.",
                        correctAnswer: "の",
                        options: ["の", "な", "に", "が"],
                        explanation: "Trước 「よていです」 nếu là danh từ (khoảng thời gian/sự kiện) phải nối bằng trợ từ 「の」 -> 「１しゅうかんの よていです」.",
                        fullSentenceJp: "しゅっちょうは １しゅうかんの よていです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 31, index: 3, quizType: .sentenceMatch,
                        promptJp: "レポートは もう おわりましたか。… いいえ、[ ___ ]",
                        promptVi: "Báo cáo bạn đã làm xong chưa? ... Chưa, tôi vẫn chưa viết xong.",
                        correctAnswer: "まだ かいて いません。",
                        options: ["まだ かいて いません。", "もう かいて います。", "まだ かきました。", "もう かきません。"],
                        explanation: "Trả lời phủ định cho 'đã xong chưa?' bằng 「いいえ、まだ Vて いません」.",
                        fullSentenceJp: "いいえ、まだ かいて いません。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 32,
                title: "Lời khuyên Vたほうがいい & Phỏng đoán でしょう / かもしれません",
                summary: "Đưa ra lời khuyên (Vた / Vない ほうがいいです) và các mức độ suy đoán từ chắc chắn (～でしょう) đến có khả năng nhỏ (～かもしれません).",
                groupTag: g5,
                points: [
                    GrammarPoint(
                        lessonNumber: 32, index: 1,
                        title: "Lời khuyên dứt khoát: Vた / Vない ほうが いいです",
                        structure: "Vた ほうが いいです (nên làm V)\nVない ほうが いいです (không nên làm V)",
                        meaning: "Nên / Không nên làm V",
                        explanation: "Khuyên trực tiếp người nghe nên chọn phương án nào trong hai lựa chọn (làm hoặc không làm). Chú ý: Dù nói về hiện tại/tương lai, động từ khẳng định vẫn chia ở THỂ た. Tránh dùng trực tiếp với cấp trên trừ khi cần thiết.",
                        exampleJp: "ねつが あるときは、おふろに はいらない ほうが いいですよ。",
                        exampleReading: "Netsu ga aru toki wa, ofuro ni hairanai hou ga ii desu yo.",
                        exampleVi: "Khi bị sốt thì bạn không nên vào bồn tắm đâu nhé."
                    ),
                    GrammarPoint(
                        lessonNumber: 32, index: 2,
                        title: "Phỏng đoán có căn cứ: ～でしょう (Tỷ lệ ~70-80%)",
                        structure: "V / Aい / Aな(bỏ だ) / N(bỏ だ) (thường) + でしょう",
                        meaning: "Chắc là... / Có lẽ sẽ... (suy đoán có căn cứ)",
                        explanation: "Dùng khi người nói đưa ra suy đoán dựa trên dữ liệu, dự báo thời tiết hay kinh nghiệm (thường hay đi với 「たぶん」). Lưu ý: Không thêm 「だ」 sau Aな và Danh từ.",
                        exampleJp: "ニュースに よると、あしたは たぶん あめが ふるでしょう。",
                        exampleReading: "Nyuusu ni yoru to, ashita wa tabun ame ga furu deshou.",
                        exampleVi: "Theo bản tin thì ngày mai có lẽ trời sẽ mưa."
                    ),
                    GrammarPoint(
                        lessonNumber: 32, index: 3,
                        title: "Khả năng có thể xảy ra: ～かもしれません (Tỷ lệ ~30-50%)",
                        structure: "V / Aい / Aな(bỏ だ) / N(bỏ だ) (thường) + かもしれません",
                        meaning: "Biết đâu chừng... / Có khả năng là...",
                        explanation: "Mức độ chắc chắn thấp hơn 「でしょう」, nêu một khả năng không loại trừ (thường đi với 「もしかしたら」 = biết đâu chừng). Chia thể quá khứ: 「～だったかもしれません」.",
                        exampleJp: "みちが こんでいますから、じかんに まにあわない かもしれません。",
                        exampleReading: "Michi ga konde imasu kara, jikan ni maniawanai kamoshiremasen.",
                        exampleVi: "Vì đường đang đông nên có thể tôi sẽ không kịp giờ mất."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 32, index: 1, quizType: .particleFill,
                        promptJp: "まいにち うんどうを [ ___ ] ほうが いいですよ。",
                        promptVi: "Mỗi ngày bạn nên tập thể dục thì tốt hơn đấy.",
                        correctAnswer: "した",
                        options: ["した", "する", "して", "しよう"],
                        explanation: "Cấu trúc đưa lời khuyên: 「Vた ほうが いいです」 luôn sử dụng động từ ở thể た.",
                        fullSentenceJp: "まいにち うんどうを した ほうが いいですよ。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 32, index: 2, quizType: .particleFill,
                        promptJp: "かぎが 見つかりません。もしかしたら かいしゃに わすれた [ ___ ]。",
                        promptVi: "Không tìm thấy chìa khóa. Biết đâu chừng tôi đã quên ở công ty rồi.",
                        correctAnswer: "かもしれません",
                        options: ["かもしれません", "でしょう", "ほうがいいです", "つもりです"],
                        explanation: "Trạng từ 「もしかしたら」 luôn đi cặp với 「～かもしれません」 (biết đâu chừng/có lẽ đã...).",
                        fullSentenceJp: "もしかしたら かいしゃに わすれた かもしれません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 32, index: 3, quizType: .sentenceMatch,
                        promptJp: "あたまが いたいなら、[ ___ ]",
                        promptVi: "Nếu bị đau đầu thì hôm nay bạn nên nghỉ ngơi đi.",
                        correctAnswer: "きょうは やすんだ ほうが いいですよ。",
                        options: ["きょうは やすんだ ほうが いいですよ。", "きょうは やすまない つもりです。", "きょうは やすんでも かまいません。", "きょうは やすんだ ところです。"],
                        explanation: "Đưa lời khuyên cho tình huống đau đầu: 「やすんだ ほうが いいですよ」.",
                        fullSentenceJp: "あたまが いたいなら、きょうは やすんだ ほうが いいですよ。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 33,
                title: "Thể Mệnh lệnh・Cấm đoán・Giải nghĩa・Truyền lời nhắn",
                summary: "Thể mệnh lệnh Vろ, cấm đoán Vるな, ra lệnh nhẹ Vなさい, giải nghĩa という意味です và chuyển lời ～と言っていました.",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 33, index: 1,
                        title: "Thể Mệnh lệnh (Vろ) & Thể Cấm đoán (Vるな)",
                        structure: "Mệnh lệnh: I (い→え: いけ) / II (ます→ろ: たべろ) / III (こい・しろ)\nCấm đoán: V(辞書形) + な (いそぐな・はいるな)\nNhẹ nhàng: V(ます) + なさい",
                        meaning: "Hãy làm ngay đi! / Cấm không được làm!",
                        explanation: "Thể mệnh lệnh và cấm đoán mang giọng điệu rất mạnh, chỉ dùng trong tình huống khẩn cấp (hỏa hoạn, tai nạn), biển báo giao thông, khẩu hiệu hoặc cha mẹ/huấn luyện viên. Người lớn nói nhẹ hơn dùng 「V(ます) + なさい」.",
                        exampleJp: "あぶない！はいるな！はやく にげろ！",
                        exampleReading: "Abunai! Hairu na! Hayaku nigero!",
                        exampleVi: "Nguy hiểm! Cấm vào! Mau chạy ngay đi!"
                    ),
                    GrammarPoint(
                        lessonNumber: 33, index: 2,
                        title: "Đọc biển báo & Giải thích nghĩa: ～という意味です",
                        structure: "～と よみます / かいてあります\nX は Y という意味(いみ)です",
                        meaning: "Đọc là ~ / Có ghi là ~ / X có nghĩa là Y",
                        explanation: "Dùng để hỏi và giải thích ký hiệu, chữ Kanji hoặc từ mới bằng 「～と いいますか / ～と かいてありますか / どういう いみですか」.",
                        exampleJp: "「立入禁止」は はいるな という意味です。",
                        exampleReading: "'Tachiiri kinshi' wa hairu na to iu imi desu.",
                        exampleVi: "Chữ 'Cấm vào' có nghĩa là không được phép đi vào."
                    ),
                    GrammarPoint(
                        lessonNumber: 33, index: 3,
                        title: "Tường thuật & Nhờ nhắn lại: ～と伝えていただけませんか",
                        structure: "Người が「(Câu nói / 体 thường)」と いっていました。\n～と つたえて いただけませんか。",
                        meaning: "Ai đó đã nói rằng... / Nhờ anh nhắn lại giúp rằng...",
                        explanation: "Trích dẫn điều người thứ 3 đã nói trước đó (thường chia ở thể thông thường) hoặc nhờ người nghe truyền đạt lại một tin nhắn lịch sự.",
                        exampleJp: "すみませんが、田中さんに「あした 10時に あいます」と つたえて いただけませんか。",
                        exampleReading: "Sumimasen ga, Tanaka-san ni 'ashita juu-ji ni aimasu' to tsutaete itadakemasen ka.",
                        exampleVi: "Xin lỗi, anh có thể nhắn lại với anh Tanaka rằng ngày mai 10 giờ gặp nhau được không ạ?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 33, index: 1, quizType: .particleFill,
                        promptJp: "この 漢字は 「きけん」 [ ___ ] よみます。",
                        promptVi: "Chữ Hán này đọc là 'Kiken' (nguy hiểm).",
                        correctAnswer: "と",
                        options: ["と", "を", "に", "が"],
                        explanation: "Trích dẫn cách đọc hoặc nội dung chữ viết đi với động từ 「よみます / かいてあります」 dùng trợ từ 「と」.",
                        fullSentenceJp: "この 漢字は 「きけん」と よみます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 33, index: 2, quizType: .particleFill,
                        promptJp: "「駐車禁止」は ここに くるまを [ ___ ] という意味です。",
                        promptVi: "'Cấm đỗ xe' có nghĩa là không được đỗ ô tô ở đây.",
                        correctAnswer: "とめるな",
                        options: ["とめるな", "とめないな", "とめてな", "とめろ"],
                        explanation: "Thể cấm đoán lập từ Vる + な. 「とめます」 (Nhóm II) -> 「とめるな」.",
                        fullSentenceJp: "「駐車禁止」は ここに くるまを とめるな という意味です。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 33, index: 3, quizType: .sentenceMatch,
                        promptJp: "せんせいは、あした テストが あると [ ___ ]",
                        promptVi: "Cô giáo có nói rằng ngày mai sẽ có bài kiểm tra đấy.",
                        correctAnswer: "いっていました。",
                        options: ["いっていました。", "おもいました。", "きいてみました。", "かいてありました。"],
                        explanation: "Tường thuật lời nói của người thứ 3 (せんせい) dùng 「～と いっていました」.",
                        fullSentenceJp: "せんせいは、あした テストが あると いっていました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 34,
                title: "Làm theo (とおりに)・Sau khi (あとで)・Kèm theo (て/ないで)",
                summary: "Làm theo chỉ dẫn (Vた/Nのとおりに), trình tự sau khi hoàn tất (V1た/Nのあとで), hành động đính kèm hoặc làm việc này thay vì việc kia (Vて/Vないで).",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 34, index: 1,
                        title: "Làm đúng theo: V1(thường) / N の とおりに、V2",
                        structure: "V(辞書形 / た) + とおりに、V2\nDanh từ + の + とおりに、V2",
                        meaning: "Làm V2 đúng như V1 / đúng theo N",
                        explanation: "Diễn đạt hành động V2 được thực hiện y hệt theo mẫu, lời nói hay hướng dẫn. Chú ý: Nếu hành động V1 đã diễn ra hoặc đã xem qua (như nhìn sách hướng dẫn rồi làm theo), dùng 「Vた とおりに」.",
                        exampleJp: "わたしが やった とおりに、やって みてください。",
                        exampleReading: "Watashi ga yatta toori ni, yatte mite kudasai.",
                        exampleVi: "Hãy thử làm theo đúng như cách tôi vừa làm."
                    ),
                    GrammarPoint(
                        lessonNumber: 34, index: 2,
                        title: "Sau khi kết thúc: V1た / N の あとで、V2",
                        structure: "V1た あとで、V2 / N の あとで、V2",
                        meaning: "Sau khi xong hoàn toàn V1 / sự kiện N thì làm V2",
                        explanation: "So với 「V1てから V2」 (nhấn mạnh trình tự liên tiếp hành động), 「V1た あとで」 nhấn mạnh mối quan hệ thời gian khách quan sau khi V1 đã hoàn toàn kết thúc, và có thể đi với danh từ + 「の」(しごとの あとで).",
                        exampleJp: "しごとの あとで、ともだちと ごはんを たべに いきます。",
                        exampleReading: "Shigoto no ato de, tomodachi to gohan o tabe ni ikimasu.",
                        exampleVi: "Sau giờ làm việc, tôi sẽ đi ăn cơm cùng bạn bè."
                    ),
                    GrammarPoint(
                        lessonNumber: 34, index: 3,
                        title: "Trạng thái kèm theo / Thay vì: V1て V2 & V1ないで V2",
                        structure: "V1て、V2 (kèm trạng thái V1 để làm V2)\nV1ないで、V2 (không làm V1 mà làm V2)",
                        meaning: "Làm V2 cùng với V1 / Không làm V1 mà làm V2",
                        explanation: "Giải thích cách thức tiến hành hành động V2: ăn kèm nước chấm hay không, uống cà phê cho đường hay không đường, hoặc lựa chọn không làm V1 mà chọn làm V2.",
                        exampleJp: "さしみは しょうゆを つけて たべます。かさを もたないで でかけました。",
                        exampleReading: "Sashimi wa shouyu o tsukete tabemasu. Kasa o motanaide dekakemashita.",
                        exampleVi: "Sashimi thì chấm với nước tương để ăn. Tôi đã ra ngoài mà không mang ô."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 34, index: 1, quizType: .particleFill,
                        promptJp: "せつめいしょ [ ___ ] とおりに くみたてました。",
                        promptVi: "Tôi đã lắp ráp đúng theo sách hướng dẫn.",
                        correctAnswer: "の",
                        options: ["の", "を", "に", "が"],
                        explanation: "Danh từ 「せつめいしょ」 đi với 「とおりに」 bắt buộc nối bằng 「の」.",
                        fullSentenceJp: "せつめいしょの とおりに くみたてました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 34, index: 2, quizType: .particleFill,
                        promptJp: "コーヒーは さとうを [ ___ ] で のみます。",
                        promptVi: "Cà phê thì tôi uống không bỏ đường.",
                        correctAnswer: "いれない",
                        options: ["いれない", "いれて", "いれる", "いれた"],
                        explanation: "Không làm hành động phụ đi kèm khi uống: 「Vない + で + V2」 -> 「いれないで のみます」.",
                        fullSentenceJp: "コーヒーは さとうを いれないで のみます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 34, index: 3, quizType: .sentenceMatch,
                        promptJp: "テストを だした あとで、[ ___ ]",
                        promptVi: "Sau khi nộp bài kiểm tra xong, tôi mới nhớ ra câu trả lời đúng.",
                        correctAnswer: "まちがいに きがつきました。",
                        options: ["まちがいに きがつきました。", "べんきょうします。", "じゅぎょうが はじまりました。", "てがみは まだです。"],
                        explanation: "Sau khi sự việc đã xảy ra xong (だした あとで), phát hiện ra lỗi sai ở mệnh đề sau.",
                        fullSentenceJp: "テストを だした あとで、まちがいに きがつきました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 35,
                title: "Thể Điều kiện (～ば・なら) & Càng... Càng (～ば～ほど)",
                summary: "Cách chia thể điều kiện Vば / Aければ / Nなら, phân biệt と/たら/ば/なら và mẫu tỉ lệ thuận ～ば～ほど.",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 35, index: 1,
                        title: "Cách chia Thể điều kiện: ～ば / ～なら",
                        structure: "V Nhóm I: い→えば (いきます→いけば)\nV Nhóm II: ます→れば (みます→みれば)\nV Nhóm III: くる→くれば / する→すれば\nAい → ければ | Aな/N → なら | Phủ định: ～なければ",
                        meaning: "Nếu có điều kiện này thì kết quả kia xảy ra",
                        explanation: "Diễn tả điều kiện cần thiết để dẫn tới một kết quả hợp lý. Chú ý: Nếu vế 1 là động từ hành động có chủ ý, vế 2 KHÔNG dùng câu mệnh lệnh, thỉnh cầu hay ý chí (những trường hợp đó nên dùng 「たら」).",
                        exampleJp: "ちかくに 駅が あれば、べんりですね。やすければ かいます。",
                        exampleReading: "Chikaku ni eki ga areba, benri desu ne. Yasukereba kaimasu.",
                        exampleVi: "Nếu gần đây có nhà ga thì tiện quá nhỉ. Nếu rẻ thì tôi sẽ mua."
                    ),
                    GrammarPoint(
                        lessonNumber: 35, index: 2,
                        title: "Tiếp nhận chủ đề: N なら & Hỏi lời khuyên Vばいいですか",
                        structure: "N なら、～ (nếu nói về N thì...)\nTừ để hỏi + V(điều kiện) ば いいですか",
                        meaning: "Nếu là (N) thì... / Làm sao thì được?",
                        explanation: "「N なら」 dùng tiếp nhận chủ đề người đối diện vừa nhắc đến để đưa lời khuyên hay thông tin liên quan đến N đó (Ví dụ: Nếu đi Kyoto thì mùa thu là đẹp nhất). 「Vば いいですか」 đồng nghĩa với 「Vたら いいですか」.",
                        exampleJp: "おんせんなら、はこねが いいですよ。どうやって いけば いいですか。",
                        exampleReading: "Onsen nara, Hakone ga ii desu yo. Dou yatte ikeba ii desu ka.",
                        exampleVi: "Nếu là suối nước nóng thì Hakone tuyệt lắm đấy. Đi bằng cách nào thì được ạ?"
                    ),
                    GrammarPoint(
                        lessonNumber: 35, index: 3,
                        title: "Càng... càng...: ～ば ～ほど",
                        structure: "Vば Vる + ほど\nAければ Aい + ほど\nAななら Aな + ほど",
                        meaning: "Càng... thì càng...",
                        explanation: "Lặp lại cùng một động từ hoặc tính từ ở dạng điều kiện + dạng từ điển (hoặc danh từ/tính từ な với なら...なほど) để chỉ mức độ biến đổi tỷ lệ thuận.",
                        exampleJp: "にほんごは べんきょうすれば するほど おもしろいです。",
                        exampleReading: "Nihongo wa benkyou sureba suru hodo omoshiroi desu.",
                        exampleVi: "Tiếng Nhật càng học càng thấy thú vị."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 35, index: 1, quizType: .particleFill,
                        promptJp: "じかんが [ ___ ]、ゆっくり 話したいです。",
                        promptVi: "Nếu có thời gian, tôi muốn nói chuyện thong thả.",
                        correctAnswer: "あれば",
                        options: ["あれば", "あるば", "あってば", "ありば"],
                        explanation: "「あります」 (Nhóm I, đuôi り) chia thể điều kiện ば đổi hàng い (り) sang hàng え (れ) + ば -> 「あれば」.",
                        fullSentenceJp: "じかんが あれば、ゆっくり 話したいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 35, index: 2, quizType: .particleFill,
                        promptJp: "この パソコンは つかえば [ ___ ] ほど つかいやすくなります。",
                        promptVi: "Chiếc máy tính này càng dùng càng trở nên dễ sử dụng.",
                        correctAnswer: "つかう",
                        options: ["つかう", "つかえば", "つかって", "つかった"],
                        explanation: "Mẫu 「V1ば + V1(辞書形) + ほど」 (càng ~ càng): 「つかえば つかう ほど」.",
                        fullSentenceJp: "この パソコンは つかえば つかう ほど つかいやすくなります。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 35, index: 3, quizType: .sentenceMatch,
                        promptJp: "A：あたらしい スマホを かいたいんです。 B：スマホなら、[ ___ ]",
                        promptVi: "A: Tôi muốn mua điện thoại mới. B: Nếu là điện thoại thì cửa hàng kia rẻ đấy.",
                        correctAnswer: "あそこの みせが やすいですよ。",
                        options: ["あそこの みせが やすいですよ。", "あそこの みせは やすかったです。", "あそこへ いかないで ください。", "スマホは もちません。"],
                        explanation: "Tiếp nhận chủ đề 「スマホ」 bằng 「なら」 để tư vấn địa điểm mua tốt.",
                        fullSentenceJp: "スマホなら、あそこの みせが やすいですよ。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 36 - 40 (N4)
    private static func buildLessons36To40() -> [GrammarLesson] {
        let g6 = groupTags[5]
        let g7 = groupTags[6]
        return [
            GrammarLesson(
                lessonNumber: 36,
                title: "Mục đích & Biến đổi năng lực (ように・ようになります・ようにします)",
                summary: "Làm V2 để đạt được mục tiêu trạng thái V1 (Vる/ない ように), trở nên có thể (Vる ようになります) và cố gắng duy trì thói quen (ようにします).",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 36, index: 1,
                        title: "Mục đích trạng thái: V1る / V1ない ように、V2",
                        structure: "V1(thường: từ điển khả năng / tự động từ / ない) + ように、V2",
                        meaning: "Làm V2 để (có thể / không bị) V1",
                        explanation: "Khác với 「ために」 (dùng động từ có chủ ý), phía trước 「ように」 là trạng thái không mang chủ ý trực tiếp như động từ khả năng (話せるように), phủ định (わすれないように), hay tự động từ (わかるように).",
                        exampleJp: "漢字が かけるように、まいにち れんしゅうしています。",
                        exampleReading: "Kanji ga kakeru you ni, mainichi renshuu shite imasu.",
                        exampleVi: "Tôi luyện tập hàng ngày để có thể viết được chữ Hán."
                    ),
                    GrammarPoint(
                        lessonNumber: 36, index: 2,
                        title: "Biến đổi khả năng / thói quen: Vる ように なります",
                        structure: "V(thể từ điển khả năng / Vる / Vない) + ように なりました / なります",
                        meaning: "Đã trở nên có thể / Đã dần chuyển sang trạng thái mới",
                        explanation: "Diễn tả một sự biến đổi trạng thái, năng lực hoặc tập quán mà trước đây không thể/không làm nhưng nay đã trở nên làm được (hoặc ngược lại dùng 「Vなく なりました」).",
                        exampleJp: "にほんごが すこし 話せるように なりました。",
                        exampleReading: "Nihongo ga sukoshi hanaseru you ni narimashita.",
                        exampleVi: "Tôi đã trở nên nói được một chút tiếng Nhật rồi."
                    ),
                    GrammarPoint(
                        lessonNumber: 36, index: 3,
                        title: "Cố gắng thực hiện / giữ thói quen: Vる / Vない ように します",
                        structure: "Vる / Vない + ように しています (đang cố gắng duy trì)\nVる / Vない + ように してください (xin hãy cố gắng)",
                        meaning: "Cố gắng để (luôn / không) làm V",
                        explanation: "Biểu thị nỗ lực ý thức hàng ngày để rèn luyện một thói quen tốt hoặc tránh điều không tốt. Khi nhắc nhở ai giữ quy định dùng 「～ように してください」.",
                        exampleJp: "けんこうのために、まいにち やさいを たべるように しています。",
                        exampleReading: "Kenkou no tame ni, mainichi yasai o taberu you ni shite imasu.",
                        exampleVi: "Vì sức khỏe, tôi cố gắng mỗi ngày đều ăn rau củ."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 36, index: 1, quizType: .particleFill,
                        promptJp: "うしろの 人にも [ ___ ]、おおきな こえで 話します。",
                        promptVi: "Tôi nói giọng to để người ở phía sau cũng có thể nghe thấy.",
                        correctAnswer: "きこえるように",
                        options: ["きこえるように", "きこえるために", "きくように", "きくために"],
                        explanation: "「きこえます」 là động từ tự nhiên không mang chủ ý -> bắt buộc đi với 「ように」.",
                        fullSentenceJp: "うしろの 人にも きこえるように、おおきな こえで 話します。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 36, index: 2, quizType: .particleFill,
                        promptJp: "さいきん 目が わるくなって、小さい 字が よめなく [ ___ ]。",
                        promptVi: "Gần đây mắt kém đi nên tôi đã không đọc được chữ nhỏ nữa.",
                        correctAnswer: "なりました",
                        options: ["なりました", "しました", "いました", "ありました"],
                        explanation: "Chuyển từ đọc được sang không đọc được (biến đổi năng lực không chủ ý) -> 「V(khả năng) ない」 bỏ い thành なく + 「なりました」.",
                        fullSentenceJp: "小さい 字が よめなく なりました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 36, index: 3, quizType: .sentenceMatch,
                        promptJp: "かいぎに おくれないように、[ ___ ]",
                        promptVi: "Để không bị trễ cuộc họp, tôi luôn ra khỏi nhà sớm.",
                        correctAnswer: "いつも はやく うちを でるように しています。",
                        options: ["いつも はやく うちを でるように しています。", "いつも はやく うちを でるように なりました。", "おくれて しまいました。", "うちへ かえりました。"],
                        explanation: "Sự cố gắng có ý thức của bản thân (đi sớm để không trễ) dùng 「～ように しています」.",
                        fullSentenceJp: "かいぎに おくれないように、いつも はやく うちを でるように しています。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 37,
                title: "Thể Bị động (Vられます) & Nguyên liệu (から・で)",
                summary: "Cách chia thể bị động, bị động trực tiếp (N1はN2にVられます), bị động chịu phiền toái có tân ngữ を, bị động khách quan によって và から/でつくります.",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 37, index: 1,
                        title: "Cách chia Thể Bị động & Bị động trực tiếp",
                        structure: "I: い→あ + れます (しかられます)\nII: ます→られます (ほめられます)\nIII: くる→こられます / する→されます\nCâu: N1(người nhận) は N2(người làm) に Vられます",
                        meaning: "N1 bị / được N2 làm V",
                        explanation: "N1 là chủ ngữ (người/vật chịu tác động), N2 là người thực hiện hành động đi với 「に」. Chú ý Nhóm I kết thúc bằng âm 「い」 (chữ い) đổi thành 「わ」: いいます → いわれます.",
                        exampleJp: "わたしは 先生に ほめられました。おとうとは 母に しかられました。",
                        exampleReading: "Watashi wa sensei ni homeraremashita. Otouto wa haha ni shikararemashita.",
                        exampleVi: "Tôi đã được thầy giáo khen. Em trai bị mẹ mắng."
                    ),
                    GrammarPoint(
                        lessonNumber: 37, index: 2,
                        title: "Bị động gián tiếp (Phiền toái) & Vật làm chủ ngữ",
                        structure: "N1 は N2 に N3 を Vられました (bị làm phiền/tổn hại)\nN(vật) が/は Vられます (sự kiện/sáng chế によって)",
                        meaning: "Bị ai đó tác động lên đồ của mình (bất mãn) / Được tổ chức, sáng chế bởi...",
                        explanation: "Khi ai đó làm điều gì lên đồ vật của mình hoặc làm mình chịu thiệt thòi (trời mưa làm mình ướt, bị dẫm chân, bị đọc mất nhật ký), dùng bị động gián tiếp với 「に ～ を Vられました」. Với phát minh nghệ thuật dùng 「によって」.",
                        exampleJp: "あめに ふられました。でんわは ベルによって はつめいされました。",
                        exampleReading: "Ame ni furaremashita. Denwa wa Beru ni yotte hatsumei saremashita.",
                        exampleVi: "Tôi bị dính mưa (nên ướt/phiền). Điện thoại được phát minh bởi ông Bell."
                    ),
                    GrammarPoint(
                        lessonNumber: 37, index: 3,
                        title: "Chất liệu tạo thành: N で / N から つくります",
                        structure: "Vật liệu nhìn thấy được + で つくります\nNguyên liệu biến đổi tính chất + から つくります",
                        meaning: "Được làm bằng (gỗ, giấy...) / Được chế biến từ (sữa, nho...)",
                        explanation: "Dùng 「で」 khi vật liệu gốc vẫn giữ nguyên hình thái nhìn thấy (nhà làm bằng gỗ), dùng 「から」 khi nguyên liệu đã qua lên men hoặc biến đổi hoàn toàn thành chất khác (rượu nho từ nho, bia từ lúa mạch).",
                        exampleJp: "この 机は 木で つくられています。ワインは ぶどうから つくられます。",
                        exampleReading: "Kono tsukue wa ki de tsukurarete imasu. Wain wa budou kara tsukuraremasu.",
                        exampleVi: "Cái bàn này được làm bằng gỗ. Rượu vang được làm từ nho."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 37, index: 1, quizType: .particleFill,
                        promptJp: "こんざつした でんしゃの なかで、となりの 人に あしを [ ___ ]。",
                        promptVi: "Trong tàu điện đông đúc, tôi bị người bên cạnh giẫm lên chân.",
                        correctAnswer: "ふまれました",
                        options: ["ふまれました", "ふみました", "ふみられました", "ふまれさせました"],
                        explanation: "「ふみます」 (giẫm, Nhóm I) chuyển sang bị động: đuôi み -> ま + れます -> 「ふまれました」.",
                        fullSentenceJp: "となりの 人に あしを ふまれました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 37, index: 2, quizType: .particleFill,
                        promptJp: "その ゆうめいな しょうせつは むらかみはるき [ ___ ] かかれました。",
                        promptVi: "Cuốn tiểu thuyết nổi tiếng đó được viết bởi Haruki Murakami.",
                        correctAnswer: "によって",
                        options: ["によって", "に", "から", "として"],
                        explanation: "Vật sáng tác/phát minh (しょうせつ, え, でんわ...) đi với tác giả/nhà phát minh dùng 「によって」.",
                        fullSentenceJp: "その ゆうめいな しょうせつは むらかみはるきによって かかれました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 37, index: 3, quizType: .sentenceMatch,
                        promptJp: "日本酒は おこめから [ ___ ]",
                        promptVi: "Rượu Sake Nhật Bản được chế biến từ gạo.",
                        correctAnswer: "つくられます。",
                        options: ["つくられます。", "つくります。", "つくれられます。", "つくって おきます。"],
                        explanation: "Câu chủ ngữ là đồ vật (日本酒) giải thích quy trình sản xuất khách quan nên chia bị động 「つくられます」.",
                        fullSentenceJp: "日本酒は おこめから つくられます。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 38,
                title: "Danh từ hóa động từ bằng ～の (Vるのは・Vのが・Vのを)",
                summary: "Biến động từ thành cụm danh từ với ～の để làm chủ ngữ (Vるのは A です), đối tượng sở thích/năng lực (Vのが), tân ngữ (Vのを), hoặc nhấn mạnh (～のは N です).",
                groupTag: g6,
                points: [
                    GrammarPoint(
                        lessonNumber: 38, index: 1,
                        title: "Chủ ngữ nhận xét: Vる のは + Tính từ です",
                        structure: "V(辞書形) + のは + A(おもしろい / たいへん / むずかしい…) です。",
                        meaning: "Việc làm V thì (thú vị / vất vả / khó...)",
                        explanation: "Thêm 「の」 sau động từ thể từ điển biến cả cụm động từ thành một danh từ trừu tượng ('việc làm V'). So với 「こと」 (bài 18), 「の」 mềm mại và hay dùng với cảm nhận trực tiếp trong hội thoại.",
                        exampleJp: "テニスを するのは たのしいです。",
                        exampleReading: "Tenisu o suru no wa tanoshii desu.",
                        exampleVi: "Việc chơi quần vợt thật là vui."
                    ),
                    GrammarPoint(
                        lessonNumber: 38, index: 2,
                        title: "Sở thích & Năng lực: Vる のが (好き/じょうず/はやい)",
                        structure: "V(辞書形) + のが + すき / きらい / じょうず / へた / はやい です。",
                        meaning: "Thích / Giỏi / Nhanh trong việc làm V",
                        explanation: "Các tính từ chỉ sở thích/năng lực vốn đòi hỏi trợ từ 「が」. Động từ trước 「のが」 chia ở thể từ điển.",
                        exampleJp: "わたしの ともだちは りょうりを つくるのが じょうずです。",
                        exampleReading: "Watashi no tomodachi wa ryouri o tsukuru no ga jouzu desu.",
                        exampleVi: "Bạn tôi rất khéo (giỏi) việc nấu ăn."
                    ),
                    GrammarPoint(
                        lessonNumber: 38, index: 3,
                        title: "Quên/Nhớ (Vるのを) & Câu chẻ nhấn mạnh (～のは N です)",
                        structure: "V(thường) + のを + わすれました / しっていますか\n(Mệnh đề thường) のは N/Thời gian/Địa điểm です。",
                        meaning: "Quên làm V / Chính [N] mới là cái mà...",
                        explanation: "「わすれます / おぼえています / しっています」 luôn dùng 「のを」 (KHÔNG dùng 「ことを」 trừ trường hợp わすれます ở nghĩa nhớ ký ức). Mẫu 「～のは … です」 dùng để nhấn mạnh phần thông tin đặt trước です.",
                        exampleJp: "まどを しめるのを わすれました。わたしが 生まれたのは ベトナムです。",
                        exampleReading: "Mado o shimeru no o wasuremashita. Watashi ga umareta no wa Betonamu desu.",
                        exampleVi: "Tôi quên mất việc đóng cửa sổ rồi. Nơi tôi sinh ra chính là Việt Nam."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 38, index: 1, quizType: .particleFill,
                        promptJp: "あした かいぎが ある [ ___ ] しっていますか。",
                        promptVi: "Bạn có biết việc ngày mai có cuộc họp không?",
                        correctAnswer: "のを",
                        options: ["のを", "ことが", "のが", "に"],
                        explanation: "Danh từ hóa mệnh đề làm tân ngữ cho động từ 「しっています」 dùng 「のを」.",
                        fullSentenceJp: "あした かいぎが あるのを しっていますか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 38, index: 2, quizType: .particleFill,
                        promptJp: "山田さんは しゃしんを とる [ ___ ] すきです。",
                        promptVi: "Anh Yamada rất thích việc chụp ảnh.",
                        correctAnswer: "のが",
                        options: ["のが", "のを", "のは", "ことが"],
                        explanation: "Tính từ chỉ sở thích 「すきです」 đi với trợ từ 「が」 -> 「とるのが すきです」.",
                        fullSentenceJp: "山田さんは しゃしんを とるのが すきです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 38, index: 3, quizType: .sentenceMatch,
                        promptJp: "でんわばんごうを まちがえて、かぞくに でんわするのを [ ___ ]",
                        promptVi: "Tôi nhầm số điện thoại rồi, tôi quên mất không ghi chép việc gọi về cho gia đình (quên gọi cho gia đình).",
                        correctAnswer: "わすれて しまいました。",
                        options: ["わすれて しまいました。", "じょうずです。", "むずかしいです。", "しっています。"],
                        explanation: "Tân ngữ đi với 「のを」 phù hợp nhất về nghĩa ở đây là hành động 'quên làm mất rồi' (わすれて しまいました).",
                        fullSentenceJp: "かぞくに でんわするのを わすれて しまいました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 39,
                title: "Nguyên nhân khách quan (て・で・ので) & Giữa chừng (途中で)",
                summary: "Nêu nguyên nhân gắn với cảm xúc/khả năng bằng Vて/Aくて/Nで, nguyên nhân lịch sự ～ので (so sánh với から) và giữa chừng ～途中で.",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 39, index: 1,
                        title: "Nguyên nhân cảm xúc/tình huống: Vて / Vなくて / Aくて / Aなで",
                        structure: "Vて / Vなくて、～\nAい(bỏ い)くて / Aな(bỏ な)で、～\nDanh từ + で、～ (thiên tai, tai nạn, ốm)",
                        meaning: "Vì ~ (nên nảy sinh cảm xúc / không thể làm gì)",
                        explanation: "Vế 2 KHÔNG chứa ý chí, rủ rê hay mệnh lệnh mà thường là tính từ cảm xúc (vui, buồn, giật mình, an tâm) hoặc trạng thái không thể (こまります, いけません). Danh từ dùng 「N で」 hay nói về tai nạn, động đất, tắc đường, bệnh tật.",
                        exampleJp: "ニュースを きいて、びっくりしました。じこで でんしゃが とまりました。",
                        exampleReading: "Nyuusu o kiite, bikkuri shimashita. Jiko de densha ga tomarimashita.",
                        exampleVi: "Nghe tin xong tôi giật mình. Vì tai nạn nên tàu điện đã dừng lại."
                    ),
                    GrammarPoint(
                        lessonNumber: 39, index: 2,
                        title: "Nguyên nhân khách quan lịch sự: ～ので",
                        structure: "V / Aい (thường) + ので\nAな / Danh từ + な + ので",
                        meaning: "Vì / Bởi vì ~ (lịch sự, nhẹ nhàng)",
                        explanation: "So với 「～から」 mang tính chủ quan cá nhân, 「～ので」 diễn tả nguyên nhân khách quan, tự nhiên nên nghe lịch sự, mềm mỏng và ít mang tính áp đặt hơn — rất phù hợp khi xin phép hoặc giải thích lý do. Chú ý Aな và Danh từ phải thêm 「な」 trước ので.",
                        exampleJp: "ようじが あるので、おさきに しつれいします。あめなので、いきません。",
                        exampleReading: "Youji ga aru node, osaki ni shitsurei shimasu. Ame na node, ikimasen.",
                        exampleVi: "Vì có việc bận nên tôi xin phép về trước ạ. Vì trời mưa nên tôi không đi."
                    ),
                    GrammarPoint(
                        lessonNumber: 39, index: 3,
                        title: "Giữa chừng: N の / Vる + とちゅうで",
                        structure: "N(danh động từ) の とちゅうで、～\nVる とちゅうで、～",
                        meaning: "Giữa đường đi / Trong lúc đang làm dở V",
                        explanation: "Biểu thị một sự việc bất ngờ xảy ra khi đang trên đường di chuyển hoặc đang thực hiện giữa chừng một hành động khác.",
                        exampleJp: "かいしゃへ いく とちゅうで、ともだちに あいました。",
                        exampleReading: "Kaisha e iku tochuu de, tomodachi ni aimashita.",
                        exampleVi: "Trên đường đến công ty, tôi đã tình cờ gặp bạn."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 39, index: 1, quizType: .particleFill,
                        promptJp: "かぞくに あえて、ほんとうに [ ___ ]。",
                        promptVi: "Vì gặp được gia đình nên tôi thực sự rất vui.",
                        correctAnswer: "うれしかったです",
                        options: ["うれしかったです", "うれしいためです", "うれしいようです", "うれしいはずです"],
                        explanation: "「あえて」 (thể て của あえます) nêu nguyên nhân trực tiếp khiến cảm xúc tự nhiên bộc lộ ở vế sau -> 「うれしかったです」.",
                        fullSentenceJp: "かぞくに あえて、ほんとうに うれしかったです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 39, index: 2, quizType: .particleFill,
                        promptJp: "きょうは 日曜日 [ ___ ]、ぎんこうは やすみです。",
                        promptVi: "Vì hôm nay là Chủ Nhật nên ngân hàng nghỉ.",
                        correctAnswer: "なので",
                        options: ["なので", "ので", "だので", "での"],
                        explanation: "Danh từ 「日曜日」 đi với 「ので」 bắt buộc phải có 「な」 ở giữa -> 「日曜日なので」.",
                        fullSentenceJp: "きょうは 日曜日なので、ぎんこうは やすみです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 39, index: 3, quizType: .sentenceMatch,
                        promptJp: "マラソンの とちゅうで、[ ___ ]",
                        promptVi: "Giữa chừng cuộc chạy marathon, chân tôi bị đau nên đã dừng lại.",
                        correctAnswer: "あしが いたくなって、やめました。",
                        options: ["あしが いたくなって、やめました。", "いつも あさ はしります。", "あした かいぎに いきます。", "もう おわって しまいました。"],
                        explanation: "「とちゅうで」 (giữa chừng sự việc) khớp với tình huống bị đau chân nên bỏ cuộc giữa chừng.",
                        fullSentenceJp: "マラソンの とちゅうで、あしが いたくなって、やめました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 40,
                title: "Câu hỏi lồng (～か・～かどうか)・Làm thử (てみます)・～さ",
                summary: "Nhúng câu hỏi có hoặc không từ để hỏi vào câu (～か / ～かどうか), làm thử Vてみます và biến tính từ い thành danh từ (+さ).",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 40, index: 1,
                        title: "Câu hỏi lồng có từ để hỏi: Từ để hỏi + 普通形 + か",
                        structure: "Từ để hỏi + V/A(thường) + か + しりません / わかりません / ききます\n※ Aな và Danh từ KHÔNG dùng だ trước か",
                        meaning: "Không biết / Hỏi xem là (cái gì / khi nào / ở đâu...)",
                        explanation: "Khi biến một câu hỏi chứa từ để hỏi thành một vế nhỏ trong câu lớn, động từ/tính từ い giữ thể thông thường + 「か」, riêng Aな và Danh từ bỏ 「だ」 đi thẳng vào 「か」.",
                        exampleJp: "ミラーさんが いつ くるか わかりません。かれが だれか しっていますか。",
                        exampleReading: "Miraa-san ga itsu kuru ka wakarimasen. Kare ga dare ka shitte imasu ka.",
                        exampleVi: "Tôi không biết khi nào anh Miller sẽ tới. Bạn có biết anh ấy là ai không?"
                    ),
                    GrammarPoint(
                        lessonNumber: 40, index: 2,
                        title: "Câu hỏi lồng Có/Không: Thể thông thường + かどうか",
                        structure: "V/Aい(thường) + かどうか\nAな/Danh từ (bỏ だ) + かどうか",
                        meaning: "...có hay không / ...hay là không",
                        explanation: "Khi câu hỏi được lồng không có từ để hỏi (Yes/No question), dùng 「～かどうか」 nối vào động từ tiếp theo như biết, nhớ, kiểm tra, thử xem.",
                        exampleJp: "しけんに ごうかくしたかどうか、まだ わかりません。",
                        exampleReading: "Shiken ni goukaku shita ka dou ka, mada wakarimasen.",
                        exampleVi: "Tôi vẫn chưa biết liệu mình có đỗ kỳ thi hay không."
                    ),
                    GrammarPoint(
                        lessonNumber: 40, index: 3,
                        title: "Làm thử (Vてみます) & Danh từ hóa tính từ (Aい → Aさ)",
                        structure: "Vて みます (thử làm xem sao)\nAい(bỏ い) + さ (たかさ, おおきさ, おもさ, ながさ)",
                        meaning: "Thử làm V xem sao / Danh từ hóa mức độ (độ cao, độ lớn, độ nặng...)",
                        explanation: "「Vて みます」 diễn đạt hành động thử làm một việc để xem kết quả thế nào. Đuôi 「～さ」 biến tính từ đuôi い thành danh từ chỉ đại lượng đo lường được (cao -> chiều cao, nặng -> trọng lượng).",
                        exampleJp: "この くつを はいて みても いいですか。ふじさんの たかさは 3776メートルです。",
                        exampleReading: "Kono kutsu o haite mite mo ii desu ka. Fujisan no takasa wa 3776-meetoru desu.",
                        exampleVi: "Tôi đi thử đôi giày này có được không? Chiều cao núi Phú Sĩ là 3776 mét."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 40, index: 1, quizType: .particleFill,
                        promptJp: "この りょうりが おいしい [ ___ ]、たべて みないと わかりません。",
                        promptVi: "Món này có ngon hay không thì phải ăn thử mới biết được.",
                        correctAnswer: "かどうか",
                        options: ["かどうか", "のか", "か", "とは"],
                        explanation: "Mệnh đề lồng 'ngon hay không' (không có từ để hỏi) dùng 「～かどうか」.",
                        fullSentenceJp: "この りょうりが おいしいかどうか、たべて みないと わかりません。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 40, index: 2, quizType: .particleFill,
                        promptJp: "にもつの [ ___ ] を はかって ください。",
                        promptVi: "Xin hãy cân trọng lượng (độ nặng) của hành lý giúp tôi.",
                        correctAnswer: "おもさ",
                        options: ["おもさ", "おもい", "おもく", "おもみ"],
                        explanation: "Tính từ 「おもい」 (nặng) bỏ い thêm 「さ」 thành danh từ 「おもさ」 (trọng lượng).",
                        fullSentenceJp: "にもつの おもさを はかって ください。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 40, index: 3, quizType: .sentenceMatch,
                        promptJp: "パーティーが なんじに おわるか、[ ___ ]",
                        promptVi: "Bữa tiệc kết thúc lúc mấy giờ thì hãy thử hỏi thầy giáo xem.",
                        correctAnswer: "せんせいに きいて みましょう。",
                        options: ["せんせいに きいて みましょう。", "せんせいが きました。", "せんせいは しりませんでした。", "なんじに おわります。"],
                        explanation: "Câu hỏi lồng 「なんじに おわるか」 kết hợp với hành động 'hỏi thử xem' (きいて みましょう).",
                        fullSentenceJp: "パーティーが なんじに おわるか、せんせいに きいて みましょう。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 41 - 45 (N4)
    private static func buildLessons41To45() -> [GrammarLesson] {
        let g7 = groupTags[6]
        let g8 = groupTags[7]
        return [
            GrammarLesson(
                lessonNumber: 41,
                title: "Cho và Nhận kính trọng / khiêm nhường (いただきます・くださいます・やります)",
                summary: "Phân biệt bậc trên-dưới trong cho nhận vật và hành động: いただきます, くださいます, さしあげます / やります, Vて くださいませんか và N に (làm kỷ niệm/cảm ơn).",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 41, index: 1,
                        title: "Cho và nhận đồ vật theo ngôi thứ trên - dưới",
                        structure: "Trên/Lạ cho mình: (Cấp trên) が わたしに N を くださいます。\nMình nhận từ trên: わたしは (Cấp trên) に/から N を いただきます。\nMình cho dưới/con/cây/vật: わたしは (Con/Cây/Em) に N を やります。",
                        meaning: "Cấp trên ban tặng cho mình / Mình trân trọng đón nhận / Cho bậc dưới (cây, con)",
                        explanation: "「くださいます」 là tôn kính ngữ của くれます (người trên cho mình). 「いただきます」 là khiêm tốn ngữ của もらいます (mình nhận từ người trên). 「やります」 thay cho あげます khi cho trẻ nhỏ, động vật hoặc tưới cây (「さしあげます」 dùng cho cấp trên nhưng dễ gây áp lực nếu tặng đồ).",
                        exampleJp: "ぶちょうが わたしに おみやげを くださいました。はなに みずを やります。",
                        exampleReading: "Buchou ga watashi ni omiyage o kudasaimashita. Hana ni mizu o yarimasu.",
                        exampleVi: "Trưởng phòng đã tặng quà lưu niệm cho tôi. Tôi tưới nước cho hoa."
                    ),
                    GrammarPoint(
                        lessonNumber: 41, index: 2,
                        title: "Cho nhận hành động: Vて いただきます / くださいます / やります",
                        structure: "Cấp trên が Vて くださいます (làm giúp mình)\nわたしは Cấp trên に Vて いただきます (được ngài làm cho)\nVて くださいませんか (nhờ người khác làm giúp)",
                        meaning: "Được cấp trên làm giúp cho / Xin anh chị vui lòng làm V giúp",
                        explanation: "Mức độ lịch sự tăng dần khi nhờ cậy: Vて ください < Vて くださいませんか < Vて いただけませんか. Còn khi kể lại thầy cô/sếp đã giúp mình thì dùng 「～て くださいました」 hoặc 「～て いただきました」.",
                        exampleJp: "せんせいに まちがいを なおして いただきました。きょうしつを みて くださいませんか。",
                        exampleReading: "Sensei ni machigai o naoshite itadakimashita. Kyoushitsu o mite kudasaimasen ka.",
                        exampleVi: "Tôi đã được thầy giáo sửa lỗi cho. Anh/chị có thể vui lòng xem giúp phòng học không?"
                    ),
                    GrammarPoint(
                        lessonNumber: 41, index: 3,
                        title: "Quà nhân dịp đặc biệt: N(dịp) に N(quà) を くれます/あげます",
                        structure: "N1(kỷ niệm / sinh nhật / cảm ơn) に N2 を もらいます / あげます。",
                        meaning: "Tặng/Nhận N2 nhân dịp / để cảm ơn / làm kỷ niệm N1",
                        explanation: "Trợ từ 「に」 đặt sau danh từ chỉ lý do/dịp trao quà như: おいわいに (chúc mừng), おれいに (cảm ơn), いいきねんに (làm kỷ niệm đẹp), けっこんの おいわいに (mừng kết hôn).",
                        exampleJp: "たんじょうびの おいわいに ともだちに 花を あげました。",
                        exampleReading: "Tanjoubi no oiwai ni tomodachi ni hana o agemashita.",
                        exampleVi: "Tôi đã tặng hoa cho bạn nhân dịp mừng sinh nhật."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 41, index: 1, quizType: .particleFill,
                        promptJp: "しゃちょうが わたしに いい ほんを [ ___ ]。",
                        promptVi: "Giám đốc đã tặng cho tôi một quyển sách hay.",
                        correctAnswer: "くださいました",
                        options: ["くださいました", "いただきました", "やりました", "あげました"],
                        explanation: "Chủ ngữ là người trên (しゃちょう) thực hiện hành động cho mình (わたしに) -> dùng tôn kính ngữ 「くださいます / くださいました」.",
                        fullSentenceJp: "しゃちょうが わたしに いい ほんを くださいました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 41, index: 2, quizType: .particleFill,
                        promptJp: "いぬに えさを [ ___ ] か。",
                        promptVi: "Bạn đã cho chó ăn chưa?",
                        correctAnswer: "やりました",
                        options: ["やりました", "くださいました", "さしあげました", "いただきました"],
                        explanation: "Khi cho động vật, cây cối hoặc trẻ em nhỏ hơn mình nhiều, dùng động từ 「やります」.",
                        fullSentenceJp: "いぬに えさを やりましたか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 41, index: 3, quizType: .sentenceMatch,
                        promptJp: "けっこんの おいわいに、かぞくから [ ___ ]",
                        promptVi: "Nhân dịp chúc mừng đám cưới, tôi đã nhận được đồ ăn/đồ lưu niệm quý từ gia đình.",
                        correctAnswer: "すてきな とけいを いただきました。",
                        options: ["すてきな とけいを いただきました。", "とけいを ください。", "とけいを やりました。", "とけいが つくれました。"],
                        explanation: "Nhận từ người khác (かぞくから) trong câu lịch sự dùng 「いただきました」.",
                        fullSentenceJp: "けっこんの おいわいに、かぞくから すてきな とけいを いただきました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 42,
                title: "Mục đích (ために)・Công dụng (のに)・Lượng từ (は・も)",
                summary: "Diễn đạt mục đích rõ ràng với Vる/Nの ために, nêu công dụng/chi phí cần thiết với Vるのに / Nに, và đánh giá lượng từ bằng は (ít nhất) / も (những).",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 42, index: 1,
                        title: "Mục đích hướng tới: Vる / N の ために、～",
                        structure: "V(辞書形 có chủ ý) + ために、～\nDanh từ + の + ために、～",
                        meaning: "Để... / Vì lợi ích của...",
                        explanation: "Khác với 「ように」 (Bài 36, đi với khả năng/tự động từ), 「ために」 dùng với động từ có CHỦ Ý hoặc danh từ (vì gia đình, vì tương lai, vì sức khỏe). Hai vế động từ phải cùng một chủ ngữ.",
                        exampleJp: "自分の みせを もつために、ちょきんしています。",
                        exampleReading: "Jibun no mise o motsu tame ni, chokin shite imasu.",
                        exampleVi: "Tôi đang tiết kiệm tiền để mở cửa hàng của riêng mình."
                    ),
                    GrammarPoint(
                        lessonNumber: 42, index: 2,
                        title: "Công dụng & Tiêu tốn: Vる のに / N に",
                        structure: "V(辞書形) + のに / Danh từ + に + つかいます / べんりです / かかります / ひつようです",
                        meaning: "Dùng cho việc... / Tiện lợi cho việc... / Mất bao nhiêu cho việc...",
                        explanation: "Dùng để giải thích công dụng, đánh giá mức độ tiện ích/cần thiết, hoặc thời gian/tiền bạc tiêu tốn cho một mục đích nào đó.",
                        exampleJp: "この アプリは にほんごを べんきょうするのに とても べんりです。",
                        exampleReading: "Kono apuri wa Nihongo o benkyou suru no ni totemo benri desu.",
                        exampleVi: "Ứng dụng này rất tiện lợi cho việc học tiếng Nhật."
                    ),
                    GrammarPoint(
                        lessonNumber: 42, index: 3,
                        title: "Nhấn mạnh ước lượng: Số lượng + は / Số lượng + も",
                        structure: "Lượng từ + は (tối thiểu / ít nhất cần khoảng...)\nLượng từ + も (những / tận... nhiều hơn dự kiến)",
                        meaning: "Ít nhất cũng khoảng... / Tận những... (nhiều bất ngờ)",
                        explanation: "「は」 sau số từ biểu thị mức tối thiểu ước lượng. 「も」 sau số từ biểu thị cảm xúc ngạc nhiên vì số lượng lớn hơn tưởng tượng.",
                        exampleJp: "東京で 家を たてるのに、5千万円は かかります。きのう 10時間も ねました。",
                        exampleReading: "Toukyou de ie o tateru no ni, gosenman-en wa kakarimasu. Kinou juu-jikan mo nemashita.",
                        exampleVi: "Để xây nhà ở Tokyo thì ít nhất cũng tốn 50 triệu yên. Hôm qua tôi đã ngủ tận 10 tiếng."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 42, index: 1, quizType: .particleFill,
                        promptJp: "この はさみは 花を きる [ ___ ] つかいます。",
                        promptVi: "Cái kéo này dùng để cắt hoa.",
                        correctAnswer: "のに",
                        options: ["のに", "ために", "ように", "ことで"],
                        explanation: "Giải thích công dụng của đồ vật với động từ 「つかいます」 dùng 「Vる + のに」.",
                        fullSentenceJp: "この はさみは 花を きるのに つかいます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 42, index: 2, quizType: .particleFill,
                        promptJp: "かぞく [ ___ ] ために、いっしょうけんめい はたらいています。",
                        promptVi: "Tôi đang làm việc chăm chỉ vì gia đình.",
                        correctAnswer: "の",
                        options: ["の", "な", "に", "を"],
                        explanation: "Danh từ (かぞく) đi với 「ために」 nối bằng trợ từ 「の」 -> 「かぞくの ために」.",
                        fullSentenceJp: "かぞくの ために、いっしょうけんめい はたらいています。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 42, index: 3, quizType: .sentenceMatch,
                        promptJp: "うちから かいしゃまで でんしゃで [ ___ ]",
                        promptVi: "Từ nhà đến công ty đi bằng tàu điện mất tận 2 tiếng đồng hồ.",
                        correctAnswer: "２時間も かかります。",
                        options: ["２時間も かかります。", "２時間しか かかりません。", "２時間 ために いきます。", "２時間に つかいます。"],
                        explanation: "Thời gian 2 tiếng được coi là nhiều/lâu nên nhấn mạnh bằng trợ từ 「も」 + 「かかります」.",
                        fullSentenceJp: "うちから かいしゃまで でんしゃで ２時間も かかります。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 43,
                title: "Trông có vẻ / Sắp xảy ra (～そうです) & Vて きます",
                summary: "Phán đoán qua thị giác sắp xảy ra (Vますそうです) hoặc tính chất bề ngoài (Aそうです, bổ nghĩa そうなN / そうにV), cùng mẫu đi rồi quay lại Vてきます.",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 43, index: 1,
                        title: "Sắp xảy ra / Trông có vẻ: V(ます) / A(bỏ い/な) + そうです",
                        structure: "V(bỏ ます) + そうです (sắp sửa: ふりそうです / おちそうです)\nAい(bỏ い) / Aな(bỏ な) + そうです (trông có vẻ: おいしそう)\n※ Đặc biệt: いい → よさそうです | ない → なさそうです",
                        meaning: "Có vẻ như sắp... / Nhìn trông có vẻ...",
                        explanation: "Diễn tả suy đoán trực quan qua những gì nhìn thấy trước mắt (nhìn mây đen thấy sắp mưa, nhìn món ăn thấy ngon). Không dùng cho những điều nhìn là biết chắc 100% hoặc với tính từ chỉ màu sắc/hình dáng đơn thuần.",
                        exampleJp: "いまにも あめが ふりそうです。この りんごは おいしそうですね。",
                        exampleReading: "Ima ni mo ame ga furisou desu. Kono ringo wa oishisou desu ne.",
                        exampleVi: "Trời trông như sắp mưa đến nơi rồi. Quả táo này nhìn có vẻ ngon nhỉ."
                    ),
                    GrammarPoint(
                        lessonNumber: 43, index: 2,
                        title: "Bổ nghĩa danh từ/động từ: ～そうな N & ～そうに V",
                        structure: "～そうな + Danh từ (một N trông có vẻ...)\n～そうに + Động từ (làm V với vẻ mặt/trạng thái...)",
                        meaning: "Danh từ trông có vẻ... / Làm V một cách có vẻ...",
                        explanation: "「～そう」 chia giống hệt tính từ đuôi な: đứng trước danh từ dùng 「～そうな N」, đứng trước động từ dùng 「～そうに V」.",
                        exampleJp: "子どもたちが たのしそうに あそんでいます。",
                        exampleReading: "Kodomotachi ga tanoshisou ni asonde imasu.",
                        exampleVi: "Lũ trẻ đang vui chơi trông rất hào hứng/vui vẻ."
                    ),
                    GrammarPoint(
                        lessonNumber: 43, index: 3,
                        title: "Đi làm gì đó rồi quay lại: Vて きます",
                        structure: "Đi đâu đó → Vて きます。",
                        meaning: "Đi làm V một lát rồi quay lại ngay",
                        explanation: "Diễn tả hành động rời khỏi vị trí hiện tại để đi làm một việc gì đó (như đi mua đồ, đi rửa tay, đi đón bạn) rồi sẽ quay trở về chỗ cũ.",
                        exampleJp: "ちょっと コンビニで おべんとうを かって きます。",
                        exampleReading: "Chotto konbini de obentou o katte kimasu.",
                        exampleVi: "Tôi chạy ra cửa hàng tiện lợi mua hộp cơm rồi quay lại ngay nhé."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 43, index: 1, quizType: .particleFill,
                        promptJp: "この にもつは とても [ ___ ] ですね。てつだいましょうか。",
                        promptVi: "Hành lý này trông nặng thế nhỉ. Để tôi giúp bạn một tay nhé.",
                        correctAnswer: "おもそう",
                        options: ["おもそう", "おもいそう", "おもしそう", "おもくそう"],
                        explanation: "Tính từ đuôi い 「おもい」 (nặng) bỏ 「い」 trước 「そうです」 -> 「おもそう」.",
                        fullSentenceJp: "この にもつは とても おもそうですね。てつだいましょうか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 43, index: 2, quizType: .particleFill,
                        promptJp: "かれは あたまが [ ___ ] ですね。",
                        promptVi: "Anh ấy trông có vẻ thông minh (đầu óc tốt) nhỉ.",
                        correctAnswer: "よさそう",
                        options: ["よさそう", "いそう", "いいそう", "よそう"],
                        explanation: "Trường hợp đặc biệt bắt buộc nhớ: tính từ 「いい」 (tốt) khi ghép với 「そうです」 biến thành 「よさそうです」.",
                        fullSentenceJp: "かれは あたまが よさそうですね。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 43, index: 3, quizType: .sentenceMatch,
                        promptJp: "すみません、ちょっと トイレへ [ ___ ]",
                        promptVi: "Xin lỗi, tôi đi vệ sinh một chút rồi quay lại ngay.",
                        correctAnswer: "いって きます。",
                        options: ["いって きます。", "いって おきます。", "いって しまいました。", "いきそうです。"],
                        explanation: "Rời chỗ đi rồi quay trở lại ngay dùng 「いって きます」.",
                        fullSentenceJp: "すみません、ちょっと トイレへ いって きます。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 44,
                title: "Quá mức (～すぎます)・Dễ/Khó (やすい/にくい)・Thay đổi/Chọn (にします)",
                summary: "Vượt quá mức độ (Vます/A すぎます), tính chất dễ hay khó làm (Vます やすい/にくい), biến đổi trạng thái có chủ ý (Aく/Aに/Nに します) và quyết định lựa chọn N にします.",
                groupTag: g7,
                points: [
                    GrammarPoint(
                        lessonNumber: 44, index: 1,
                        title: "Quá mức cho phép: V(ます) / A(bỏ い/な) + すぎます",
                        structure: "V(bỏ ます) / Aい(bỏ い) / Aな(bỏ な) + すぎます\n※ いい → よすぎます | ない → なさすぎます",
                        meaning: "Quá... (ăn quá nhiều, đắt quá, phức tạp quá)",
                        explanation: "Diễn đạt hành động hay tính chất vượt quá giới hạn bình thường (thường mang nghĩa tiêu cực/không tốt). Động từ 「すぎます」 thuộc Nhóm II.",
                        exampleJp: "きのう おさけを のみすぎました。この かばんは おもすぎます。",
                        exampleReading: "Kinou osake o nomisugimashita. Kono kaban wa omosugimasu.",
                        exampleVi: "Hôm qua tôi đã uống quá nhiều rượu. Cái túi này nặng quá."
                    ),
                    GrammarPoint(
                        lessonNumber: 44, index: 2,
                        title: "Dễ / Khó thao tác: V(bỏ ます) + やすいです / にくいです",
                        structure: "V(bỏ ます) + やすいです (dễ) / にくいです (khó)",
                        meaning: "Dễ làm V / Khó làm V",
                        explanation: "Chỉ tính chất khách quan của đồ vật hay hành động (dễ viết, khó đọc, dễ hiểu, dễ vỡ...). 「やすい / にくい」 biến đổi theo tính từ đuôi い.",
                        exampleJp: "この ペンは とても かきやすいです。かれの じは よみにくいです。",
                        exampleReading: "Kono pen wa totemo kakiyasui desu. Kare no ji wa yominikui desu.",
                        exampleVi: "Cây bút này rất dễ viết. Chữ của anh ấy khó đọc quá."
                    ),
                    GrammarPoint(
                        lessonNumber: 44, index: 3,
                        title: "Làm cho biến đổi (～く/に します) & Lựa chọn (N にします)",
                        structure: "Aい(bỏ い)く / Aな(bỏ な)に / Danh từ に + します (tác động chủ ý)\nN(đồ ăn/món) + にします (quyết định chọn)",
                        meaning: "Làm cho trở nên... / Quyết định chọn (món N)",
                        explanation: "Khác với 「～く/に なります」 (tự nhiên biến đổi), 「～く/に します」 dùng khi con người chủ động tác động để thay đổi mức độ/trạng thái (vặn to âm lượng, cắt ngắn tóc) hoặc chọn món trong thực đơn.",
                        exampleJp: "テレビの おとを おおきく しました。ひるごはんは カレーに します。",
                        exampleReading: "Terebi no oto o ookiku shimashita. Hirugohan wa karee ni shimasu.",
                        exampleVi: "Tôi đã vặn to tiếng tivi lên. Bữa trưa tôi chọn món cơm cà ri."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 44, index: 1, quizType: .particleFill,
                        promptJp: "この くつは あるき [ ___ ] ので、りょこうに ぴったりです。",
                        promptVi: "Đôi giày này rất dễ đi bộ nên rất hợp để đi du lịch.",
                        correctAnswer: "やすい",
                        options: ["やすい", "にくい", "すぎ", "そう"],
                        explanation: "Tính chất dễ thao tác ghép vào gốc ます: 「あるき(ます) + やすい」.",
                        fullSentenceJp: "この くつは あるきやすいので、りょこうに ぴったりです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 44, index: 2, quizType: .particleFill,
                        promptJp: "へやが きたないですから、きれいに [ ___ ]。",
                        promptVi: "Vì phòng bẩn quá nên hãy dọn cho sạch đi.",
                        correctAnswer: "してください",
                        options: ["してください", "なってください", "すぎてください", "してくださいました"],
                        explanation: "Tác động có chủ ý làm sạch căn phòng với tính từ な 「きれい」 -> 「きれいに してください」.",
                        fullSentenceJp: "へやが きたないですから、きれいに してください。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 44, index: 3, quizType: .sentenceMatch,
                        promptJp: "おなかが いたいです。ひるごはんを [ ___ ]",
                        promptVi: "Tôi bị đau bụng rồi. Chắc là tôi đã ăn quá nhiều vào bữa trưa mất rồi.",
                        correctAnswer: "たべすぎて しまいました。",
                        options: ["たべすぎて しまいました。", "たべやすかったです。", "たべにくかったです。", "たべそうです。"],
                        explanation: "Nguyên nhân đau bụng do hành động vượt quá mức là ăn quá nhiều -> 「たべすぎて しまいました」.",
                        fullSentenceJp: "ひるごはんを たべすぎて しまいました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 45,
                title: "Trong trường hợp (～ばあいは) & Mặc dù thế mà (～のに)",
                summary: "Giả định tình huống cụ thể (～ばあいは) và sự nghịch lý mang sắc thái bất ngờ, thất vọng hoặc trách móc (～のに).",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 45, index: 1,
                        title: "Trong trường hợp: V(thường) / A / Nの + ばあいは、～",
                        structure: "V(辞書形 / た / ない) + ばあいは、～\nAい / Aな + な / N + の + ばあいは、～",
                        meaning: "Trong trường hợp mà ~ thì (xử lý như thế nào)...",
                        explanation: "Dùng để nêu cách ứng phó hoặc quy trình xử lý cho một tình huống giả định cụ thể ít khi mong muốn (hỏng máy, động đất, đi muộn, nghỉ họp). Không dùng 「だった ばあい」; quá khứ nói về nếu đã xảy ra dùng 「Vた ばあい」.",
                        exampleJp: "かじや じしんの ばあいは、エレベーターを つかわないで ください。",
                        exampleReading: "Kaji ya jishin no baai wa, erebeetaa o tsukawanaide kudasai.",
                        exampleVi: "Trong trường hợp xảy ra hỏa hoạn hay động đất, xin đừng sử dụng thang máy."
                    ),
                    GrammarPoint(
                        lessonNumber: 45, index: 2,
                        title: "Mặc dù ~ thế mà lại...: ～のに",
                        structure: "V / Aい (thường) + のに\nAな / Danh từ + な + のに",
                        meaning: "Mặc dù ~ thế mà lại... (bất ngờ, thất vọng, bất mãn)",
                        explanation: "Nối 2 mệnh đề trái ngược hoàn toàn với suy đoán thông thường, mang cảm xúc ngạc nhiên, thất vọng hoặc trách móc của người nói. Khác với 「～が / ～ても」: vế sau của 「～のに」 KHÔNG dùng câu ý chí, rủ rê hay mệnh lệnh; trước 「のに」, Aな và Danh từ dùng 「な」.",
                        exampleJp: "いっしょうけんめい べんきょうしたのに、テストに ごうかくできませんでした。",
                        exampleReading: "Isshoukenmei benkyou shita noni, tesuto ni goukaku dekimasen deshita.",
                        exampleVi: "Vậy mà... dù tôi đã học rất chăm chỉ, thế mà vẫn không đỗ kỳ thi."
                    ),
                    GrammarPoint(
                        lessonNumber: 45, index: 3,
                        title: "Phân biệt ～のに với ～ても và ～が",
                        structure: "～のに: sự việc ĐÃ/ĐANG có thật gây thất vọng (trước đó dùng な với N/Aな)\n～ても: giả định 'cho dù ~ đi nữa' (sau ても dùng được rủ rê/mệnh lệnh)",
                        meaning: "So sánh sắc thái biểu cảm giữa のに (thực tế trái ngược) và ても (giả thiết)",
                        explanation: "Khi mời mọc hay khuyên bảo (Cho dù mưa cũng cứ đi đi / Dù đắt cũng mua nhé), không được dùng 「～のに」 mà phải dùng 「～ても」 hoặc 「～が / ～けれども」.",
                        exampleJp: "きょうは 日曜日なのに、かいしゃへ いかなければなりません。",
                        exampleReading: "Kyou wa nichiyoubi na noni, kaisha e ikanakereba narimasen.",
                        exampleVi: "Hôm nay rõ ràng là Chủ Nhật thế mà tôi vẫn phải đi làm ở công ty."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 45, index: 1, quizType: .particleFill,
                        promptJp: "かいぎに おくれる [ ___ ] は、かならず れんらくして ください。",
                        promptVi: "Trong trường hợp bị trễ cuộc họp thì nhất định hãy liên lạc báo trước nhé.",
                        correctAnswer: "ばあい",
                        options: ["ばあい", "のに", "ところ", "ため"],
                        explanation: "Nêu quy định ứng phó cho tình huống cụ thể (bị trễ cuộc họp) dùng 「Vる ばあいは」.",
                        fullSentenceJp: "かいぎに おくれる ばあいは、かならず れんらくして ください。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 45, index: 2, quizType: .particleFill,
                        promptJp: "やくそくを した [ ___ ]、かれは きませんでした。",
                        promptVi: "Mặc dù đã hẹn với nhau rồi thế mà anh ấy lại không đến.",
                        correctAnswer: "のに",
                        options: ["のに", "から", "ばあいは", "ので"],
                        explanation: "Thể hiện sự trách móc, thất vọng vì thực tế trái ngược lời hứa -> dùng 「～のに」.",
                        fullSentenceJp: "やくそくを したのに、かれは きませんでした。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 45, index: 3, quizType: .sentenceMatch,
                        promptJp: "あさ はやく おきたのに、[ ___ ]",
                        promptVi: "Rõ ràng đã dậy từ sáng sớm thế mà vẫn bị lỡ chuyến tàu điện.",
                        correctAnswer: "でんしゃに おくれて しまいました。",
                        options: ["でんしゃに おくれて しまいました。", "かいしゃへ はやく つきました。", "あさごはんを たべましょう。", "でんしゃに のって ください。"],
                        explanation: "「のに」 đòi hỏi vế sau là một kết quả thực tế trái ngược (không phải rủ rê ましょう hay nhờ cậy ください).",
                        fullSentenceJp: "あさ はやく おきたのに、でんしゃに おくれて しまいました。"
                    )
                ]
            )
        ]
    }

    // MARK: - Bài 46 - 50 (N4)
    private static func buildLessons46To50() -> [GrammarLesson] {
        let g8 = groupTags[7]
        return [
            GrammarLesson(
                lessonNumber: 46,
                title: "Thời điểm vừa mới (ところです・ばかりです) & Suy đoán (はずです)",
                summary: "Phân biệt sắc thái thời gian với Vる/Vている/Vた ところです, Vた ばかりです (cảm giác vừa mới) và khẳng định chắc chắn ～はずです.",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 46, index: 1,
                        title: "Khoảnh khắc hành động: Vる / Vている / Vた ところです",
                        structure: "Vる ところです (sắp sửa làm ngay bây giờ)\nVている ところです (đúng lúc đang làm)\nVた ところです (vừa mới làm xong tức thì)",
                        meaning: "Sắp sửa... / Đang ngay lúc... / Vừa mới xong tức thì...",
                        explanation: "Nhấn mạnh ĐIỂM THỜI GIAN vật lý chính xác của hành động (thường đi kèm với 「いまから / いま / たったいま」).",
                        exampleJp: "いま ごはんを たべている ところです。たったいま うちへ かえった ところです。",
                        exampleReading: "Ima gohan o tabete iru tokoro desu. Tattaima uchi e kaetta tokoro desu.",
                        exampleVi: "Bây giờ tôi đúng lúc đang ăn cơm. Tôi vừa mới về tới nhà tức thì."
                    ),
                    GrammarPoint(
                        lessonNumber: 46, index: 2,
                        title: "Cảm giác vừa mới: Vた ばかりです",
                        structure: "Vた + ばかりです / ばかりの N",
                        meaning: "Vừa mới... (theo cảm nhận của người nói)",
                        explanation: "Khác với 「Vた ところです」 (chỉ vừa xảy ra vài giây/phút trước), 「Vた ばかりです」 dựa vào CẢM NHẬN CHỦ QUAN nên có thể dùng cho việc xảy ra vài tuần, vài tháng trước (Ví dụ: mới vào công ty tháng trước, mới đến Nhật năm ngoái).",
                        exampleJp: "せんげつ この かいしゃに はいった ばかりです。",
                        exampleReading: "Sengetsu kono kaisha ni haitta bakari desu.",
                        exampleVi: "Tôi mới vừa vào công ty này hồi tháng trước thôi."
                    ),
                    GrammarPoint(
                        lessonNumber: 46, index: 3,
                        title: "Phán đoán chắc chắn có cơ sở: ～はずです",
                        structure: "V / Aい (thường) + はずです\nAな + な + はずです | Danh từ + の + はずです",
                        meaning: "Chắc chắn là... / Đáng lẽ ra phải là... (suy luận logic)",
                        explanation: "Dùng khi người nói có căn cứ khách quan rõ ràng để tin chắc 90% điều đó đúng hoặc phải xảy ra (ví dụ: có lịch trình, đã ôn kỹ, đã gửi từ 3 ngày trước). Phủ định: 「～ない はずです / ～はずが ありません」.",
                        exampleJp: "田中さんは いま じゅぎょうちゅうですから、うちに いない はずです。",
                        exampleReading: "Tanaka-san wa ima jugyouchuu desu kara, uchi ni inai hazu desu.",
                        exampleVi: "Vì giờ anh Tanaka đang trong tiết học nên chắc chắn không có ở nhà đâu."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 46, index: 1, quizType: .particleFill,
                        promptJp: "A：もう でかけましたか。 B：いいえ、いまから でかける [ ___ ]。",
                        promptVi: "A: Anh đi ra ngoài rồi à? B: Chưa, tôi sắp sửa đi ngay bây giờ đây.",
                        correctAnswer: "ところです",
                        options: ["ところです", "ばかりです", "はずです", "ようです"],
                        explanation: "Trạng từ 「いまから」 kết hợp với hành động chuẩn bị bắt đầu ngay bây giờ dùng 「Vる ところです」.",
                        fullSentenceJp: "いいえ、いまから でかける ところです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 46, index: 2, quizType: .particleFill,
                        promptJp: "この くるまは 先月 かった [ ___ ] なので、とても きれいです。",
                        promptVi: "Chiếc xe này vừa mới mua tháng trước nên vẫn rất mới và đẹp.",
                        correctAnswer: "ばかり",
                        options: ["ばかり", "ところ", "はず", "まま"],
                        explanation: "Sự việc đã diễn ra cách đây cả tháng (先月) nhưng người nói thấy vẫn còn mới mẻ -> chỉ dùng được 「Vた ばかり」 (không dùng ところ).",
                        fullSentenceJp: "この くるまは 先月 かった ばかりなので、とても きれいです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 46, index: 3, quizType: .sentenceMatch,
                        promptJp: "かれは 毎日 日本語を べんきょうして いますから、[ ___ ]",
                        promptVi: "Vì anh ấy ngày nào cũng học tiếng Nhật nên chắc chắn là nói rất giỏi đấy.",
                        correctAnswer: "じょうずに 話せる はずです。",
                        options: ["じょうずに 話せる はずです。", "話した ところです。", "話せない ばかりです。", "話さなければなりません。"],
                        explanation: "Suy luận có căn cứ logic từ việc học mỗi ngày dẫn đến kết luận chắc chắn 「～はずです」.",
                        fullSentenceJp: "かれは 毎日 日本語を べんきょうして いますから、じょうずに 話せる はずです。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 47,
                title: "Truyền đạt (そうです)・Hình như (ようです)・Giác quan (がします)",
                summary: "Phân biệt truyền đạt thông tin (普通形+そうです kèm ～によると), suy đoán qua giác quan/tình huống (～ようです) và cảm nhận こえ/おと/におい/あじ がします.",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 47, index: 1,
                        title: "Nghe nói (Truyền đạt): Thể thông thường + そうです",
                        structure: "(～に よると) + V / A / N (thể thông thường + だ đối với Aな/N) + そうです。",
                        meaning: "Nghe nói là... / Theo như (nguồn tin) thì...",
                        explanation: "Khác với Bài 43 (bỏ ます/い/な = 'trông có vẻ'), 「そうです」 của Bài 47 đứng sau THỂ THÔNG THƯỜNG (phải giữ nguyên だ với Danh từ và Aな) để tường thuật lại thông tin nghe được từ TV, báo chí hay người khác (thường mở đầu bằng 「～に よると」).",
                        exampleJp: "てんきよほうに よると、あしたは さむくなるそうです。この レストランは ゆうめいだそうです。",
                        exampleReading: "Tenkiyohou ni yoru to, ashita wa samuku naru sou desu. Kono resutoran wa yuumei da sou desu.",
                        exampleVi: "Theo dự báo thời tiết thì nghe nói ngày mai trời sẽ trở lạnh. Nghe nói nhà hàng này nổi tiếng lắm."
                    ),
                    GrammarPoint(
                        lessonNumber: 47, index: 2,
                        title: "Hình như là: V/A(thường) + ようです (N のようです)",
                        structure: "V / Aい (thường) + ようです\nAな + な + ようです | Danh từ + の + ようです",
                        meaning: "Có vẻ như / Hình như là... (suy đoán chủ quan qua dấu hiệu)",
                        explanation: "Suy đoán của bản thân người nói dựa trên các bằng chứng nghe thấy, nhìn thấy hay cảm nhận (thường đi với 「どうも」 = không hiểu sao nhưng hình như...). Chia giống danh từ/Aな.",
                        exampleJp: "げんかんに くつが ありますから、だれか いるようです。",
                        exampleReading: "Genkan ni kutsu ga arimasu kara, dareka iru you desu.",
                        exampleVi: "Vì thấy có giày ở cửa ra vào nên hình như có ai đó đang ở nhà."
                    ),
                    GrammarPoint(
                        lessonNumber: 47, index: 3,
                        title: "Cảm nhận giác quan: こえ / おと / におい / あじ が します",
                        structure: "N(âm thanh / giọng nói / mùi / vị) + が します。",
                        meaning: "Nghe thấy tiếng / Ngửi thấy mùi / Thấy có vị...",
                        explanation: "Diễn tả cảm giác đột ngột cảm nhận được qua thính giác, khứu giác hay vị giác mà không cần chủ đích tìm kiếm.",
                        exampleJp: "台所から いい においが しますね。そとで へんな おとが しました。",
                        exampleReading: "Daidokoro kara ii nioi ga shimasu ne. Soto de hen na oto ga shimashita.",
                        exampleVi: "Từ nhà bếp bay ra mùi thơm ngon quá nhỉ. Ở bên ngoài vừa phát ra tiếng động lạ."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 47, index: 1, quizType: .particleFill,
                        promptJp: "しんぶんに よると、らいしゅうから ふくが [ ___ ] そうです。",
                        promptVi: "Theo tờ báo thì nghe nói từ tuần sau giá quần áo sẽ tăng lên.",
                        correctAnswer: "たかくなる",
                        options: ["たかくなる", "たかいな", "たかく", "たか"],
                        explanation: "「～そうです」 truyền đạt đứng sau động từ/tính từ ở THỂ THÔNG THƯỜNG đầy đủ -> 「たかくなる そうです」.",
                        fullSentenceJp: "しんぶんに よると、らいしゅうから ふくが たかくなるそうです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 47, index: 2, quizType: .particleFill,
                        promptJp: "へやの でんきが きえていますから、だれも [ ___ ] ようです。",
                        promptVi: "Vì đèn trong phòng đang tắt nên hình như không có ai ở đó.",
                        correctAnswer: "いない",
                        options: ["いない", "いません", "いなくて", "いないな"],
                        explanation: "Trước 「ようです」 động từ chia về thể thông thường -> 「いない ようです」.",
                        fullSentenceJp: "へやの でんきが きえていますから、だれも いないようです。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 47, index: 3, quizType: .sentenceMatch,
                        promptJp: "この コーヒーは なんだか へんな [ ___ ]",
                        promptVi: "Cốc cà phê này không hiểu sao có mùi vị hơi kỳ lạ.",
                        correctAnswer: "においが しますね。",
                        options: ["においが しますね。", "においを みますね。", "においに なりますね。", "においだ そうです。"],
                        explanation: "Cảm nhận mùi/vị bằng giác quan dùng cấu trúc cố định 「におい / あじ が します」.",
                        fullSentenceJp: "この コーヒーは なんだか へんな においが しますね。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 48,
                title: "Thể Sai khiến (Vさせます) & Xin phép (させていただけませんか)",
                summary: "Cách chia thể sai khiến (nhóm I: い→あせる, nhóm II: ます→させる, くる→こさせる, する→させる), trợ từ を/に với tự động từ vs tha động từ và xin phép Vさせていただけませんか.",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 48, index: 1,
                        title: "Cách chia Thể Sai khiến & Tự động từ (Người を Vさせます)",
                        structure: "I: đuôi い → あ + せます (いかせます・およがせます)\nII: bỏ ます + させます (たべさせます)\nIII: きます→こさせます / します→させます\nTự động từ: Người trên は Người dưới を Vさせます",
                        meaning: "Bắt / Cho phép ai đó thực hiện hành động (tự động từ)",
                        explanation: "Dùng khi cấp trên/cha mẹ sai bảo hoặc cho phép cấp dưới/con cái làm gì. Nếu động từ là TỰ ĐỘNG TỪ (không có tân ngữ を riêng), người thực hiện hành động đi với trợ từ 「を」.",
                        exampleJp: "むすめを アメリカへ りゅうがくさせます。子どもを はやく ねさせます。",
                        exampleReading: "Musume o Amerika e ryuugaku sasemasu. Kodomo o hayaku nesasemasu.",
                        exampleVi: "Tôi cho con gái đi du học Mỹ. Tôi bắt lũ trẻ đi ngủ sớm."
                    ),
                    GrammarPoint(
                        lessonNumber: 48, index: 2,
                        title: "Sai khiến với Tha động từ: Người dưới に V(tha) をさせます",
                        structure: "Người trên は Người dưới に + N を + Vさせます。",
                        meaning: "Bắt / Cho phép ai làm việc gì (đối với N)",
                        explanation: "Khi động từ đã có sẵn tân ngữ đi với 「を」 (tha động từ như 買います, 手伝います, 書きます), để tránh hai trợ từ 「を」 trong một mệnh đề, người thực hiện hành động phải dùng trợ từ 「に」.",
                        exampleJp: "わたしは おとうとに かばんを もたせました。",
                        exampleReading: "Watashi wa otouto ni kaban o motasemashita.",
                        exampleVi: "Tôi đã bảo em trai cầm hộ cái cặp."
                    ),
                    GrammarPoint(
                        lessonNumber: 48, index: 3,
                        title: "Xin phép lịch sự nhất: Vさせて いただけませんか",
                        structure: "V(sai khiến bỏ ます) + て + いただけませんか。",
                        meaning: "Anh/chị có thể cho phép tôi làm V được không ạ?",
                        explanation: "Rất phổ biến khi xin phép cấp trên, thầy cô nghỉ phép, về sớm, phát biểu hay sử dụng đồ gì đó (lịch sự và khiêm nhường hơn 「～ても いいですか」 rất nhiều).",
                        exampleJp: "あたまが いたいので、きょうは はやく かえらせて いただけませんか。",
                        exampleReading: "Atama ga itai node, kyou wa hayaku kaerasete itadakemasen ka.",
                        exampleVi: "Vì bị đau đầu nên hôm nay ngài có thể cho phép tôi về sớm được không ạ?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 48, index: 1, quizType: .particleFill,
                        promptJp: "先生は 学生 [ ___ ] じゆうに いけんを 言わせました。",
                        promptVi: "Thầy giáo đã cho phép học sinh tự do nêu ý kiến.",
                        correctAnswer: "に",
                        options: ["に", "を", "が", "で"],
                        explanation: "Vì trong câu đã có tân ngữ 「いけんを」 nên chủ thể thực hiện hành động (学生) phải đi với trợ từ 「に」.",
                        fullSentenceJp: "先生は 学生に じゆうに いけんを 言わせました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 48, index: 2, quizType: .particleFill,
                        promptJp: "かぜを ひいたので、あした 会社を [ ___ ] いただけませんか。",
                        promptVi: "Vì bị cảm nên ngày mai anh cho phép em nghỉ làm được không ạ?",
                        correctAnswer: "やすませて",
                        options: ["やすませて", "やすまれて", "やすんで", "やすもう"],
                        explanation: "Xin phép làm gì lịch sự: 「V(sai khiến) て + いただけませんか」. 「やすみます」 (Nhóm I) -> sai khiến là 「やすませます」 -> 「やすませて」.",
                        fullSentenceJp: "あした 会社を やすませて いただけませんか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 48, index: 3, quizType: .sentenceMatch,
                        promptJp: "おとうとが かいものを いやがりましたが、わたしが [ ___ ]",
                        promptVi: "Em trai không chịu đi mua sắm nhưng tôi vẫn bắt nó đi.",
                        correctAnswer: "無理に いかせました。",
                        options: ["無理に いかせました。", "いって もらいました。", "いかれました。", "いきたいと おもいます。"],
                        explanation: "Bắt buộc người khác làm điều gì dùng thể sai khiến: 「いかせました」 (bắt đi).",
                        fullSentenceJp: "わたしが おとうとを 無理に いかせました。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 49,
                title: "Kính ngữ & Tôn kính ngữ (そんけいご)",
                summary: "Nâng cao vị thế hành động của người trên: quy tắc うち/そと, thể bị động kính ngữ, おVになります, động từ đặc biệt (いらっしゃる・おっしゃる・なさる) và おVください.",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 49, index: 1,
                        title: "Tôn kính ngữ: お V(bỏ ます) に なります & Dạng Bị động",
                        structure: "① お + V(bỏ ます) + に なります (Nhóm I & II, trừ động từ 1 âm tiết)\n② Động từ chia dạng BỊ ĐỘNG (Vられます) — dùng được cho mọi nhóm\n※ Dùng cho hành động của người trên/khách hàng (không dùng cho người trong nhà mình khi nói với người ngoài - うち/そと).",
                        meaning: "Ngài/Quý khách (làm hành động V một cách tôn kính)",
                        explanation: "Cả 「おVになります」 và dạng bị động đều dùng để tôn kính hành động của người nghe hoặc người được nhắc tới ở bề trên, trong đó 「おVになります」 trang trọng hơn một bậc.",
                        exampleJp: "ぶちょうは もう おかえりに なりましたか。しゃちょうは きのう 大阪へ いかれました。",
                        exampleReading: "Buchou wa mou okaeri ni narimashita ka. Shachou wa kinou Oosaka e ikaremashita.",
                        exampleVi: "Trưởng phòng đã về chưa ạ? Giám đốc hôm qua đã đi công tác Osaka rồi ạ."
                    ),
                    GrammarPoint(
                        lessonNumber: 49, index: 2,
                        title: "Động từ Tôn kính ngữ đặc biệt (Không chia theo quy tắc 1)",
                        structure: "いきます/きます/います → いらっしゃいます\nたべます/のみます → めしあがります | いいます → おっしゃいます\nみます → ごらんになります | します → なさいます | しっています → ごぞんじです",
                        meaning: "Bảng chuyển đổi các động từ bất quy tắc sang Tôn kính ngữ",
                        explanation: "Những động từ đã có dạng đặc biệt thì KHÔNG dùng dạng 「おVになります」 nữa (Ví dụ không nói おみに なります mà phải nói ごらんに なります). 「いらっしゃいます」 dùng chung cho cả Đi - Đến - Ở.",
                        exampleJp: "せんせいは いま 研究室に いらっしゃいます。どちらへ いらっしゃいますか。",
                        exampleReading: "Sensei wa ima kenkyuushitsu ni irasshaimasu. Dochira e irasshaimasu ka.",
                        exampleVi: "Thầy giáo hiện đang ở trong phòng nghiên cứu ạ. Ngài định đi đâu vậy ạ?"
                    ),
                    GrammarPoint(
                        lessonNumber: 49, index: 3,
                        title: "Mời/Yêu cầu lịch sự: お V(bỏ ます) ください / ご N ください",
                        structure: "お + V(bỏ ます) + ください\nご + Danh động từ Nhóm III + ください",
                        meaning: "Xin quý khách / anh chị vui lòng làm...",
                        explanation: "Dùng rất nhiều trong thông báo sân bay, nhà hàng, hướng dẫn khách hàng hoặc mời người trên dùng trà/ngồi ghế một cách lịch sự trang nhã.",
                        exampleJp: "どうぞ こちらへ おかけ ください。おなまえを ごきにゅう ください。",
                        exampleReading: "Douzo kochira e okake kudasai. Onamae o gokinyuu kudasai.",
                        exampleVi: "Xin mời ngài ngồi vào đây ạ. Xin vui lòng điền tên của quý khách."
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 49, index: 1, quizType: .particleFill,
                        promptJp: "しゃちょうは なにを [ ___ ] か。",
                        promptVi: "Giám đốc muốn dùng/ăn uống món gì ạ?",
                        correctAnswer: "めしあがります",
                        options: ["めしあがります", "いただきます", "まいります", "もうします"],
                        explanation: "Hỏi hành động ăn/uống của giám đốc (tôn kính ngữ của たべます/のみます) phải dùng 「めしあがります」. (いただきます là khiêm tốn ngữ của mình).",
                        fullSentenceJp: "しゃちょうは なにを めしあがりますか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 49, index: 2, quizType: .particleFill,
                        promptJp: "あしたの かいぎは なんじに [ ___ ] か。",
                        promptVi: "Cuộc họp ngày mai thì ngài định bắt đầu lúc mấy giờ ạ?",
                        correctAnswer: "なさいます",
                        options: ["なさいます", "いたします", "まいります", "ごぞんじです"],
                        explanation: "Tôn kính ngữ của 「します」 là 「なさいます」 (còn いたします là khiêm tốn ngữ).",
                        fullSentenceJp: "あしたの かいぎは なんじに なさいますか。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 49, index: 3, quizType: .sentenceMatch,
                        promptJp: "おきゃくさま、どうぞ こっちへ [ ___ ]",
                        promptVi: "Thưa quý khách, xin mời quý khách vui lòng xem qua chỗ này ạ.",
                        correctAnswer: "ごらんに なって ください。",
                        options: ["ごらんに なって ください。", "はいけんして ください。", "みて あげます。", "おみに なって ください。"],
                        explanation: "Tôn kính ngữ đặc biệt của 「みます」 (xem) là 「ごらんに なります」 -> mời xem dùng 「ごらんに なって ください」.",
                        fullSentenceJp: "おきゃくさま、どうぞ こっちへ ごらんに なって ください。"
                    )
                ]
            ),
            GrammarLesson(
                lessonNumber: 50,
                title: "Khiêm tốn ngữ (けんじょうご) & Lịch sự ngữ (ていねいご)",
                summary: "Hạ mình tỏ lòng tôn trọng với người nghe/người nhận hành động: おVします, ごNします, bảng động từ đặc biệt (まいります・うかがいます・もうします・いたします・おめにかかります) và ございます.",
                groupTag: g8,
                points: [
                    GrammarPoint(
                        lessonNumber: 50, index: 1,
                        title: "Khiêm tốn ngữ: お V(bỏ ます) します & ご N(nhóm III) します",
                        structure: "お + V(bỏ ます) + します (hành động của mình hướng tới người trên)\nご + Danh động từ(nhóm III) + します (例：ごあんないします・ごせつめいします)",
                        meaning: "Tôi xin phép được làm V (giúp ngài / hướng về ngài)",
                        explanation: "Chỉ dùng khi hành động của bản thân (hoặc người cùng nhóm/công ty mình) hướng tới và có liên quan trực tiếp đến người trên/khách hàng (xách đồ giúp, tiễn khách, giải thích cho khách).",
                        exampleJp: "おにもつを おもち しましょうか。きょうの よていを ごせつめい します。",
                        exampleReading: "Onimotsu o omochi shimashou ka. Kyou no yotei o gosetsumei shimasu.",
                        exampleVi: "Để tôi xách hành lý giúp ngài nhé ạ? Tôi xin phép giải thích lịch trình hôm nay ạ."
                    ),
                    GrammarPoint(
                        lessonNumber: 50, index: 2,
                        title: "Động từ Khiêm tốn ngữ đặc biệt",
                        structure: "いきます/きます → まいります/うかがいます | います → おります\nたべます/のみます/もらいます → いただきます | みます → はいけんします\nいいます → もうします | します → いたします\nしっています → ぞんじています | しりません → ぞんじません\nあいます → おめに かかります",
                        meaning: "Bảng các động từ bất quy tắc ở thể Khiêm nhường",
                        explanation: "Những động từ đã có dạng đặc biệt thì dùng thẳng thay vì công thức おVします. Đặc biệt: khi gặp gỡ cấp trên dùng 「おめに かかります」; tự giới thiệu tên mình là 「～と もうします」.",
                        exampleJp: "ベトナムから まいりました アンと もうします。おあいできて / おめにかかれて うれしいです。",
                        exampleReading: "Betonamu kara mairimashita An to moushimasu. Ome ni kakarete ureshii desu.",
                        exampleVi: "Tôi tên là An, đến từ Việt Nam. Rất hân hạnh được diện kiến ngài."
                    ),
                    GrammarPoint(
                        lessonNumber: 50, index: 3,
                        title: "Lịch sự ngữ (ていねいご): ございます & でございます",
                        structure: "あります → ございます\nです → でございます | いいですか → よろしいでしょうか",
                        meaning: "Dạng nói trang trọng lịch sự dùng chung (chỉ sự tồn tại / định nghĩa)",
                        explanation: "「ございます」 là dạng lịch sự trang trọng của 「あります」 (cùng cụm cố định おはよう ございます, ありがとう ございます). 「でございます」 trang trọng hơn 「です」, dùng rất nhiều trong dịch vụ khách hàng, lễ tân và phỏng vấn.",
                        exampleJp: "おてあらいは こちらで ございます。おつりは ございませんか。",
                        exampleReading: "Otearai wa kochira de gozaimasu. Otsuri wa gozaimasen ka.",
                        exampleVi: "Nhà vệ sinh ở phía bên này ạ. Quý khách có cần tiền thối không ạ?"
                    )
                ],
                quizzes: [
                    GrammarQuizQuestion(
                        lessonNumber: 50, index: 1, quizType: .particleFill,
                        promptJp: "あした 10時に しゃちょうの おたくへ [ ___ ]。",
                        promptVi: "Ngày mai lúc 10 giờ tôi xin phép đến thăm nhà ngài giám đốc.",
                        correctAnswer: "うかがいます",
                        options: ["うかがいます", "いらっしゃいます", "なさいます", "おめにかかります"],
                        explanation: "Đến thăm nhà/công ty của người bề trên dùng khiêm tốn ngữ 「うかがいます」 (còn いらっしゃいます là tôn kính ngữ của người trên đi/đến).",
                        fullSentenceJp: "あした 10時に しゃちょうの おたくへ うかがいます。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 50, index: 2, quizType: .particleFill,
                        promptJp: "せんせいの かかれた ごほんを [ ___ ]。",
                        promptVi: "Tôi đã được đọc/xem quyển sách do thầy viết ạ.",
                        correctAnswer: "はいけんしました",
                        options: ["はいけんしました", "ごらんになりました", "もうしました", "おっしゃいました"],
                        explanation: "Khiêm tốn ngữ của 「みます / よみます」 khi bản thân xem đồ vật/sách của người bề trên là 「はいけんします / はいけんしました」.",
                        fullSentenceJp: "せんせいの かかれた ごほんを はいけんしました。"
                    ),
                    GrammarQuizQuestion(
                        lessonNumber: 50, index: 3, quizType: .sentenceMatch,
                        promptJp: "えきまで くるまで [ ___ ]",
                        promptVi: "Để tôi xin phép lái xe đưa ngài ra tận nhà ga ạ.",
                        correctAnswer: "おおくり いたします。",
                        options: ["おおくり いたします。", "おおくられ になります。", "おくって くださいます。", "おくって めしあがります。"],
                        explanation: "Hành động của bản thân đưa khách về dùng khiêm nhường 「お + V(bỏ ます) + します / いたします」 -> 「おおくり いたします」.",
                        fullSentenceJp: "えきまで くるまで おおくり いたします。"
                    )
                ]
            )
        ]
    }
}
