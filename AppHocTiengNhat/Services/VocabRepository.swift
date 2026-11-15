//
//  VocabRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class VocabRepository {
    public static let shared = VocabRepository()

    public static let partTags: [String] = [
        "Phần 1: Bài 1-10 (Sơ cấp I - Đầu)",
        "Phần 2: Bài 11-20 (Sơ cấp I - Giữa)",
        "Phần 3: Bài 21-30 (Giao thoa N5 - N4)",
        "Phần 4: Bài 31-40 (Sơ cấp II - Giữa)",
        "Phần 5: Bài 41-50 (Sơ cấp II - Cuối & Kính ngữ)"
    ]

    public let topics: [VocabTopic] = [
        VocabTopic(id: "greeting", title: "Chào hỏi & Giao tiếp", iconName: "bubble.left.and.bubble.right.fill", detail: "Câu cửa miệng và chào hỏi hàng ngày"),
        VocabTopic(id: "family", title: "Gia đình & Bản thân", iconName: "person.2.fill", detail: "Thành viên gia đình và xưng hô"),
        VocabTopic(id: "time", title: "Thời gian & Lịch trình", iconName: "clock.fill", detail: "Giờ giấc, các buổi, ngày tháng"),
        VocabTopic(id: "food", title: "Ẩm thực & Nhà hàng", iconName: "fork.knife", detail: "Món ăn, đồ uống, hương vị"),
        VocabTopic(id: "travel", title: "Đi lại & Phương tiện", iconName: "tram.fill", detail: "Tàu điện, xe bus, hỏi đường")
    ]

    public let topicWords: [VocabWord] = [
        // MARK: - Chào hỏi & Giao tiếp
        VocabWord(kanji: nil, kana: "おはようございます", romaji: "ohayou gozaimasu", meaningVi: "Chào buổi sáng (lịch sự)", topicId: "greeting", exampleJp: "先生、おはようございます。", exampleVi: "Chào buổi sáng thầy giáo ạ."),
        VocabWord(kanji: nil, kana: "こんにちは", romaji: "konnichiwa", meaningVi: "Xin chào (buổi trưa/chiều)", topicId: "greeting", exampleJp: "みなさん、こんにちは。", exampleVi: "Xin chào mọi người."),
        VocabWord(kanji: nil, kana: "こんばんは", romaji: "konbanwa", meaningVi: "Chào buổi tối", topicId: "greeting", exampleJp: "こんばんは、お元気ですか。", exampleVi: "Chào buổi tối, bạn khỏe không?"),
        VocabWord(kanji: nil, kana: "ありがとうございます", romaji: "arigatou gozaimasu", meaningVi: "Cảm ơn bạn rất nhiều", topicId: "greeting", exampleJp: "手伝ってくれて、ありがとうございます。", exampleVi: "Cảm ơn bạn đã giúp đỡ tôi."),
        VocabWord(kanji: nil, kana: "すみません", romaji: "sumimasen", meaningVi: "Xin lỗi / Cho tôi hỏi...", topicId: "greeting", exampleJp: "すみません、駅はどこですか。", exampleVi: "Xin lỗi, nhà ga ở đâu ạ?"),
        VocabWord(kanji: nil, kana: "さようなら", romaji: "sayounara", meaningVi: "Tạm biệt", topicId: "greeting", exampleJp: "また明日、さようなら。", exampleVi: "Hẹn gặp lại ngày mai, tạm biệt."),

        // MARK: - Gia đình & Bản thân
        VocabWord(kanji: "家族", kana: "かぞく", romaji: "kazoku", meaningVi: "Gia đình", topicId: "family", exampleJp: "家族は四人です。", exampleVi: "Gia đình tôi có 4 người."),
        VocabWord(kanji: "父", kana: "ちち", romaji: "chichi", meaningVi: "Bố (của mình)", topicId: "family", exampleJp: "父は会社員です。", exampleVi: "Bố tôi là nhân viên công ty."),
        VocabWord(kanji: "母", kana: "はは", romaji: "haha", meaningVi: "Mẹ (của mình)", topicId: "family", exampleJp: "母の料理はおいしいです。", exampleVi: "Món mẹ nấu rất ngon."),
        VocabWord(kanji: "兄", kana: "あに", romaji: "ani", meaningVi: "Anh trai (của mình)", topicId: "family", exampleJp: "兄は東京に住んでいます。", exampleVi: "Anh trai tôi đang sống ở Tokyo."),
        VocabWord(kanji: "姉", kana: "あね", romaji: "ane", meaningVi: "Chị gái (của mình)", topicId: "family", exampleJp: "姉は先生です。", exampleVi: "Chị gái tôi là giáo viên."),
        VocabWord(kanji: "友達", kana: "ともだち", romaji: "tomodachi", meaningVi: "Bạn bè", topicId: "family", exampleJp: "友達と映画を見ます。", exampleVi: "Tôi xem phim cùng bạn."),

        // MARK: - Thời gian & Lịch trình
        VocabWord(kanji: "今日", kana: "きょう", romaji: "kyou", meaningVi: "Hôm nay", topicId: "time", exampleJp: "今日はいい天気ですね。", exampleVi: "Hôm nay thời tiết đẹp nhỉ."),
        VocabWord(kanji: "明日", kana: "あした", romaji: "ashita", meaningVi: "Ngày mai", topicId: "time", exampleJp: "明日は休みです。", exampleVi: "Ngày mai được nghỉ."),
        VocabWord(kanji: "昨日", kana: "きのう", romaji: "kinou", meaningVi: "Hôm qua", topicId: "time", exampleJp: "昨日は本を読みました。", exampleVi: "Hôm qua tôi đã đọc sách."),
        VocabWord(kanji: "今", kana: "いま", romaji: "ima", meaningVi: "Bây giờ", topicId: "time", exampleJp: "今、何時ですか。", exampleVi: "Bây giờ là mấy giờ?"),
        VocabWord(kanji: "朝", kana: "あさ", romaji: "asa", meaningVi: "Buổi sáng", topicId: "time", exampleJp: "朝六時に起きます。", exampleVi: "Tôi thức dậy lúc 6 giờ sáng."),
        VocabWord(kanji: "夜", kana: "よる", romaji: "yoru", meaningVi: "Buổi tối, đêm", topicId: "time", exampleJp: "夜、日本語を勉強します。", exampleVi: "Buổi tối tôi học tiếng Nhật."),

        // MARK: - Ẩm thực & Nhà hàng
        VocabWord(kanji: "ご飯", kana: "ごはん", romaji: "gohan", meaningVi: "Cơm, bữa ăn", topicId: "food", exampleJp: "朝ご飯を食べます。", exampleVi: "Tôi ăn bữa sáng."),
        VocabWord(kanji: "水", kana: "みず", romaji: "mizu", meaningVi: "Nước uống", topicId: "food", exampleJp: "お水をください。", exampleVi: "Làm ơn cho tôi xin nước."),
        VocabWord(kanji: "魚", kana: "さかな", romaji: "sakana", meaningVi: "Cá", topicId: "food", exampleJp: "魚が好きです。", exampleVi: "Tôi thích cá."),
        VocabWord(kanji: "肉", kana: "にく", romaji: "niku", meaningVi: "Thịt", topicId: "food", exampleJp: "牛肉を食べます。", exampleVi: "Tôi ăn thịt bò."),
        VocabWord(kanji: "野菜", kana: "やさい", romaji: "yasai", meaningVi: "Rau củ", topicId: "food", exampleJp: "新鮮な野菜です。", exampleVi: "Rau củ tươi ngon."),
        VocabWord(kanji: "おいしい", kana: "おいしい", romaji: "oishii", meaningVi: "Ngon miệng", topicId: "food", exampleJp: "このラーメンはおいしいです。", exampleVi: "Món mì ramen này rất ngon."),

        // MARK: - Đi lại & Phương tiện
        VocabWord(kanji: "電車", kana: "でんしゃ", romaji: "densha", meaningVi: "Tàu điện", topicId: "travel", exampleJp: "電車で学校へ行きます。", exampleVi: "Tôi đi học bằng tàu điện."),
        VocabWord(kanji: "駅", kana: "えき", romaji: "eki", meaningVi: "Nhà ga", topicId: "travel", exampleJp: "駅の前で会いましょう。", exampleVi: "Hãy gặp nhau trước nhà ga nhé."),
        VocabWord(kanji: "車", kana: "くるま", romaji: "kuruma", meaningVi: "Xe hơi", topicId: "travel", exampleJp: "父の車です。", exampleVi: "Đó là xe hơi của bố tôi."),
        VocabWord(kanji: "空港", kana: "くうこう", romaji: "kuukou", meaningVi: "Sân bay", topicId: "travel", exampleJp: "空港へ友達を迎えに行きます。", exampleVi: "Tôi đến sân bay đón bạn."),
        VocabWord(kanji: "自転車", kana: "じてんしゃ", romaji: "jitensha", meaningVi: "Xe đạp", topicId: "travel", exampleJp: "自転車に乗ります。", exampleVi: "Tôi đạp xe đạp.")
    ]

    public let lessons: [VocabLesson]
    public let vocabList: [VocabWord]
    public var allWords: [VocabWord] {
        return vocabList
    }

    private init() {
        let allLessons =
            Self.buildVocabLessons1To5()
            + Self.buildVocabLessons6To10()
            + Self.buildVocabLessons11To15()
            + Self.buildVocabLessons16To20()
            + Self.buildVocabLessons21To25()
            + Self.buildVocabLessons26To30()
            + Self.buildVocabLessons31To35()
            + Self.buildVocabLessons36To40()
            + Self.buildVocabLessons41To45()
            + Self.buildVocabLessons46To50()
        self.lessons = allLessons
        self.vocabList = topicWords + allLessons.flatMap { $0.words }
    }

    public func getWords(for topicId: String) -> [VocabWord] {
        return vocabList.filter { $0.topicId == topicId }
    }

    public func getLessons(level: String? = nil) -> [VocabLesson] {
        guard let level = level else { return lessons }
        return lessons.filter { $0.jlptLevel == level }
    }

    public func getLesson(_ number: Int) -> VocabLesson? {
        return lessons.first { $0.lessonNumber == number }
    }

    public func getWords(forLesson lessonNumber: Int) -> [VocabWord] {
        return getLesson(lessonNumber)?.words ?? []
    }

    public func getAllLessonWords(level: String? = nil) -> [VocabWord] {
        return getLessons(level: level).flatMap { $0.words }
    }

    private static func w(
        _ lesson: Int,
        _ kanji: String?,
        _ kana: String,
        _ romaji: String,
        _ meaningVi: String,
        note: String? = nil,
        exJp: String,
        exVi: String
    ) -> VocabWord {
        return VocabWord(
            kanji: kanji,
            kana: kana,
            romaji: romaji,
            meaningVi: meaningVi,
            topicId: "minna_lesson_\(lesson)",
            lessonNumber: lesson,
            grammarNote: note,
            exampleJp: exJp,
            exampleVi: exVi
        )
    }

    // MARK: - Phần 1: Bài 1 - 5 (N5)
    private static func buildVocabLessons1To5() -> [VocabLesson] {
        let p1 = partTags[0]
        return [
            VocabLesson(
                lessonNumber: 1,
                title: "Giới thiệu bản thân & Nghề nghiệp",
                subtitle: "わたし, 会社員, 学生, 先生, 銀行員, 大学...",
                partTag: p1,
                words: [
                    w(1, "私", "わたし", "watashi", "Tôi (ngôi thứ nhất số ít)", note: "Đại từ nhân xưng", exJp: "私はベトナム人です。", exVi: "Tôi là người Việt Nam."),
                    w(1, "皆さん", "みなさん", "minasan", "Các bạn, các anh chị, mọi người", note: "Cách gọi lịch sự số nhiều", exJp: "皆さん、おはようございます。", exVi: "Chào buổi sáng mọi người ạ."),
                    w(1, "先生", "せんせい", "sensei", "Thầy/Cô giáo (gọi tên / danh xưng)", note: "Dùng gọi người khác (Nam先生)", exJp: "山田さんは先生です。", exVi: "Thầy Yamada là giáo viên."),
                    w(1, "学生", "がくせい", "gakusei", "Học sinh, sinh viên", note: "Danh từ chỉ nghề nghiệp", exJp: "私はFPT大学の学生です。", exVi: "Tôi là sinh viên đại học FPT."),
                    w(1, "会社員", "かいしゃいん", "kaishain", "Nhân viên công ty (nói chung)", note: "「会社の社員」 khi đi kèm tên công ty", exJp: "ミラーさんはIMCの社員です。", exVi: "Anh Miller là nhân viên công ty IMC."),
                    w(1, "研修生", "けんしゅうせい", "kenshuusei", "Thực tập sinh, tu nghiệp sinh", note: "Danh từ nghề nghiệp", exJp: "グプタさんは研修生ですか。", exVi: "Anh Gupta là thực tập sinh phải không?")
                ]
            ),
            VocabLesson(
                lessonNumber: 2,
                title: "Đồ vật xung quanh (これ・それ・あれ)",
                subtitle: "本, 辞書, 新聞, 時計, 傘, かばん...",
                partTag: p1,
                words: [
                    w(2, "本", "ほん", "hon", "Sách", note: "Danh từ đồ vật", exJp: "これは日本語の本です。", exVi: "Đây là quyển sách tiếng Nhật."),
                    w(2, "辞書", "じしょ", "jisho", "Từ điển", note: "Danh từ đồ vật", exJp: "それは電子辞書ですか。", exVi: "Đó là từ điển điện tử phải không?"),
                    w(2, "新聞", "しんぶん", "shinbun", "Báo (tờ báo)", note: "Danh từ đồ vật", exJp: "父の新聞は机の上にあります。", exVi: "Tờ báo của bố ở trên bàn."),
                    w(2, "時計", "とけい", "tokei", "Đồng hồ", note: "Danh từ đồ vật", exJp: "この時計は日本の時計です。", exVi: "Chiếc đồng hồ này là đồng hồ Nhật."),
                    w(2, "傘", "かさ", "kasa", "Cái ô, cây dù", note: "Danh từ đồ vật", exJp: "あの傘は私のです。", exVi: "Cái ô đằng kia là của tôi."),
                    w(2, nil, "かばん", "kaban", "Cặp sách, túi xách", note: "Thường viết bằng Hiragana", exJp: "それは誰のかばんですか。", exVi: "Cái cặp đó là của ai vậy?")
                ]
            ),
            VocabLesson(
                lessonNumber: 3,
                title: "Địa điểm & Nơi chốn (ここ・そこ・あそこ)",
                subtitle: "教室, 食堂, 事務所, 会社, 国, 受付...",
                partTag: p1,
                words: [
                    w(3, "教室", "きょうしつ", "kyoushitsu", "Phòng học, lớp học", note: "Danh từ địa điểm", exJp: "教室は三階です。", exVi: "Phòng học ở tầng 3."),
                    w(3, "食堂", "しょくどう", "shokudou", "Nhà ăn, căn tin", note: "Danh từ địa điểm", exJp: "食堂は一階です。", exVi: "Nhà ăn ở tầng 1."),
                    w(3, "事務所", "じむしょ", "jimusho", "Văn phòng làm việc", note: "Danh từ địa điểm", exJp: "事務所はどこですか。", exVi: "Văn phòng ở đâu vậy ạ?"),
                    w(3, "受付", "うけつけ", "uketsuke", "Quầy lễ tân, tiếp tân", note: "Danh từ địa điểm", exJp: "受付はあそこです。", exVi: "Quầy lễ tân ở đằng kia."),
                    w(3, "会社", "かいしゃ", "kaisha", "Công ty", note: "Hỏi lịch sự dùng おくに / どちら", exJp: "あなたの会社はどちらですか。", exVi: "Công ty của anh ở đâu/tên gì ạ?"),
                    w(3, "国", "くに", "kuni", "Đất nước, quê hương", note: "Lịch sự: おくに", exJp: "お国はどちらですか。", exVi: "Quê hương/đất nước của bạn ở đâu ạ?")
                ]
            ),
            VocabLesson(
                lessonNumber: 4,
                title: "Giờ giấc & Sinh hoạt hằng ngày",
                subtitle: "起きます, 寝ます, 働きます, 勉強します, 図書館, 郵便局...",
                partTag: p1,
                words: [
                    w(4, "起きます", "おきます", "okimasu", "Thức dậy", note: "【Nhóm II】《起きます・起きる・起きて》", exJp: "毎朝六時に起きます。", exVi: "Sáng nào tôi cũng dậy lúc 6 giờ."),
                    w(4, "寝ます", "ねます", "nemasu", "Ngủ, đi ngủ", note: "【Nhóm II】《寝ます・寝る・寝て》", exJp: "昨日は十一時に寝ました。", exVi: "Hôm qua tôi đã đi ngủ lúc 11 giờ."),
                    w(4, "働きます", "はたらきます", "hatarakimasu", "Làm việc", note: "【Nhóm I】《働きます・働く・働いて》", exJp: "九時から五時まで働きます。", exVi: "Tôi làm việc từ 9 giờ đến 5 giờ."),
                    w(4, "休みます", "やすみます", "yasumimasu", "Nghỉ ngơi, nghỉ làm", note: "【Nhóm I】《休みます・休む・休んで》", exJp: "日曜日は会社を休みます。", exVi: "Chủ Nhật tôi nghỉ làm ở công ty."),
                    w(4, "勉強します", "べんきょうします", "benkyou shimasu", "Học tập", note: "【Nhóm III】《勉強する・勉強して》", exJp: "毎日日本語を勉強します。", exVi: "Mỗi ngày tôi đều học tiếng Nhật."),
                    w(4, "図書館", "としょかん", "toshokan", "Thư viện", note: "Danh từ địa điểm", exJp: "図書館で本を借ります。", exVi: "Tôi mượn sách ở thư viện.")
                ]
            ),
            VocabLesson(
                lessonNumber: 5,
                title: "Di chuyển & Ngày tháng",
                subtitle: "行きます, 来ます, 帰ります, 飛行機, 新幹線, 誕生日...",
                partTag: p1,
                words: [
                    w(5, "行きます", "いきます", "ikimasu", "Đi (đến một nơi)", note: "【Nhóm I】《行きます・行く・行って》(chú ý 行って)", exJp: "来週東京へ行きます。", exVi: "Tuần sau tôi sẽ đi Tokyo."),
                    w(5, "来ます", "きます", "kimasu", "Đến", note: "【Nhóm III】《来ます・来る・来て》", exJp: "友達が日本から来ます。", exVi: "Bạn tôi từ Nhật Bản đến."),
                    w(5, "帰ります", "かえります", "kaerimasu", "Trở về (nhà, quê, nước)", note: "【Nhóm I】《帰ります・帰る・帰って》", exJp: "七時にうちへ帰ります。", exVi: "Tôi về nhà lúc 7 giờ."),
                    w(5, "新幹線", "しんかんせん", "shinkansen", "Tàu siêu tốc Shinkansen", note: "Đi bằng phương tiện dùng trợ từ で", exJp: "新幹線で京都へ行きます。", exVi: "Tôi đi Kyoto bằng tàu Shinkansen."),
                    w(5, "歩いて", "あるいて", "aruite", "Đi bộ", note: "Không dùng trợ từ で sau 歩いて", exJp: "駅から歩いて帰りました。", exVi: "Tôi đã đi bộ từ nhà ga về nhà."),
                    w(5, "誕生日", "たんじょうび", "tanjoubi", "Sinh nhật", note: "Danh từ chỉ ngày đặc biệt", exJp: "私の誕生日は五月十日です。", exVi: "Sinh nhật của tôi là ngày 10 tháng 5.")
                ]
            )
        ]
    }

    // MARK: - Phần 1: Bài 6 - 10 (N5)
    private static func buildVocabLessons6To10() -> [VocabLesson] {
        let p1 = partTags[0]
        return [
            VocabLesson(
                lessonNumber: 6,
                title: "Hoạt động thường ngày & Đồ ăn thức uống",
                subtitle: "食べます, 飲みます, 吸います, 買います, 果物, 映画...",
                partTag: p1,
                words: [
                    w(6, "食べます", "たべます", "tabemasu", "Ăn", note: "【Nhóm II】《食べます・食べる・食べて》", exJp: "食堂で昼ご飯を食べます。", exVi: "Tôi ăn cơm trưa ở nhà ăn."),
                    w(6, "飲みます", "のみます", "nomimasu", "Uống", note: "【Nhóm I】《飲みます・飲む・飲んで》", exJp: "毎朝コーヒーを飲みます。", exVi: "Sáng nào tôi cũng uống cà phê."),
                    w(6, "吸います", "すいます", "suimasu", "Hút (thuốc lá)", note: "【Nhóm I】「たばこを～」吸います", exJp: "ここでたばこを吸いません。", exVi: "Tôi không hút thuốc ở đây."),
                    w(6, "書きます", "かきます", "kakimasu", "Viết, vẽ", note: "【Nhóm I】《書きます・書く・書いて》", exJp: "ノートに名前を書きます。", exVi: "Tôi viết tên vào vở."),
                    w(6, "読みます", "よみます", "yomimasu", "Đọc", note: "【Nhóm I】《読みます・読む・読んで》", exJp: "毎晩新聞を読みます。", exVi: "Tối nào tôi cũng đọc báo."),
                    w(6, "果物", "くだもの", "kudamono", "Hoa quả, trái cây", note: "Danh từ thực phẩm", exJp: "スーパーで果物を買いました。", exVi: "Tôi đã mua hoa quả ở siêu thị.")
                ]
            ),
            VocabLesson(
                lessonNumber: 7,
                title: "Công cụ & Cho - Nhận đồ vật",
                subtitle: "切ります, 修理します, 電話をかけます, あげます, もらいます, 教えます...",
                partTag: p1,
                words: [
                    w(7, "切ります", "きります", "kirimasu", "Cắt, gọt", note: "【Nhóm I】《切ります・切る・切って》「はさみで～」", exJp: "はさみで紙を切ります。", exVi: "Tôi cắt giấy bằng kéo."),
                    w(7, "修理します", "しゅうりします", "shuuri shimasu", "Sửa chữa", note: "【Nhóm III】《修理する・修理して》", exJp: "父は自転車を修理します。", exVi: "Bố tôi sửa xe đạp."),
                    w(7, nil, "かけます", "kakemasu", "Gọi (điện thoại)", note: "【Nhóm II】「電話を～」かけます", exJp: "家族に電話をかけます。", exVi: "Tôi gọi điện thoại cho gia đình."),
                    w(7, nil, "あげます", "agemasu", "Cho, biếu, tặng", note: "【Nhóm II】《あげます・あげる・あげて》", exJp: "母に花をあげました。", exVi: "Tôi đã tặng hoa cho mẹ."),
                    w(7, nil, "もらいます", "moraimasu", "Nhận, nhận được", note: "【Nhóm I】《もらいます・もらう・もらって》", exJp: "友達にプレゼントをもらいました。", exVi: "Tôi đã nhận được quà từ bạn."),
                    w(7, "教えます", "おしえます", "oshiemasu", "Dạy, chỉ bảo", note: "【Nhóm II】《教えます・教える・教えて》", exJp: "先生に日本語を教えてもらいます。", exVi: "Tôi được thầy dạy cho tiếng Nhật.")
                ]
            ),
            VocabLesson(
                lessonNumber: 8,
                title: "Tính từ miêu tả (い & な)",
                subtitle: "親切な, 有名な, 静かな, 便利な, おいしい, 忙しい...",
                partTag: p1,
                words: [
                    w(8, nil, "きれい「な」", "kirei na", "Đẹp, xinh đẹp, sạch sẽ", note: "【Tính từ な】Cẩn thận dễ nhầm đuôi い", exJp: "京都はきれいな町です。", exVi: "Kyoto là một thành phố đẹp."),
                    w(8, "親切「な」", "しんせつ「な」", "shinsetsu na", "Tốt bụng, thân thiện, tử tế", note: "【Tính từ な】", exJp: "日本人はとても親切です。", exVi: "Người Nhật rất thân thiện tốt bụng."),
                    w(8, "有名「な」", "ゆうめい「な」", "yuumei na", "Nổi tiếng", note: "【Tính từ な】", exJp: "富士山の写真。有名な山です。", exVi: "Ảnh núi Phú Sĩ. Đó là ngọn núi nổi tiếng."),
                    w(8, "静か「な」", "しずか「な」", "shizuka na", "Yên tĩnh, yên ắng", note: "【Tính từ な】", exJp: "私の町はとても静かです。", exVi: "Thị trấn của tôi rất yên tĩnh."),
                    w(8, "便利「な」", "べんり「な」", "benri na", "Tiện lợi, thuận tiện", note: "【Tính từ な】Trái nghĩa: 不便「な」", exJp: "地下鉄はとても便利です。", exVi: "Tàu điện ngầm rất tiện lợi."),
                    w(8, nil, "おいしい", "oishii", "Ngon miệng", note: "【Tính từ い】", exJp: "ベトナムの料理はおいしいです。", exVi: "Món ăn Việt Nam rất ngon.")
                ]
            ),
            VocabLesson(
                lessonNumber: 9,
                title: "Sở thích, Năng lực & Lý do",
                subtitle: "分かります, あります, 好き, 嫌い, 上手, 下手...",
                partTag: p1,
                words: [
                    w(9, "分かります", "わかります", "wakarimasu", "Hiểu", note: "【Nhóm I】「日本語が～」分かります (trợ từ が)", exJp: "ひらがながよく分かります。", exVi: "Tôi hiểu rõ chữ Hiragana."),
                    w(9, "好き「な」", "すき「な」", "suki na", "Thích", note: "【Tính từ な】Đi với trợ từ が", exJp: "私は音楽が好きです。", exVi: "Tôi thích âm nhạc."),
                    w(9, "嫌い「な」", "きらい「な」", "kirai na", "Ghét, không thích", note: "【Tính từ な】Đi với trợ từ が", exJp: "弟は野菜が嫌いです。", exVi: "Em trai tôi ghét ăn rau."),
                    w(9, "上手「な」", "じょうず「な」", "jouzu na", "Khéo, giỏi", note: "【Tính từ な】Không dùng khen chính mình", exJp: "カリナさんは絵が上手です。", exVi: "Chị Karina vẽ tranh rất giỏi."),
                    w(9, "下手「な」", "へた「な」", "heta na", "Kém, vụng về", note: "【Tính từ な】", exJp: "私は歌が下手です。", exVi: "Tôi hát kém lắm."),
                    w(9, "約束", "やくそく", "yakusoku", "Lời hứa, cuộc hẹn", note: "「約束が あります」", exJp: "今日は友達と約束があります。", exVi: "Hôm nay tôi có hẹn với bạn.")
                ]
            ),
            VocabLesson(
                lessonNumber: 10,
                title: "Sự tồn tại & Vị trí không gian",
                subtitle: "います, あります, 上, 下, 前, 後ろ, 中, 外...",
                partTag: p1,
                words: [
                    w(10, nil, "います", "imasu", "Có, ở (người & động vật)", note: "【Nhóm II】《います・いる・いて》", exJp: "公園に子どもがいます。", exVi: "Ở công viên có mấy đứa trẻ."),
                    w(10, nil, "あります", "arimasu", "Có, ở (đồ vật, thực vật, nơi chốn)", note: "【Nhóm I】《あります・ある・あって》", exJp: "机の上にカメラがあります。", exVi: "Trên bàn có chiếc máy ảnh."),
                    w(10, "上", "うえ", "ue", "Trên, bên trên", note: "Danh từ chỉ vị trí", exJp: "箱の上にねこがいます。", exVi: "Có con mèo ở trên cái hộp."),
                    w(10, "下", "した", "shita", "Dưới, bên dưới", note: "Danh từ chỉ vị trí", exJp: "いすの下に靴があります。", exVi: "Dưới ghế có đôi giày."),
                    w(10, "隣", "となり", "tonari", "Bên cạnh (sát cạnh)", note: "Thường cùng loại hoặc ngay bên cạnh", exJp: "銀行の隣に本屋があります。", exVi: "Bên cạnh ngân hàng có hiệu sách."),
                    w(10, "間", "あいだ", "aida", "Ở giữa (hai đối tượng)", note: "AとBのあいだ", exJp: "駅と郵便局の間にカフェがあります。", exVi: "Giữa nhà ga và bưu điện có quán cà phê.")
                ]
            )
        ]
    }

    // MARK: - Phần 2: Bài 11 - 15 (N5)
    private static func buildVocabLessons11To15() -> [VocabLesson] {
        let p2 = partTags[1]
        return [
            VocabLesson(
                lessonNumber: 11,
                title: "Lượng từ & Khoảng thời gian",
                subtitle: "かかります, 一つ, 二つ, ～人, どのくらい, 全部で...",
                partTag: p2,
                words: [
                    w(11, nil, "かかります", "kakarimasu", "Mất, tốn (thời gian, tiền bạc)", note: "【Nhóm I】《かかります・かかる・かかって》", exJp: "大阪まで二時間半かかります。", exVi: "Đi đến Osaka mất 2 tiếng rưỡi."),
                    w(11, "一つ", "ひとつ", "hitotsu", "1 cái (đếm đồ vật chung)", note: "Đếm đồ vật: ひとつ〜とお (1-10)", exJp: "りんごを一つください。", exVi: "Làm ơn cho tôi 1 quả táo."),
                    w(11, "外国", "がいこく", "gaikoku", "Nước ngoài", note: "Danh từ", exJp: "外国へ旅行に行きたいです。", exVi: "Tôi muốn đi du lịch nước ngoài."),
                    w(11, "留学", "りゅうがく", "ryuugaku", "Du học", note: "「日本へ留学します」", exJp: "兄は二年日本へ留学しました。", exVi: "Anh trai tôi đã du học ở Nhật 2 năm."),
                    w(11, "全部で", "ぜんぶで", "zenbu de", "Tổng cộng, tất cả hết", note: "Phó từ chỉ tổng lượng", exJp: "全部で三千円になります。", exVi: "Tổng cộng hết 3000 yên ạ."),
                    w(11, nil, "どのくらい", "donokurai", "Khoảng bao lâu / bao nhiêu", note: "Từ để hỏi thời lượng/tiền", exJp: "国から日本までどのくらいかかりますか。", exVi: "Từ nước bạn đến Nhật mất khoảng bao lâu?")
                ]
            ),
            VocabLesson(
                lessonNumber: 12,
                title: "So sánh & Cảm nhận thời tiết",
                subtitle: "簡単, 忙しい, 近い, 遠い, 早い, 多い, 季節...",
                partTag: p2,
                words: [
                    w(12, "簡単「な」", "かんたん「な」", "kantan na", "Đơn giản, dễ dàng", note: "【Tính từ な】Trái nghĩa: 複雑な", exJp: "この漢字はとても簡単です。", exVi: "Chữ Kanji này rất đơn giản."),
                    w(12, "忙しい", "いそがしい", "isogashii", "Bận rộn", note: "【Tính từ い】Quá khứ: 忙しかった", exJp: "先週はとても忙しかったです。", exVi: "Tuần trước tôi đã rất bận rộn."),
                    w(12, "近い", "ちかい", "chikai", "Gần", note: "【Tính từ い】", exJp: "私の家は駅から近いです。", exVi: "Nhà tôi gần nhà ga."),
                    w(12, "遠い", "とおい", "tooi", "Xa", note: "【Tính từ い】", exJp: "学校はここから遠いですか。", exVi: "Trường học có xa đây không?"),
                    w(12, "多い", "おおい", "ooi", "Nhiều, đông", note: "【Tính từ い】「人が～」 (không đặt trước danh từ)", exJp: "東京は人が多いです。", exVi: "Tokyo đông người lắm."),
                    w(12, "季節", "きせつ", "kisetsu", "Mùa (trong năm)", note: "春・夏・秋・冬", exJp: "日本の季節で秋が一番好きです。", exVi: "Trong các mùa ở Nhật tôi thích mùa thu nhất.")
                ]
            ),
            VocabLesson(
                lessonNumber: 13,
                title: "Mong muốn & Mục đích di chuyển",
                subtitle: "遊びます, 泳ぎます, 迎えます, 疲れます, 送ります, 欲しい...",
                partTag: p2,
                words: [
                    w(13, "遊びます", "あそびます", "asobimasu", "Chơi, đi chơi", note: "【Nhóm I】《遊びます・遊ぶ・遊んで》", exJp: "週末は友達と遊びます。", exVi: "Cuối tuần tôi đi chơi với bạn."),
                    w(13, "泳ぎます", "およぎます", "oyogimasu", "Bơi lội", note: "【Nhóm I】《泳ぎます・泳ぐ・泳いで》", exJp: "海へ泳ぎに行きます。", exVi: "Tôi đi ra biển bơi."),
                    w(13, "迎えます", "むかえます", "mukaemasu", "Đón (người)", note: "【Nhóm II】《迎えます・迎える・迎えて》", exJp: "空港へ社長を迎えに行きます。", exVi: "Tôi đến sân bay đón giám đốc."),
                    w(13, "送ります", "おくります", "okurimasu", "Gửi (bưu kiện, hàng hóa)", note: "【Nhóm I】「荷物を～」送ります", exJp: "郵便局へ荷物を送りに行きます。", exVi: "Tôi đi ra bưu điện để gửi đồ."),
                    w(13, "疲れます", "つかれます", "tsukaremasu", "Mệt mỏi", note: "【Nhóm II】Hay dùng dạng 「疲れました」", exJp: "毎日残業して、とても疲れました。", exVi: "Ngày nào cũng tăng ca nên tôi mệt lắm."),
                    w(13, "欲しい", "ほしい", "hoshii", "Muốn có (vật gì đó)", note: "【Tính từ い】Đi với trợ từ が", exJp: "今一番新しいパソコンが欲しいです。", exVi: "Bây giờ thứ tôi muốn nhất là một chiếc máy tính mới.")
                ]
            ),
            VocabLesson(
                lessonNumber: 14,
                title: "Động từ chia thể て (Nhờ vả & Đang làm)",
                subtitle: "呼びます, 急ぎます, 待ちます, 取ります, 手伝います, 覚えます...",
                partTag: p2,
                words: [
                    w(14, "呼びます", "よびます", "yobimasu", "Gọi (tên, taxi...)", note: "【Nhóm I】《呼びます・呼ぶ・呼んで》", exJp: "タクシーを呼んでください。", exVi: "Làm ơn gọi giúp tôi một chiếc taxi."),
                    w(14, "急ぎます", "いそぎます", "isogimasu", "Vội vàng, khẩn trương", note: "【Nhóm I】《急ぎます・急ぐ・急いで》", exJp: "時間がないので、急ぎましょう。", exVi: "Vì không còn thời gian nên mau khẩn trương thôi."),
                    w(14, "待ちます", "まちます", "machimasu", "Chờ, đợi", note: "【Nhóm I】《待ちます・待つ・待って》", exJp: "すみません、ちょっと待ってください。", exVi: "Xin lỗi, vui lòng đợi một chút ạ."),
                    w(14, "手伝います", "てつだいます", "tetsudaimasu", "Giúp đỡ, làm đỡ", note: "【Nhóm I】《手伝います・手伝う・手伝って》", exJp: "母の仕事を手伝っています。", exVi: "Tôi đang giúp việc cho mẹ."),
                    w(14, "話します", "はなします", "hanashimasu", "Nói, kể chuyện", note: "【Nhóm I】《話します・話す・話して》", exJp: "もっとゆっくり話してください。", exVi: "Xin hãy nói chậm hơn một chút ạ."),
                    w(14, "覚えます", "おぼえます", "oboemasu", "Ghi nhớ, học thuộc", note: "【Nhóm II】《覚えます・覚える・覚えて》", exJp: "毎日新しい漢字を十個覚えます。", exVi: "Mỗi ngày tôi học thuộc 10 chữ Hán mới.")
                ]
            ),
            VocabLesson(
                lessonNumber: 15,
                title: "Trạng thái, Nghề nghiệp & Xin phép",
                subtitle: "使います, 座ります, 立ちます, 置きます, 作ります, 知ります...",
                partTag: p2,
                words: [
                    w(15, "使います", "つかいます", "tsukaimasu", "Dùng, sử dụng", note: "【Nhóm I】《使います・使う・使って》", exJp: "このパソコンを使ってもいいですか。", exVi: "Tôi dùng chiếc máy tính này có được không?"),
                    w(15, "座ります", "すわります", "suwarimasu", "Ngồi", note: "【Nhóm I】「いすに～」座ります", exJp: "どうぞこのいすに座ってください。", exVi: "Xin mời ngồi vào chiếc ghế này ạ."),
                    w(15, "置きます", "おきます", "okimasu", "Đặt, để", note: "【Nhóm I】《置きます・置く・置いて》", exJp: "ここに荷物を置いてはいけません。", exVi: "Không được đặt hành lý ở đây."),
                    w(15, "作ります", "つくります", "tsukurimasu", "Làm, sản xuất, chế tạo", note: "【Nhóm I】《作ります・作る・作って》", exJp: "トヨタは自動車を作っています。", exVi: "Công ty Toyota chuyên sản xuất ô tô."),
                    w(15, "売ります", "うります", "urimasu", "Bán", note: "【Nhóm I】《売ります・売る・売って》", exJp: "あの店でパンを売っています。", exVi: "Cửa hàng đằng kia đang bán bánh mì."),
                    w(15, "知ります", "しります", "shirimasu", "Biết (thường dùng 知っています / 知りません)", note: "【Nhóm I】Phủ định: 知りません", exJp: "電話番号を知っていますか。", exVi: "Bạn có biết số điện thoại không?")
                ]
            )
        ]
    }

    // MARK: - Phần 2: Bài 16 - 20 (N5)
    private static func buildVocabLessons16To20() -> [VocabLesson] {
        let p2 = partTags[1]
        return [
            VocabLesson(
                lessonNumber: 16,
                title: "Chuỗi hành động & Cách thức đi lại",
                subtitle: "乗ります, 降ります, 乗り換えます, 入れます, 出します, 押します...",
                partTag: p2,
                words: [
                    w(16, "乗ります", "のります", "norimasu", "Lên (tàu điện, xe)", note: "【Nhóm I】「電車に～」乗ります", exJp: "駅で電車に乗ります。", exVi: "Tôi lên tàu điện ở nhà ga."),
                    w(16, "降ります", "おります", "orimasu", "Xuống (khỏi tàu điện, xe)", note: "【Nhóm II】「電車を～」降ります", exJp: "東京駅で電車を降ります。", exVi: "Tôi xuống tàu điện ở ga Tokyo."),
                    w(16, "乗り換えます", "のりかえます", "norikaemasu", "Chuyển tàu, đổi chuyến", note: "【Nhóm II】《乗り換える・乗り換えて》", exJp: "新宿駅でJRに乗り換えます。", exVi: "Tôi chuyển sang tuyến JR ở ga Shinjuku."),
                    w(16, "入れます", "いれます", "iremasu", "Bỏ vào, cho vào", note: "【Nhóm II】《入れます・入れる・入れて》", exJp: "カードを入れてから、暗証番号を押します。", exVi: "Sau khi đút thẻ vào thì nhấn mã PIN."),
                    w(16, "出します", "だします", "dashimasu", "Rút ra, nộp, lấy ra", note: "【Nhóm I】「お金を～」出します", exJp: "ATMでお金を出しました。", exVi: "Tôi đã rút tiền ở cây ATM."),
                    w(16, "押します", "おします", "oshimasu", "Ấn, nhấn (nút)", note: "【Nhóm I】《押します・押す・押して》", exJp: "金額を押して、確認ボタンを押します。", exVi: "Nhập số tiền rồi bấm nút xác nhận.")
                ]
            ),
            VocabLesson(
                lessonNumber: 17,
                title: "Động từ thể ない (Nghĩa vụ & Nhắc nhở)",
                subtitle: "忘れます, 無くします, 気をつけます, 払います, 返します, 脱ぎます...",
                partTag: p2,
                words: [
                    w(17, "忘れます", "わすれます", "wasuremasu", "Quên", note: "【Nhóm II】《忘れます・忘れる・忘れて》", exJp: "パスポートを忘れないでください。", exVi: "Xin đừng quên hộ chiếu nhé."),
                    w(17, "無くします", "なくします", "nakushimasu", "Làm mất", note: "【Nhóm I】《無くします・無くす・無くして》", exJp: "財布を無くさないようにします。", exVi: "Tôi cố gắng để không làm mất ví."),
                    w(17, "気をつけます", "きをつけます", "ki o tsukemasu", "Chú ý, cẩn thận", note: "【Nhóm II】「車に～」気をつけます", exJp: "車に気をつけてくださいね。", exVi: "Hãy cẩn thận xe cộ nhé."),
                    w(17, "払います", "はらいます", "haraimasu", "Trả tiền, thanh toán", note: "【Nhóm I】《払います・払う・払って》", exJp: "ここで現金を払わなければなりません。", exVi: "Ở đây phải trả bằng tiền mặt."),
                    w(17, "返します", "かえします", "kaeshimasu", "Trả lại (đồ đã mượn)", note: "【Nhóm I】《返します・返す・返して》", exJp: "明日までに本を返さなければなりません。", exVi: "Tôi phải trả sách trước ngày mai."),
                    w(17, "脱ぎます", "ぬぎます", "nugimasu", "Cởi (quần áo, giày dép)", note: "【Nhóm I】《脱ぎます・脱ぐ・脱いで》", exJp: "部屋に入るとき、靴を脱ぎます。", exVi: "Khi vào phòng thì cởi giày ra.")
                ]
            ),
            VocabLesson(
                lessonNumber: 18,
                title: "Thể từ điển (Năng lực & Sở thích)",
                subtitle: "できます, 歌います, 弾きます, 運転します, 練習します, 洗います...",
                partTag: p2,
                words: [
                    w(18, nil, "できます", "dekimasu", "Có thể làm được", note: "【Nhóm II】「N / Vことが～」できます", exJp: "漢字を読むことができます。", exVi: "Tôi có thể đọc được chữ Hán."),
                    w(18, "歌います", "うたいます", "utaimasu", "Hát", note: "【Nhóm I】《歌います・歌う・歌って》", exJp: "趣味は日本の歌を歌うことです。", exVi: "Sở thích của tôi là hát bài hát tiếng Nhật."),
                    w(18, "弾きます", "ひきます", "hikimasu", "Chơi (nhạc cụ dây/phím)", note: "【Nhóm I】「ピアノを～」弾きます", exJp: "姉はピアノを弾くことができます。", exVi: "Chị gái tôi có thể chơi đàn piano."),
                    w(18, "運転します", "うんてんします", "unten shimasu", "Lái xe, điều khiển", note: "【Nhóm III】《運転する・運転して》", exJp: "私は車を運転することができます。", exVi: "Tôi biết lái xe ô tô."),
                    w(18, "練習します", "れんしゅうします", "renshuu shimasu", "Luyện tập", note: "【Nhóm III】《練習する・練習して》", exJp: "寝る前に、漢字を練習します。", exVi: "Trước khi đi ngủ, tôi luyện viết Kanji."),
                    w(18, "洗います", "あらいます", "araimasu", "Rửa, giặt", note: "【Nhóm I】《洗います・洗う・洗って》", exJp: "食べる前に、手を洗います。", exVi: "Trước khi ăn tôi rửa tay.")
                ]
            ),
            VocabLesson(
                lessonNumber: 19,
                title: "Động từ chia thể た (Kinh nghiệm & Liệt kê)",
                subtitle: "登ります, 泊まります, 掃除します, 洗濯します, なります, 眠い...",
                partTag: p2,
                words: [
                    w(19, "登ります", "のぼります", "noborimasu", "Leo, trèo", note: "【Nhóm I】「山に～」登ります", exJp: "富士山に登ったことがあります。", exVi: "Tôi đã từng leo núi Phú Sĩ rồi."),
                    w(19, "泊まります", "とまります", "tomarimasu", "Nghỉ trọ, ở lại qua đêm", note: "【Nhóm I】「ホテルに～」泊まります", exJp: "京都で日本の旅館に泊まりました。", exVi: "Tôi đã nghỉ ở lữ quán Nhật Bản tại Kyoto."),
                    w(19, "掃除します", "そうじします", "souji shimasu", "Dọn dẹp, quét dọn", note: "【Nhóm III】《掃除する・掃除して》", exJp: "週末は部屋を掃除したりします。", exVi: "Cuối tuần tôi làm những việc như dọn dẹp phòng."),
                    w(19, "洗濯します", "せんたくします", "sentaku shimasu", "Giặt giũ", note: "【Nhóm III】《洗濯する・洗濯して》", exJp: "日曜日は服を洗濯したりします。", exVi: "Chủ Nhật tôi giặt quần áo và làm vài việc khác."),
                    w(19, nil, "なります", "narimasu", "Trở nên, trở thành", note: "【Nhóm I】《なります・なる・なって》", exJp: "もうすぐ春になりますね。", exVi: "Chẳng bao lâu nữa sẽ sang xuân nhỉ."),
                    w(19, "眠い", "ねむい", "nemui", "Buồn ngủ", note: "【Tính từ い】《眠く なります》", exJp: "夜遅いので、眠くなりました。", exVi: "Vì khuya rồi nên tôi thấy buồn ngủ.")
                ]
            ),
            VocabLesson(
                lessonNumber: 20,
                title: "Thể thông thường & Xưng hô thân mật",
                subtitle: "要ります, 調べます, 電話します, 僕, 君, みんな...",
                partTag: p2,
                words: [
                    w(20, "要ります", "いります", "irimasu", "Cần, cần có", note: "【Nhóm I】「辞書が～」要ります (trợ từ が)", exJp: "日本へ行くとき、ビザが要る？", exVi: "Khi đi Nhật có cần visa không?"),
                    w(20, "調べます", "しらべます", "shirabemasu", "Tìm hiểu, điều tra, tra cứu", note: "【Nhóm II】《調べます・調べる・調べて》", exJp: "わからない言葉を辞書で調べる。", exVi: "Tra từ không biết bằng từ điển."),
                    w(20, "電話します", "でんわします", "denwa shimasu", "Gọi điện thoại", note: "【Nhóm III】「友達に～」電話する", exJp: "あとで友達に電話するよ。", exVi: "Lát nữa tớ sẽ gọi điện cho bạn."),
                    w(20, "僕", "ぼく", "boku", "Mình, tớ (nam giới dùng thân mật)", note: "Thay cho わたし khi nói văn suồng sã", exJp: "僕の趣味はサッカーなんだ。", exVi: "Sở thích của tớ là bóng đá đấy."),
                    w(20, "君", "きみ", "kimi", "Cậu, bạn (thay cho あなた)", note: "Dùng với người ngang hàng hoặc dưới tuổi", exJp: "君も一緒に行かない？", exVi: "Cậu cũng đi cùng không?"),
                    w(20, nil, "みんな", "minna", "Mọi người, tất cả (thân mật)", note: "Thay cho みなさん trong hội thoại", exJp: "明日みんなとパーティーをするよ。", exVi: "Ngày mai tớ tổ chức tiệc với mọi người đấy.")
                ]
            )
        ]
    }

    // MARK: - Phần 3: Bài 21 - 25 (N5)
    private static func buildVocabLessons21To25() -> [VocabLesson] {
        let p3 = partTags[2]
        return [
            VocabLesson(
                lessonNumber: 21,
                title: "Suy nghĩ, Ý kiến & Thảo luận",
                subtitle: "思います, 言います, 役に立ちます, 会議, 意見, 技術...",
                partTag: p3,
                words: [
                    w(21, "思います", "おもいます", "omoimasu", "Nghĩ, cho rằng", note: "【Nhóm I】《思います・思う・思って》「～と 思います」", exJp: "明日は雨が降ると思います。", exVi: "Tôi nghĩ ngày mai trời sẽ mưa."),
                    w(21, "言います", "いいます", "iimasu", "Nói, phát biểu", note: "【Nhóm I】《言います・言う・言って》「～と 言います」", exJp: "寝る前に「おやすみなさい」と言います。", exVi: "Trước khi ngủ ta nói 'Chúc ngủ ngon'."),
                    w(21, "役に立ちます", "やくにたちます", "yaku ni tachimasu", "Có ích, giúp ích", note: "【Nhóm I】《役に立つ・役に立って》", exJp: "このアプリはとても役に立ちます。", exVi: "Ứng dụng này rất hữu ích."),
                    w(21, "意見", "いけん", "iken", "Ý kiến", note: "「意見を 言います」", exJp: "会議で自分の意見を言いました。", exVi: "Tôi đã phát biểu ý kiến của mình trong cuộc họp."),
                    w(21, "会議", "かいぎ", "kaigi", "Cuộc họp, hội nghị", note: "「会議を します」", exJp: "会議についてどう思いますか。", exVi: "Bạn nghĩ thế nào về cuộc họp?"),
                    w(21, "技術", "ぎじゅつ", "gijutsu", "Kỹ thuật, công nghệ", note: "Danh từ", exJp: "日本は技術が進んでいます。", exVi: "Nhật Bản rất tiên tiến về kỹ thuật.")
                ]
            ),
            VocabLesson(
                lessonNumber: 22,
                title: "Trang phục & Động từ mặc/đeo/đội",
                subtitle: "着ます, 履きます, 被ります, 掛けます, 持って行きます, 家賃...",
                partTag: p3,
                words: [
                    w(22, "着ます", "きます", "kimasu", "Mặc (áo sơ mi, áo khoác)", note: "【Nhóm II】《着ます・着る・着て》「シャツを～」", exJp: "青いシャツを着ている人は誰ですか。", exVi: "Người đang mặc áo sơ mi xanh là ai vậy?"),
                    w(22, "履きます", "はきます", "hakimasu", "Đi (giày/tất), mặc (quần/váy)", note: "【Nhóm I】《履きます・履く・履いて》", exJp: "妹が履いている靴は高いです。", exVi: "Đôi giày em gái tôi đang đi rất đắt."),
                    w(22, "被ります", "かぶります", "kaburimasu", "Đội (mũ)", note: "【Nhóm I】《被ります・被る・被って》「帽子を～」", exJp: "白い帽子を被っている人です。", exVi: "Là người đang đội cái mũ trắng đấy."),
                    w(22, "掛けます", "かけます", "kakemasu", "Đeo (kính)", note: "【Nhóm II】《掛けます・掛ける・掛けて》「眼鏡を～」", exJp: "眼鏡を掛けている人はミラーさんです。", exVi: "Người đang đeo kính là anh Miller."),
                    w(22, "持って行きます", "もっていきます", "motte ikimasu", "Mang đi theo", note: "【Nhóm I】《持って行く・持って行って》", exJp: "明日学校へ持って行く辞書を買いました。", exVi: "Tôi đã mua quyển từ điển để ngày mai mang đến trường."),
                    w(22, "家賃", "やちん", "yachin", "Tiền thuê nhà hàng tháng", note: "Danh từ", exJp: "家賃が安くてきれいな部屋を探しています。", exVi: "Tôi đang tìm phòng đẹp mà tiền thuê nhà rẻ.")
                ]
            ),
            VocabLesson(
                lessonNumber: 23,
                title: "Thao tác máy móc & Giao thông",
                subtitle: "聞きます(hỏi), 押します, 回します, 動きます, 止まります, 渡ります...",
                partTag: p3,
                words: [
                    w(23, "聞きます", "ききます", "kikimasu", "Hỏi (thầy cô, người khác)", note: "【Nhóm I】「先生に～」聞きます (dùng trợ từ に)", exJp: "分からないとき、先生に聞きます。", exVi: "Khi không hiểu thì hỏi thầy giáo."),
                    w(23, "回します", "まわします", "mawashimasu", "Vặn, xoay", note: "【Nhóm I】《回します・回す・回して》", exJp: "このつまみを右へ回すと、音が出ます。", exVi: "Hễ vặn núm này sang phải thì âm thanh phát ra."),
                    w(23, "動きます", "うごきます", "ugokimasu", "Chạy, hoạt động, vận hành (máy)", note: "【Nhóm I】「機械が～」動きます", exJp: "ボタンを押しても、機械が動きません。", exVi: "Dù bấm nút rồi mà máy vẫn không chạy."),
                    w(23, "止まります", "とまります", "tomarimasu", "Dừng lại, ngừng (tự động từ)", note: "【Nhóm I】「車が～」止まります", exJp: "故障で電車が止まりました。", exVi: "Do hỏng hóc nên tàu điện đã dừng lại."),
                    w(23, "渡ります", "わたります", "watarimasu", "Băng qua, đi qua (cầu, đường)", note: "【Nhóm I】「橋を～」渡ります (dùng を)", exJp: "あの橋を渡ると、右に病院があります。", exVi: "Hễ đi qua cây cầu kia thì bên phải có bệnh viện."),
                    w(23, "困ります", "こまります", "komarimasu", "Gặp rắc rối, bối rối, khó xử", note: "【Nhóm I】《困ります・困る・困って》", exJp: "パスポートを無くしたら、困りますね。", exVi: "Nếu làm mất hộ chiếu thì gay to nhỉ.")
                ]
            ),
            VocabLesson(
                lessonNumber: 24,
                title: "Cho & Nhận hành động",
                subtitle: "送ります(tiễn), くれます, 連れて行きます, 連れて来ます, 紹介します...",
                partTag: p3,
                words: [
                    w(24, nil, "くれます", "kuremasu", "Cho, làm giúp (cho bản thân tôi)", note: "【Nhóm II】《くれます・くれる・くれて》", exJp: "母が誕生日に時計をくれました。", exVi: "Mẹ đã tặng đồng hồ cho tôi vào sinh nhật."),
                    w(24, "送ります", "おくります", "okurimasu", "Tiễn, đưa về", note: "【Nhóm I】「人を駅まで～」送ります", exJp: "友達が駅まで送ってくれました。", exVi: "Bạn tôi đã tiễn tôi ra tận nhà ga."),
                    w(24, "連れて行きます", "つれていきます", "tsurete ikimasu", "Dẫn ai đi đâu", note: "【Nhóm I】《連れて行く・連れて行って》", exJp: "カリナさんがお寺へ連れて行ってくれました。", exVi: "Chị Karina đã dẫn tôi đi thăm chùa."),
                    w(24, "連れて来ます", "つれてきます", "tsurete kimasu", "Dẫn ai đến", note: "【Nhóm III】《連れて来る・連れて来て》", exJp: "明日友達をうちへ連れて来ます。", exVi: "Ngày mai tôi sẽ dẫn bạn tới nhà chơi."),
                    w(24, "紹介します", "しょうかいします", "shoukai shimasu", "Giới thiệu", note: "【Nhóm III】《紹介する・紹介して》", exJp: "先生に日本の本を紹介してもらいました。", exVi: "Tôi đã được thầy giáo giới thiệu cho quyển sách Nhật."),
                    w(24, "説明します", "せつめいします", "setsumei shimasu", "Giải thích", note: "【Nhóm III】《説明する・説明して》", exJp: "先輩に使い方を説明してもらいました。", exVi: "Tôi đã được đàn anh giải thích cách sử dụng.")
                ]
            ),
            VocabLesson(
                lessonNumber: 25,
                title: "Suy nghĩ, Tiếp tục & Thu dọn",
                subtitle: "考えます, 続けます, 止めます, 入れます, 切ります, 片付けます...",
                partTag: p3,
                words: [
                    w(25, "考えます", "かんがえます", "kangaemasu", "Suy nghĩ, cân nhắc", note: "【Nhóm II】《考えます・考える・考えて》", exJp: "よく考えてから、決めます。", exVi: "Sau khi suy nghĩ kỹ tôi mới quyết định."),
                    w(25, "続けます", "つづけます", "tsuzukemasu", "Tiếp tục", note: "【Nhóm II】《続けます・続ける・続けて》", exJp: "疲れても、勉強を続けます。", exVi: "Dù mệt mỏi tôi vẫn tiếp tục học tập."),
                    w(25, "止めます", "やめます", "yamemasu", "Thôi, từ bỏ, nghỉ (việc)", note: "【Nhóm II】「仕事を・タバコを～」止めます", exJp: "健康のために、たばこを止めました。", exVi: "Vì sức khỏe, tôi đã bỏ thuốc lá."),
                    w(25, "入れます", "いれます", "iremasu", "Bật (công tắc)", note: "【Nhóm II】「スイッチを～」入れます", exJp: "寒くなったら、エアコンのスイッチを入れます。", exVi: "Nếu trời lạnh thì bật công tắc điều hòa lên."),
                    w(25, "切ります", "きります", "kirimasu", "Tắt, ngắt (điện, công tắc)", note: "【Nhóm I】「スイッチを～」切ります", exJp: "出かける前に電気を切ってください。", exVi: "Trước khi ra ngoài hãy tắt điện nhé."),
                    w(25, "片付けます", "かたづけます", "katazukemasu", "Dọn dẹp, sắp xếp gọn gàng", note: "【Nhóm II】《片付ける・片付けて》", exJp: "ご飯を食べたら、机を片付けます。", exVi: "Sau khi ăn cơm xong thì dọn dẹp bàn.")
                ]
            )
        ]
    }

    // MARK: - Phần 3: Bài 26 - 30 (N4)
    private static func buildVocabLessons26To30() -> [VocabLesson] {
        let p3 = partTags[2]
        return [
            VocabLesson(
                lessonNumber: 26,
                title: "Đúng giờ, Kiểm tra & Sự cố thường nhật",
                subtitle: "遅れます, 間に合います, やります, 付きます, 消えます, 開きます...",
                partTag: p3,
                words: [
                    w(26, "遅れます", "おくれます", "okuremasu", "Muộn, trễ giờ", note: "【Nhóm II】「時間・会議に～」遅れます", exJp: "バスが来なくて、会議に遅れたんです。", exVi: "Vì xe buýt không đến nên tôi bị muộn cuộc họp."),
                    w(26, "間に合います", "まにあいます", "maniaimasu", "Kịp giờ, đúng giờ", note: "【Nhóm I】「電車・時間に～」間に合います", exJp: "走ったら、電車に間に合いました。", exVi: "Nhờ chạy nhanh nên tôi đã kịp chuyến tàu."),
                    w(26, nil, "やります", "yarimasu", "Làm, chơi, thực hiện (thân mật của します)", note: "【Nhóm I】《やります・やる・やって》", exJp: "週末は友達とサッカーをやるんです。", exVi: "Cuối tuần tớ sẽ đá bóng cùng bạn đấy."),
                    w(26, "付きます", "つきます", "tsukimasu", "Bật sáng (đèn), được bật (điều hòa)", note: "【Nhóm I】「電気が～」付きます (Tự động từ)", exJp: "隣の部屋の電気が付いています。", exVi: "Đèn phòng bên cạnh đang sáng."),
                    w(26, "消えます", "きえます", "kiemasu", "Tắt (đèn), biến mất", note: "【Nhóm II】「電気が～」消えます (Tự động từ)", exJp: "電気が消えているので、誰もいないようです。", exVi: "Vì đèn đang tắt nên hình như không có ai."),
                    w(26, "開きます", "あきます", "akimasu", "Mở ra (tự động từ)", note: "【Nhóm I】「ドアが～」開きます", exJp: "このドアは自動で開きます。", exVi: "Cánh cửa này tự động mở ra.")
                ]
            ),
            VocabLesson(
                lessonNumber: 27,
                title: "Khả năng, Giác quan & Xây dựng hoàn thành",
                subtitle: "見えます, 聞こえます, できます, 打ちます, 建てます, 飼います...",
                partTag: p3,
                words: [
                    w(27, "見えます", "みえます", "miemasu", "Nhìn thấy (tự nhiên lọt vào mắt)", note: "【Nhóm II】「富士山が～」見えます", exJp: "天気がいい日は海から島が見えます。", exVi: "Ngày đẹp trời có thể nhìn thấy đảo từ biển."),
                    w(27, "聞こえます", "きこえます", "kikoemasu", "Nghe thấy (tự nhiên lọt vào tai)", note: "【Nhóm II】「音楽が～」聞こえます", exJp: "隣の部屋からピアノの音が聞こえます。", exVi: "Từ phòng bên cạnh nghe thấy tiếng đàn piano."),
                    w(27, nil, "できます", "dekimasu", "Hoàn thành, xây xong, làm xong", note: "【Nhóm II】「駅前にスーパーが～」できます", exJp: "学校の近くに新しい図書館ができました。", exVi: "Gần trường vừa xây xong thư viện mới."),
                    w(27, "打ちます", "うちます", "uchimasu", "Đánh, gõ (bàn phím), bấm", note: "【Nhóm I】《打ちます・打つ・打って》", exJp: "パソコンで日本語が打てますか。", exVi: "Bạn có thể gõ tiếng Nhật trên máy tính không?"),
                    w(27, "飼います", "かいます", "kaimasu", "Nuôi (thú cưng, động vật)", note: "【Nhóm I】「犬を～」飼います", exJp: "私の家では猫を二匹飼っています。", exVi: "Nhà tôi đang nuôi 2 con mèo."),
                    w(27, "操作します", "そうさします", "sousa shimasu", "Thao tác, điều khiển (máy móc)", note: "【Nhóm III】《操作する・操作して》", exJp: "この機械はスマホで操作できます。", exVi: "Chiếc máy này có thể điều khiển bằng điện thoại.")
                ]
            ),
            VocabLesson(
                lessonNumber: 28,
                title: "Lựa chọn, Ghi chép & Tính cách",
                subtitle: "選びます, 取ります(メモを), 頼みます, 咲きます, 真面目な, 優しい...",
                partTag: p3,
                words: [
                    w(28, "選びます", "えらびます", "erabimasu", "Lựa chọn, chọn lọc", note: "【Nhóm I】《選びます・選ぶ・選んで》", exJp: "母の誕生日にプレゼントを選びながら歩きました。", exVi: "Tôi vừa đi dạo vừa chọn quà sinh nhật cho mẹ."),
                    w(28, "取ります", "とります", "torimasu", "Ghi chép", note: "【Nhóm I】「メモを～」取ります", exJp: "先生の話を聞きながらメモを取ります。", exVi: "Vừa nghe thầy giảng vừa ghi chép lại."),
                    w(28, "頼みます", "たのみます", "tanomimasu", "Nhờ cậy, yêu cầu", note: "【Nhóm I】《頼みます・頼む・頼んで》", exJp: "先輩にチェックを頼みました。", exVi: "Tôi đã nhờ đàn anh kiểm tra giúp."),
                    w(28, "咲きます", "さきます", "sakimasu", "Nở (hoa)", note: "【Nhóm I】「桜の花が～」咲きます", exJp: "春になると、桜がきれいに咲きます。", exVi: "Hễ sang xuân là hoa anh đào nở rất đẹp."),
                    w(28, "真面目「な」", "まじめ「な」", "majime na", "Nghiêm túc, chăm chỉ", note: "【Tính từ な】", exJp: "彼は真面目だし、よく働くし、みんなに好かれています。", exVi: "Anh ấy vừa nghiêm túc lại chăm làm việc nên được mọi người quý."),
                    w(28, "優しい", "やさしい", "yasashii", "Dịu dàng, hiền lành, tốt bụng", note: "【Tính từ い】", exJp: "あの先生はとても優しい人です。", exVi: "Thầy giáo kia là người rất hiền lành tốt bụng.")
                ]
            ),
            VocabLesson(
                lessonNumber: 29,
                title: "Tự động từ chỉ trạng thái & Hư hỏng",
                subtitle: "込みます, 空きます, 壊れます, 割れます, 折れます, 破れます...",
                partTag: p3,
                words: [
                    w(29, "込みます", "こみます", "komimasu", "Đông đúc, chật chội", note: "【Nhóm I】「道・電車が～」込みます", exJp: "朝はいつも電車が込んでいます。", exVi: "Buổi sáng tàu điện lúc nào cũng đông nghịt."),
                    w(29, "空きます", "すきます", "sukimasu", "Vắng, thoáng", note: "【Nhóm I】「道・電車が～」空きます", exJp: "昼ごろはレストランが空いています。", exVi: "Khoảng trưa thì nhà hàng vắng thoáng."),
                    w(29, "壊れます", "こわれます", "kowaremasu", "Hỏng, bị hư (máy móc, đồ đạc)", note: "【Nhóm II】「パソコンが～」壊れます (Tự động từ)", exJp: "パソコンが壊れてしまいました。", exVi: "Máy tính bị hỏng mất tiêu rồi."),
                    w(29, "割れます", "われます", "waremasu", "Vỡ, bị vỡ (thủy tinh, đĩa, kính)", note: "【Nhóm II】「コップが～」割れます", exJp: "ガラスのコップが割れていますよ。", exVi: "Cái cốc thủy tinh bị vỡ rồi kìa."),
                    w(29, "折れます", "おれます", "oremasu", "Gãy, bị gãy (cây, xương, bút chì)", note: "【Nhóm II】「木・骨が～」折れます", exJp: "強い風で木の枝が折れました。", exVi: "Gió mạnh làm cành cây bị gãy rồi."),
                    w(29, "破れます", "やぶれます", "yaburemasu", "Rách, bị rách (giấy, túi, quần áo)", note: "【Nhóm II】「紙・服が～」破れます", exJp: "ポケットが破れてしまいました。", exVi: "Túi áo bị rách mất rồi.")
                ]
            ),
            VocabLesson(
                lessonNumber: 30,
                title: "Chuẩn bị, Sắp xếp & Tha động từ",
                subtitle: "貼ります, 掛けます, 並べます, しまいます, 拭きます, 準備します...",
                partTag: p3,
                words: [
                    w(30, "貼ります", "はります", "harimasu", "Dán (tranh, tem, ghi chú)", note: "【Nhóm I】《貼ります・貼る・貼って》", exJp: "壁に地図が貼ってあります。", exVi: "Trên tường có dán sẵn một tấm bản đồ."),
                    w(30, "掛けます", "かけます", "kakemasu", "Treo (tranh, lịch, đồng hồ)", note: "【Nhóm II】《掛けます・掛ける・掛けて》", exJp: "教室の前に時計が掛けてあります。", exVi: "Phía trước lớp học có treo sẵn đồng hồ."),
                    w(30, "並べます", "ならべます", "narabemasu", "Bày biện, xếp hàng ngay ngắn", note: "【Nhóm II】《並べます・並べる・並べて》", exJp: "机の上にお皿を並べておきました。", exVi: "Tôi đã xếp sẵn đĩa ra trên bàn rồi."),
                    w(30, nil, "しまいます", "shimaimasu", "Cất vào (ngăn kéo, tủ)", note: "【Nhóm I】《しまいます・しまう・しまって》", exJp: "使ったはさみは引き出しにしまっておきます。", exVi: "Cái kéo dùng xong sẽ cất vào ngăn kéo."),
                    w(30, "拭きます", "ふきます", "fukimasu", "Lau chùi, lau khô", note: "【Nhóm I】《拭きます・拭く・拭いて》", exJp: "お客さんが来る前にテーブルを拭いておきます。", exVi: "Trước khi khách tới tôi lau bàn trước."),
                    w(30, "準備します", "じゅんびします", "junbi shimasu", "Chuẩn bị", note: "【Nhóm III】《準備する・準備して》", exJp: "旅行の前に荷物を準備しておきます。", exVi: "Trước chuyến đi tôi chuẩn bị sẵn hành lý.")
                ]
            )
        ]
    }

    // MARK: - Phần 4: Bài 31 - 35 (N4)
    private static func buildVocabLessons31To35() -> [VocabLesson] {
        let p4 = partTags[3]
        return [
            VocabLesson(
                lessonNumber: 31,
                title: "Kế hoạch, Quyết định & Bốn mùa",
                subtitle: "決めます, まとめます, 建てます, 出ます(大学を), 相談します, 予定...",
                partTag: p4,
                words: [
                    w(31, "決めます", "きめます", "kimemasu", "Quyết định", note: "【Nhóm II】《決めます・決める・決めて》", exJp: "まだ結婚するかどうか決めていません。", exVi: "Tôi vẫn chưa quyết định xem có kết hôn hay không."),
                    w(31, nil, "まとめます", "matomemasu", "Tóm tắt, tổng hợp lại", note: "【Nhóm II】《まとめる・まとめて》", exJp: "会議の前に資料をまとめておきます。", exVi: "Trước cuộc họp tôi tổng hợp sẵn tài liệu."),
                    w(31, "建てます", "たてます", "tatemasu", "Xây dựng (nhà, trường, tòa nhà)", note: "【Nhóm II】《建てます・建てる・建てて》", exJp: "来年ふるさとへ帰って、家を建てようと思います。", exVi: "Sang năm tôi định về quê xây nhà."),
                    w(31, "出ます", "でます", "demasu", "Tốt nghiệp (đại học) / Rời khỏi", note: "【Nhóm II】「大学を～」出ます (trợ từ を)", exJp: "来年大学を出たら、日本で就職したいです。", exVi: "Sang năm sau khi tốt nghiệp đại học, tôi muốn xin việc ở Nhật."),
                    w(31, "相談します", "そうだんします", "soudan shimasu", "Trao đổi, bàn bạc, tư vấn", note: "【Nhóm III】《相談する・相談して》", exJp: "将来のことについて先生に相談しようと思います。", exVi: "Tôi định sẽ trao đổi với thầy về chuyện tương lai."),
                    w(31, "予定", "よてい", "yotei", "Dự định, lịch trình dự kiến", note: "「Nの / Vる 予定です」", exJp: "来週北海道へ出張する予定です。", exVi: "Tuần sau tôi dự kiến đi công tác Hokkaido.")
                ]
            ),
            VocabLesson(
                lessonNumber: 32,
                title: "Thời tiết & Sức khỏe y tế",
                subtitle: "晴れます, 止みます, 入ります(おふろ), 計ります, 熱, インフルエンザ...",
                partTag: p4,
                words: [
                    w(32, "晴れます", "はれます", "haremasu", "Trời nắng, quang đãng", note: "【Nhóm II】《晴れます・晴れる・晴れて》", exJp: "午後は晴れるでしょう。", exVi: "Buổi chiều có lẽ trời sẽ nắng."),
                    w(32, "止みます", "やみます", "yamimasu", "Tạnh (mưa), ngừng (gió)", note: "【Nhóm I】「雨が・風が～」止みます", exJp: "夕方には雨が止むかもしれません。", exVi: "Biết đâu chừng đến chiều tối mưa sẽ tạnh."),
                    w(32, "計ります", "はかります", "hakarimasu", "Đo (nhiệt độ, kích thước), cân", note: "【Nhóm I】《計る・計って》", exJp: "熱があるようなので、体温を計ります。", exVi: "Hình như bị sốt nên tôi đo nhiệt độ cơ thể."),
                    w(32, nil, "つけます", "tsukemasu", "Bôi, thoa (thuốc mỡ)", note: "【Nhóm II】「薬を～」つけます", exJp: "この薬をつけて、よく休んだほうがいいです。", exVi: "Bạn nên bôi thuốc này và nghỉ ngơi kỹ nhé."),
                    w(32, "上がります", "あがります", "agarimasu", "Tăng lên, lên cao (sốt, giá)", note: "【Nhóm I】「熱が～」上がります", exJp: "昨日より熱が上がりました。", exVi: "Sốt cao hơn hôm qua rồi."),
                    w(32, "下がります", "さがります", "sagarimasu", "Giảm xuống, hạ xuống", note: "【Nhóm I】「熱が～」下がります", exJp: "薬を飲んだら、熱が下がりました。", exVi: "Sau khi uống thuốc thì cơn sốt đã hạ.")
                ]
            ),
            VocabLesson(
                lessonNumber: 33,
                title: "Quy định, Giao thông & Truyền tin",
                subtitle: "守ります, 走ります, 運びます, 確かめます, 知らせます, 邪魔「な」...",
                partTag: p4,
                words: [
                    w(33, "守ります", "まもります", "mamorimasu", "Tuân thủ, chấp hành, bảo vệ", note: "【Nhóm I】「規則を～」守ります", exJp: "交通規則をきちんと守りなさい。", exVi: "Hãy tuân thủ nghiêm chỉnh luật giao thông."),
                    w(33, "走ります", "はしります", "hashirimasu", "Chạy", note: "【Nhóm I】「道を～」走ります (dùng を)", exJp: "公園の中を走るのが好きです。", exVi: "Tôi thích chạy bộ trong công viên."),
                    w(33, "運びます", "はこびます", "hakobimasu", "Vận chuyển, khuân vác", note: "【Nhóm I】《運びます・運ぶ・運んで》", exJp: "この荷物を会議室へ運んでください。", exVi: "Hãy chuyển hành lý này vào phòng họp."),
                    w(33, "確かめます", "たしかめます", "tashikamemasu", "Xác nhận, kiểm tra lại cho chắc", note: "【Nhóm II】《確かめる・確かめて》", exJp: "出発する前に時間を確かめてください。", exVi: "Trước khi xuất phát hãy xác nhận lại giờ giấc."),
                    w(33, "知らせます", "しらせます", "shirasemasu", "Thông báo, báo tin cho biết", note: "【Nhóm II】《知らせます・知らせる・知らせて》", exJp: "変更があったら、みんなに知らせてください。", exVi: "Nếu có thay đổi hãy thông báo cho mọi người biết."),
                    w(33, "邪魔「な」", "じゃま「な」", "jama na", "Vướng víu, cản trở, làm phiền", note: "【Tính từ な】「お邪魔します」", exJp: "ここは人の邪魔になりますよ。", exVi: "Chỗ này sẽ gây cản trở cho mọi người đấy.")
                ]
            ),
            VocabLesson(
                lessonNumber: 34,
                title: "Thao tác kỹ thuật & Trình tự hướng dẫn",
                subtitle: "組み立てます, 取り付けます, 締めます, 緩めます, 違います, 順序...",
                partTag: p4,
                words: [
                    w(34, "組み立てます", "くみたてます", "kumitatemasu", "Lắp ráp", note: "【Nhóm II】《組み立てる・組み立てて》", exJp: "説明書のとおりに棚を組み立てました。", exVi: "Tôi đã lắp ráp cái kệ đúng theo sách hướng dẫn."),
                    w(34, "取り付けます", "とりつけます", "toritsukemasu", "Lắp đặt, gắn vào", note: "【Nhóm II】《取り付ける・取り付けて》", exJp: "この部品をここに取り付けてください。", exVi: "Hãy gắn linh kiện này vào đây."),
                    w(34, "締めます", "しめます", "shimemasu", "Vặn chặt, siết chặt, thắt", note: "【Nhóm II】《締める・締めて》", exJp: "ねじをきつく締めてから使います。", exVi: "Sau khi vặn chặt ốc vít rồi mới dùng."),
                    w(34, "緩めます", "ゆるめます", "yurumemasu", "Nới lỏng, tháo lỏng ra", note: "【Nhóm II】《緩める・緩めて》", exJp: "このねじを少し緩めてください。", exVi: "Hãy nới lỏng con ốc này ra một chút."),
                    w(34, "違います", "ちがいます", "chigaimasu", "Sai, khác biệt", note: "【Nhóm I】「順序が～」違います", exJp: "やり方の順序が違っていますよ。", exVi: "Trình tự cách làm bị sai rồi đấy."),
                    w(34, "順序", "じゅんじょ", "junjo", "Thứ tự, trình tự", note: "Danh từ", exJp: "番号の順序どおりに並べてください。", exVi: "Hãy xếp đúng theo trình tự các con số.")
                ]
            ),
            VocabLesson(
                lessonNumber: 35,
                title: "Mua sắm, Đặt trước & Điều kiện sản phẩm",
                subtitle: "付きます, 売れます, 予約します, 配達します, 無理「な」, 電池...",
                partTag: p4,
                words: [
                    w(35, "付きます", "つきます", "tsukimasu", "Kèm theo, đính kèm", note: "【Nhóm I】「リモコンが～」付きます", exJp: "このテレビにはリモコンが付いています。", exVi: "Chiếc tivi này có đi kèm điều khiển từ xa."),
                    w(35, "売れます", "うれます", "uremasu", "Bán chạy (hàng hóa)", note: "【Nhóm II】「本がよく～」売れます", exJp: "新製品は値段が安ければよく売れます。", exVi: "Sản phẩm mới nếu giá rẻ thì sẽ bán chạy."),
                    w(35, "予約します", "よやくします", "yoyaku shimasu", "Đặt trước, đặt chỗ", note: "【Nhóm III】《予約する・予約して》", exJp: "旅行の前にホテルを予約しておきます。", exVi: "Trước chuyến đi tôi đặt phòng khách sạn trước."),
                    w(35, "配達します", "はいたつします", "haitatsu shimasu", "Giao hàng, phân phát tận nơi", note: "【Nhóm III】《配達する・配達して》", exJp: "重い荷物は家まで配達してくれます。", exVi: "Đồ nặng họ sẽ giao hàng tận nhà cho mình."),
                    w(35, "無理「な」", "むり「な」", "muri na", "Vô lý, quá sức, không thể", note: "【Tính từ な】「無理を しない」", exJp: "体に無理な仕事はしないほうがいいです。", exVi: "Không nên làm những công việc quá sức cơ thể."),
                    w(35, "電池", "でんち", "denchi", "Pin", note: "「電池が 切れる」", exJp: "時計が動きません。電池が切れたようです。", exVi: "Đồng hồ không chạy. Hình như hết pin rồi.")
                ]
            )
        ]
    }

    // MARK: - Phần 4: Bài 36 - 40 (N4)
    private static func buildVocabLessons36To40() -> [VocabLesson] {
        let p4 = partTags[3]
        return [
            VocabLesson(
                lessonNumber: 36,
                title: "Thích nghi, Phát biểu & Đời sống",
                subtitle: "慣れます, 落ちます, 掛けます, 発表します, 貯金します, 大きな...",
                partTag: p4,
                words: [
                    w(36, "慣れます", "なれます", "naremasu", "Quen, thích nghi", note: "【Nhóm II】「生活に～」慣れます", exJp: "日本の生活にやっと慣れました。", exVi: "Cuối cùng tôi cũng đã quen với cuộc sống ở Nhật."),
                    w(36, "落ちます", "おちます", "ochimasu", "Rơi xuống, rớt xuống", note: "【Nhóm II】「荷物が～」落ちます (Tự động từ)", exJp: "荷物が落ちないように、ひもを結びます。", exVi: "Để hành lý không bị rơi xuống, tôi buộc chặt dây."),
                    w(36, "掛けます", "かけます", "kakemasu", "Phủ lên, che lên", note: "【Nhóm II】「カバーを～」掛けます", exJp: "ほこりが付かないようにカバーを掛けます。", exVi: "Tôi phủ tấm che lên để không bị bám bụi."),
                    w(36, "発表します", "はっぴょうします", "happyou shimasu", "Phát biểu, công bố, thuyết trình", note: "【Nhóm III】《発表する・発表して》", exJp: "みんなの前で日本語で発表できるように練習します。", exVi: "Tôi luyện tập để có thể phát biểu bằng tiếng Nhật trước mọi người."),
                    w(36, "貯金します", "ちょきんします", "chokin shimasu", "Gửi tiết kiệm, để dành tiền", note: "【Nhóm III】《貯金する・貯金して》", exJp: "毎月給料から少しずつ貯金するようにしています。", exVi: "Hàng tháng tôi cố gắng tiết kiệm từng chút từ tiền lương."),
                    w(36, "大きな", "おおきな", "ookina", "To, lớn (chỉ dùng trước danh từ)", note: "Liên thể từ (bổ nghĩa trực tiếp danh từ)", exJp: "大きな声ではっきり話してください。", exVi: "Hãy nói rõ ràng bằng giọng to nhé.")
                ]
            ),
            VocabLesson(
                lessonNumber: 37,
                title: "Khen chê, Sản xuất & Giao thương",
                subtitle: "褒めます, 叱ります, 壊します, 生産します, 検査します, 輸出します...",
                partTag: p4,
                words: [
                    w(37, "褒めます", "ほめます", "homemasu", "Khen, tán dương", note: "【Nhóm II】《褒めます・褒める・褒めて》", exJp: "テストでいい点を取って、先生に褒められました。", exVi: "Được điểm cao bài kiểm tra nên tôi được thầy giáo khen."),
                    w(37, "叱ります", "しかります", "shikarimasu", "Mắng, quở trách", note: "【Nhóm I】《叱ります・叱る・叱って》", exJp: "宿題を忘れて、先生に叱られました。", exVi: "Quên làm bài tập nên tôi bị thầy mắng."),
                    w(37, "壊します", "こわします", "kowashimasu", "Làm hỏng, phá vỡ (tha động từ)", note: "【Nhóm I】《壊します・壊す・壊して》", exJp: "弟に私のパソコンを壊されました。", exVi: "Tôi bị em trai làm hỏng mất máy tính."),
                    w(37, "生産します", "せいさんします", "seisan shimasu", "Sản xuất", note: "【Nhóm III】《生産する・生産して》", exJp: "この工場では自動車が生産されています。", exVi: "Ở nhà máy này ô tô đang được sản xuất."),
                    w(37, "検査します", "けんさします", "kensa shimasu", "Kiểm tra (chất lượng, y tế)", note: "【Nhóm III】《検査する・検査して》", exJp: "出荷の前に品質が厳しく検査されます。", exVi: "Trước khi xuất xưởng, chất lượng được kiểm tra nghiêm ngặt."),
                    w(37, "輸出します", "ゆしゅつします", "yushutsu shimasu", "Xuất khẩu", note: "【Nhóm III】Trái nghĩa: 輸入します (nhập khẩu)", exJp: "日本の車は世界中に輸出されています。", exVi: "Ô tô Nhật Bản được xuất khẩu đi khắp thế giới.")
                ]
            ),
            VocabLesson(
                lessonNumber: 38,
                title: "Đời sống công sở & Thao tác hằng ngày",
                subtitle: "通います, 残業します, 計算します, 集めます, 渡します, 生まれます...",
                partTag: p4,
                words: [
                    w(38, "通います", "かよいます", "kayoimasu", "Đi lại thường xuyên (đi làm/đi học)", note: "【Nhóm I】「会社に・学校に～」通います", exJp: "会社へ自転車で通うのは健康にいいです。", exVi: "Việc đi làm công ty bằng xe đạp rất tốt cho sức khỏe."),
                    w(38, "残業します", "ざんぎょうします", "zangyou shimasu", "Làm thêm giờ, tăng ca", note: "【Nhóm III】《残業する・残業して》", exJp: "毎日遅くまで残業するのは大変です。", exVi: "Việc ngày nào cũng tăng ca đến muộn thật vất vả."),
                    w(38, "計算します", "けいさんします", "keisan shimasu", "Tính toán", note: "【Nhóm III】《計算する・計算して》", exJp: "パソコンを使うと、計算するのが速いです。", exVi: "Dùng máy tính thì việc tính toán rất nhanh."),
                    w(38, "集めます", "あつめます", "atsumemasu", "Sưu tầm, thu thập, tập hợp", note: "【Nhóm II】《集めます・集める・集めて》", exJp: "私の趣味は古い切手を集めることです。", exVi: "Sở thích của tôi là sưu tầm tem cũ."),
                    w(38, "渡します", "わたします", "watashimasu", "Trao cho, đưa cho, nộp tận tay", note: "【Nhóm I】《渡します・渡す・渡して》", exJp: "友達に本を渡すのを忘れました。", exVi: "Tôi quên mất việc đưa quyển sách cho bạn."),
                    w(38, "生まれます", "うまれます", "umaremasu", "Sinh ra, ra đời", note: "【Nhóm II】《生まれます・生まれる・生まれて》", exJp: "私が生まれたのはベトナムのハノイです。", exVi: "Nơi tôi sinh ra là Hà Nội, Việt Nam.")
                ]
            ),
            VocabLesson(
                lessonNumber: 39,
                title: "Cảm xúc & Tai nạn thiên tai",
                subtitle: "思い出します, 安心します, びっくりします, 焼けます, 倒れます, 複雑な...",
                partTag: p4,
                words: [
                    w(39, "思い出します", "おもいだします", "omoidashimasu", "Nhớ lại, hồi tưởng", note: "【Nhóm I】《思い出す・思い出して》", exJp: "写真を見て、家族のことを思い出しました。", exVi: "Nhìn bức ảnh mà tôi nhớ lại gia đình."),
                    w(39, "安心します", "あんしんします", "anshin shimasu", "An tâm, nhẹ nhõm", note: "【Nhóm III】《安心する・安心して》", exJp: "家族の声を聞いて、安心しました。", exVi: "Nghe thấy giọng của gia đình nên tôi yên tâm hẳn."),
                    w(39, nil, "びっくりします", "bikkuri shimasu", "Giật mình, ngạc nhiên", note: "【Nhóm III】《びっくりする・びっくりして》", exJp: "大きな音を聞いて、びっくりしました。", exVi: "Nghe thấy tiếng động lớn làm tôi giật cả mình."),
                    w(39, "焼けます", "やけます", "yakemasu", "Bị cháy (nhà), nướng chín", note: "【Nhóm II】「家が～」焼けます (Tự động từ)", exJp: "火事で古い家が焼けてしまいました。", exVi: "Vì hỏa hoạn nên ngôi nhà cũ đã bị cháy rụi."),
                    w(39, "倒れます", "たおれます", "taoremasu", "Đổ xuống, sụp đổ, ngã", note: "【Nhóm II】「木・ビルが～」倒れます", exJp: "台風で大きな木が倒れました。", exVi: "Vì bão nên cái cây to đã bị đổ."),
                    w(39, "複雑「な」", "ふくざつ「な」", "fukuzatsu na", "Phức tạp, rắc rối", note: "【Tính từ な】Trái nghĩa: 簡単な", exJp: "手続きが複雑なので、よく分かりません。", exVi: "Vì thủ tục phức tạp nên tôi không hiểu rõ lắm.")
                ]
            ),
            VocabLesson(
                lessonNumber: 40,
                title: "Đo đếm, Tìm kiếm & Kiểm chứng",
                subtitle: "数えます, 足ります, 残ります, 合います, 探します, 見つけます...",
                partTag: p4,
                words: [
                    w(40, "数えます", "かぞえます", "kazoemasu", "Đếm (số lượng)", note: "【Nhóm II】《数えます・数える・数えて》", exJp: "お皿が何枚あるか数えてみてください。", exVi: "Hãy thử đếm xem có bao nhiêu cái đĩa."),
                    w(40, "足ります", "たります", "tarimasu", "Đủ (số lượng, tiền, thời gian)", note: "【Nhóm II】《足ります・足りる・足りて》", exJp: "お金が足りるかどうか心配です。", exVi: "Tôi lo không biết tiền có đủ hay không."),
                    w(40, "残ります", "のこります", "nokorimasu", "Còn lại, sót lại, ở lại", note: "【Nhóm I】《残ります・残る・残って》", exJp: "料理がたくさん残ってしまいました。", exVi: "Đồ ăn bị thừa lại nhiều quá."),
                    w(40, "合います", "あいます", "aimasu", "Vừa vặn, hợp (kích cỡ, ý kiến)", note: "【Nhóm I】「サイズが～」合います", exJp: "この靴はサイズが合うかどうか履いてみます。", exVi: "Tôi đi thử xem đôi giày này có vừa cỡ không."),
                    w(40, "探します", "さがします", "sagashimasu", "Tìm kiếm (đang đi tìm)", note: "【Nhóm I】《探します・探す・探して》", exJp: "駅の近くで安いアパートを探しています。", exVi: "Tôi đang tìm căn hộ rẻ ở gần nhà ga."),
                    w(40, "見つけます", "みつけます", "mitsukemasu", "Tìm thấy, phát hiện ra (chủ ý)", note: "【Nhóm II】《見つける・見つけて》", exJp: "やっとなくした財布を見つけました。", exVi: "Cuối cùng tôi cũng đã tìm thấy chiếc ví bị mất.")
                ]
            )
        ]
    }

    // MARK: - Phần 5: Bài 41 - 45 (N4)
    private static func buildVocabLessons41To45() -> [VocabLesson] {
        let p5 = partTags[4]
        return [
            VocabLesson(
                lessonNumber: 41,
                title: "Xã giao Cho - Nhận & Gia đình",
                subtitle: "頂きます, 下さいます, やります, 招待します, 丁寧「な」, お礼...",
                partTag: p5,
                words: [
                    w(41, "頂きます", "いただきます", "itadakimasu", "Nhận (khiêm tốn ngữ của もらいます)", note: "【Nhóm I】《頂きます・頂く・頂いて》", exJp: "社長に素敵な時計を頂きました。", exVi: "Tôi đã nhận được chiếc đồng hồ tuyệt đẹp từ giám đốc."),
                    w(41, "下さいます", "くださいます", "kudasaimasu", "Cho (tôn kính ngữ của くれます)", note: "【Nhóm I】《下さいます・下さる・下さって》", exJp: "部長が資料をチェックしてくださいました。", exVi: "Trưởng phòng đã kiểm tra giúp tôi tài liệu."),
                    w(41, nil, "やります", "yarimasu", "Cho (người ít tuổi, động vật, cây)", note: "【Nhóm I】《やります・やる・やって》", exJp: "毎朝庭の花に水をやります。", exVi: "Sáng nào tôi cũng tưới nước cho hoa trong vườn."),
                    w(41, "招待します", "しょうたいします", "shoutai shimasu", "Mời (tiệc, cưới, về nhà)", note: "【Nhóm III】《招待する・招待して》", exJp: "友達の結婚式に招待されました。", exVi: "Tôi đã được mời tới dự lễ cưới của bạn."),
                    w(41, "丁寧「な」", "ていねい「な」", "teinei na", "Lịch sự, lễ phép, cẩn thận tỉ mỉ", note: "【Tính từ な】", exJp: "日本の店員はとても丁寧に説明してくれます。", exVi: "Nhân viên cửa hàng Nhật giải thích rất lịch sự và tỉ mỉ."),
                    w(41, "珍しい", "めずらしい", "mezurashii", "Hiếm, lạ, độc đáo", note: "【Tính từ い】", exJp: "国のお土産に珍しいお菓子を頂きました。", exVi: "Tôi nhận được món bánh kẹo độc lạ làm quà quê hương.")
                ]
            ),
            VocabLesson(
                lessonNumber: 42,
                title: "Chế tạo, Đăng ký & Mục đích sử dụng",
                subtitle: "貯めます, 外します, 混ぜます, 参加します, 申し込みます, 必要「な」...",
                partTag: p5,
                words: [
                    w(42, "貯めます", "ためます", "tamemasu", "Dành dụm, tích trữ (tiền)", note: "【Nhóm II】《貯めます・貯める・貯めて》", exJp: "自分の店を開くために、お金を貯めています。", exVi: "Tôi đang tích góp tiền để mở cửa hàng của riêng mình."),
                    w(42, "外します", "はずします", "hazushimasu", "Tháo ra, gỡ bỏ ra", note: "【Nhóm I】《外します・外す・外して》", exJp: "ねじを外すのにドライバーが必要です。", exVi: "Để tháo ốc vít ra thì cần có tua vít."),
                    w(42, "混ぜます", "まぜます", "mazemasu", "Trộn lẫn, pha trộn", note: "【Nhóm II】《混ぜます・混ぜる・混ぜて》", exJp: "材料をよく混ぜるために、大きいボウルを使います。", exVi: "Để trộn đều nguyên liệu tôi dùng cái tô lớn."),
                    w(42, "参加します", "さんかします", "sanka shimasu", "Tham gia (hội thảo, sự kiện)", note: "【Nhóm III】「パーティーに～」参加します", exJp: "ボランティア活動に参加することにしました。", exVi: "Tôi đã quyết định tham gia hoạt động tình nguyện."),
                    w(42, "申し込みます", "もうしこみます", "moushikomimasu", "Đăng ký, nộp đơn", note: "【Nhóm I】《申し込む・申し込んで》", exJp: "インターネットで試験を申し込みます。", exVi: "Tôi đăng ký kỳ thi qua mạng Internet."),
                    w(42, "必要「な」", "ひつよう「な」", "hitsuyou na", "Cần thiết", note: "【Tính từ な】", exJp: "料理を作るのに何時間ぐらい必要ですか。", exVi: "Để làm món ăn đó cần khoảng mấy tiếng?")
                ]
            ),
            VocabLesson(
                lessonNumber: 43,
                title: "Dấu hiệu trực quan & Gửi gắm",
                subtitle: "無くなります, 預けます, 丈夫「な」, 素晴らしい, 思い出, ガソリン...",
                partTag: p5,
                words: [
                    w(43, "無くなります", "なくなります", "nakunarimasu", "Hết, cạn, mất đi (xăng, tiền)", note: "【Nhóm I】「ガソリンが～」無くなります", exJp: "途中でガソリンが無くなりそうです。", exVi: "Chắc giữa đường sắp hết xăng mất rồi."),
                    w(43, "預けます", "あずけます", "azukemasu", "Gửi giữ hộ (tiền ngân hàng, hành lý)", note: "【Nhóm II】「コインロッカーに～」預けます", exJp: "荷物をロッカーに預けて来ます。", exVi: "Tôi đi gửi hành lý vào tủ đồ rồi quay lại ngay."),
                    w(43, "丈夫「な」", "じょうぶ「な」", "joubu na", "Bền chắc, khỏe mạnh", note: "【Tính từ な】", exJp: "この靴は軽くて、丈夫そうですね。", exVi: "Đôi giày này trông vừa nhẹ vừa bền chắc nhỉ."),
                    w(43, "素晴らしい", "すばらしい", "subarashii", "Tuyệt vời, xuất sắc", note: "【Tính từ い】", exJp: "富士山は本当に素晴らしい景色ですね。", exVi: "Núi Phú Sĩ quả thực là phong cảnh tuyệt vời nhỉ."),
                    w(43, "思い出", "おもいで", "omoide", "Kỷ niệm, ký ức", note: "Danh từ", exJp: "日本での生活は楽しい思い出ばかりです。", exVi: "Cuộc sống ở Nhật toàn là những kỷ niệm vui."),
                    w(43, nil, "ガソリン", "gasorin", "Xăng (nhiên liệu)", note: "Danh từ Katakana", exJp: "ガソリンを入れて来ましょう。", exVi: "Chúng ta đi đổ xăng rồi quay lại nhé.")
                ]
            ),
            VocabLesson(
                lessonNumber: 44,
                title: "Trạng thái thay đổi & Tính từ miêu tả chi tiết",
                subtitle: "変わります, やり直します, 太い, 細い, 厚い, 薄い...",
                partTag: p5,
                words: [
                    w(44, "変わります", "かわります", "kawarimasu", "Thay đổi, biến đổi (tự động từ)", note: "【Nhóm I】「色が・季節が～」変わります", exJp: "秋になると、葉の色が変わります。", exVi: "Hễ sang thu là màu lá cây thay đổi."),
                    w(44, "やり直します", "やりなおします", "yarinaoshimasu", "Làm lại từ đầu", note: "【Nhóm I】《やり直す・やり直して》", exJp: "間違えたので、最初からやり直します。", exVi: "Vì làm sai nên tôi sẽ làm lại từ đầu."),
                    w(44, "太い", "ふとい", "futoi", "To, béo, dày (ống, nét chữ)", note: "【Tính từ い】Trái nghĩa: 細い (thon nhỏ)", exJp: "このペンは線が太すぎて書きにくいです。", exVi: "Cây bút này nét to quá nên khó viết."),
                    w(44, "細い", "ほそい", "hosoi", "Thon, mảnh, gầy, hẹp", note: "【Tính từ い】", exJp: "この道は細くて歩きにくいです。", exVi: "Con đường này hẹp nên khó đi bộ."),
                    w(44, "厚い", "あつい", "atsui", "Dày (sách, áo, tường)", note: "【Tính từ い】Trái nghĩa: 薄い (mỏng)", exJp: "辞書が厚すぎて、持ちにくいです。", exVi: "Cuốn từ điển dày quá nên khó cầm."),
                    w(44, "濃い", "こい", "koi", "Đậm đặc (vị trà, màu sắc)", note: "【Tính từ い】Trái nghĩa: 薄い (nhạt)", exJp: "このコーヒーは苦くて濃すぎます。", exVi: "Cà phê này đắng và đặc quá mức.")
                ]
            ),
            VocabLesson(
                lessonNumber: 45,
                title: "Tình huống khẩn cấp & Biến cố",
                subtitle: "起きます(sự cố), 逃げます, 始まります, 過ぎます, 迷います, 信じます...",
                partTag: p5,
                words: [
                    w(45, "起きます", "おきます", "okimasu", "Xảy ra (tai nạn, động đất)", note: "【Nhóm II】「地震・事故が～」起きます", exJp: "地震が起きた場合は、机の下に入ってください。", exVi: "Trong trường hợp xảy ra động đất, hãy chui xuống gầm bàn."),
                    w(45, "逃げます", "にげます", "nigemasu", "Chạy trốn, chạy thoát thân", note: "【Nhóm II】《逃げます・逃げる・逃げて》", exJp: "火事のときはすぐ外へ逃げてください。", exVi: "Khi có hỏa hoạn hãy lập tức chạy thoát ra ngoài."),
                    w(45, "始まります", "はじまります", "hajimarimasu", "Bắt đầu (tự động từ)", note: "【Nhóm I】「会議が～」始まります", exJp: "もうすぐ映画が始まるのに、友達がまだ来ません。", exVi: "Sắp chiếu phim rồi mà bạn vẫn chưa tới."),
                    w(45, "過ぎます", "すぎます", "sugimasu", "Quá, trôi qua (thời gian/giới hạn)", note: "【Nhóm II】《過ぎます・過ぎる・過ぎて》", exJp: "約束の時間を過ぎたのに、連絡がありません。", exVi: "Quá giờ hẹn rồi mà vẫn không thấy liên lạc gì."),
                    w(45, "迷います", "まよいます", "mayoimasu", "Lạc đường / Do dự, phân vân", note: "【Nhóm I】「道に～」迷います", exJp: "道に迷った場合は、地図を見てください。", exVi: "Trong trường hợp bị lạc đường, hãy xem bản đồ."),
                    w(45, "信じます", "しんじます", "shinjimasu", "Tin, tin tưởng", note: "【Nhóm II】《信じます・信じる・信じて》", exJp: "約束したのに、信じてくれませんでした。", exVi: "Tôi đã hứa thế mà anh ấy vẫn không tin tôi.")
                ]
            )
        ]
    }

    // MARK: - Phần 5: Bài 46 - 50 (N4)
    private static func buildVocabLessons46To50() -> [VocabLesson] {
        let p5 = partTags[4]
        return [
            VocabLesson(
                lessonNumber: 46,
                title: "Khởi hành, Tìm thấy & Trạng thái vừa mới",
                subtitle: "出ます(khởi hành), 見つかります, 濡れます, 乾きます, 塗ります, 入ります...",
                partTag: p5,
                words: [
                    w(46, "出ます", "でます", "demasu", "Khởi hành, rời bến (tàu xe)", note: "【Nhóm II】「電車が～」出ます", exJp: "電車は今出たところです。", exVi: "Tàu điện vừa mới khởi hành tức thì xong."),
                    w(46, "見つかります", "みつかります", "mitsukarimasu", "Được tìm thấy, tìm ra (tự động từ)", note: "【Nhóm I】「かぎが～」見つかります", exJp: "なくした財布がやっと見つかりました。", exVi: "Chiếc ví bị mất cuối cùng cũng đã tìm thấy rồi."),
                    w(46, "濡れます", "ぬれます", "nuremasu", "Bị ướt, thấm ướt", note: "【Nhóm II】《濡れます・濡れる・濡れて》", exJp: "雨に降られて、服が濡れてしまいました。", exVi: "Bị mắc mưa nên quần áo ướt hết cả rồi."),
                    w(46, "乾きます", "かわきます", "kawakimasu", "Khô, khô ráo (tự động từ)", note: "【Nhóm I】《乾きます・乾く・乾いて》", exJp: "風が強いから、洗濯物はすぐ乾くはずです。", exVi: "Vì gió mạnh nên đồ giặt chắc chắn sẽ khô nhanh thôi."),
                    w(46, "塗ります", "ぬります", "nurimasu", "Sơn, phết, quét (bơ, sơn, thuốc)", note: "【Nhóm I】《塗ります・塗る・塗って》", exJp: "さっき壁を塗ったばかりですから、触らないでください。", exVi: "Vì vừa mới sơn tường xong nên đừng chạm vào nhé."),
                    w(46, "入ります", "はいります", "hairimasu", "Vào (công ty, trường, đại học)", note: "【Nhóm I】「会社・大学に～」入ります", exJp: "去年この会社に入ったばかりです。", exVi: "Tôi mới vừa vào công ty này hồi năm ngoái.")
                ]
            ),
            VocabLesson(
                lessonNumber: 47,
                title: "Tin tức, Sức khỏe & Tự nhiên",
                subtitle: "吹きます, 伸びます, 入院します, 集まります, 天気予報, 婚約します...",
                partTag: p5,
                words: [
                    w(47, "吹きます", "ふきます", "fukimasu", "Thổi (gió)", note: "【Nhóm I】「風が～」吹きます", exJp: "今夜は強い風が吹くそうです。", exVi: "Nghe nói tối nay sẽ có gió mạnh thổi."),
                    w(47, "伸びます", "のびます", "nobimasu", "Kéo dài thêm (thời hạn, thực tập)", note: "【Nhóm II】「じっしゅうが～」伸びます", exJp: "実習が一週間伸びるかもしれません。", exVi: "Có lẽ đợt thực tập sẽ kéo dài thêm 1 tuần."),
                    w(47, "入院します", "にゅういんします", "nyuuin shimasu", "Nhập viện, nằm viện", note: "【Nhóm III】Trái nghĩa: 退院します (xuất viện)", exJp: "友達が病気で入院したそうです。", exVi: "Nghe nói bạn tôi bị ốm phải nhập viện rồi."),
                    w(47, "集まります", "あつまります", "atsumarimasu", "Tập trung, tụ họp (tự động từ)", note: "【Nhóm I】《集まります・集まる・集まって》", exJp: "教室に学生が集まっているようです。", exVi: "Hình như học sinh đang tập trung trong lớp học."),
                    w(47, "天気予報", "てんきよほう", "tenkiyohou", "Dự báo thời tiết", note: "「天気予報に よると」", exJp: "天気予報によると、明日は晴れるそうです。", exVi: "Theo dự báo thời tiết thì nghe nói mai trời nắng."),
                    w(47, nil, "ノックします", "nokku shimasu", "Gõ cửa", note: "【Nhóm III】《ノックする・ノックして》", exJp: "部屋に入る前にドアをノックします。", exVi: "Trước khi vào phòng thì gõ cửa.")
                ]
            ),
            VocabLesson(
                lessonNumber: 48,
                title: "Thể Sai khiến & Sinh hoạt giáo dục",
                subtitle: "出席します, 届けます, 歴史, 文化, 塾, 自由に...",
                partTag: p5,
                words: [
                    w(48, "出席します", "しゅっせきします", "shusseki shimasu", "Tham dự, có mặt (hội nghị/lớp)", note: "【Nhóm III】「会議に～」出席します", exJp: "来月の会議にぜひ出席させてください。", exVi: "Xin hãy cho phép tôi tham dự cuộc họp tháng sau."),
                    w(48, "届けます", "とどけます", "todokemasu", "Gửi đến, giao tận tay", note: "【Nhóm II】《届けます・届ける・届けて》", exJp: "部下に資料をお客様へ届けさせました。", exVi: "Tôi đã bảo nhân viên dưới quyền giao tài liệu đến khách hàng."),
                    w(48, "歴史", "れきし", "rekishi", "Lịch sử", note: "Danh từ", exJp: "娘に日本の歴史を勉強させたいです。", exVi: "Tôi muốn cho con gái học lịch sử Nhật Bản."),
                    w(48, "文化", "ぶんか", "bunka", "Văn hóa", note: "Danh từ", exJp: "日本の文化に興味を持っています。", exVi: "Tôi có hứng thú với văn hóa Nhật Bản."),
                    w(48, "塾", "じゅく", "juku", "Trường học thêm, lớp luyện thi", note: "Danh từ", exJp: "日本の小学生はよく塾に通っています。", exVi: "Học sinh tiểu học Nhật thường đi học thêm."),
                    w(48, "自由に", "じゆうに", "jiyuu ni", "Một cách tự do, thoải mái", note: "Phó từ (tính từ な: 自由な)", exJp: "先生は学生に自由に発表させました。", exVi: "Thầy giáo cho phép học sinh tự do thuyết trình.")
                ]
            ),
            VocabLesson(
                lessonNumber: 49,
                title: "Tôn kính ngữ (そんけいご)",
                subtitle: "いらっしゃいます, 召し上がります, おっしゃいます, なさいます, ご覧になります, ご存知です...",
                partTag: p5,
                words: [
                    w(49, nil, "いらっしゃいます", "irasshaimasu", "Đi / Đến / Ở (Tôn kính ngữ của いきます・きます・います)", note: "【Nhóm I đặc biệt】《いらっしゃる・いらっしゃって》", exJp: "先生は今会議室にいらっしゃいます。", exVi: "Thầy giáo hiện đang ở trong phòng họp ạ."),
                    w(49, "召し上がります", "めしあがります", "meshiagarimasu", "Ăn / Uống (Tôn kính ngữ của たべます・のみます)", note: "【Nhóm I】《召し上がる・召し上がって》", exJp: "どうぞ温かいお茶を召し上がってください。", exVi: "Xin mời ngài dùng trà nóng ạ."),
                    w(49, nil, "おっしゃいます", "osshaimasu", "Nói (Tôn kính ngữ của いいます)", note: "【Nhóm I đặc biệt】《おっしゃる・おっしゃって》", exJp: "社長がおっしゃったとおりに準備します。", exVi: "Tôi sẽ chuẩn bị đúng như lời giám đốc đã nói."),
                    w(49, nil, "なさいます", "nasaimasu", "Làm (Tôn kính ngữ của します)", note: "【Nhóm I đặc biệt】《なさる・なさって》", exJp: "お休みの日はいつも何をなさいますか。", exVi: "Vào ngày nghỉ ngài thường làm gì vậy ạ?"),
                    w(49, "ご覧になります", "ごらんになります", "goran ni narimasu", "Xem, nhìn (Tôn kính ngữ của みます)", note: "【Nhóm I】《ご覧になる・ご覧になって》", exJp: "こちらの新しい資料をご覧になりましたか。", exVi: "Ngài đã xem qua tài liệu mới này chưa ạ?"),
                    w(49, "ご存知です", "ごぞんじです", "gozonji desu", "Biết (Tôn kính ngữ của しっています)", note: "Dạng phủ định lịch sự: ご存知ありません", exJp: "田中部長をご存知ですか。", exVi: "Ngài có biết Trưởng phòng Tanaka không ạ?")
                ]
            ),
            VocabLesson(
                lessonNumber: 50,
                title: "Khiêm tốn ngữ (けんじょうご) & Lịch sự ngữ",
                subtitle: "参ります, おります, 申します, 致します, 拝見します, お目にかかります...",
                partTag: p5,
                words: [
                    w(50, "参ります", "まいります", "mairimasu", "Đi / Đến (Khiêm tốn ngữ của いきます・きます)", note: "【Nhóm I】《参ります・参る・参って》", exJp: "ベトナムから参りましたグエンと申します。", exVi: "Tôi tên là Nguyễn, từ Việt Nam tới ạ."),
                    w(50, "おります", "おります", "orimasu", "Ở (Khiêm tốn ngữ của います)", note: "【Nhóm I】《おります・おる・おって》", exJp: "私は毎日夕方まで会社におります。", exVi: "Tôi có mặt ở công ty hàng ngày đến chiều tối ạ."),
                    w(50, "申します", "もうします", "moushimasu", "Nói, tự xưng tên là (Khiêm tốn ngữ của いいます)", note: "【Nhóm I】《申します・申す・申して》", exJp: "IMCのアンと申します。よろしくお願いします。", exVi: "Tôi tên là An của công ty IMC. Mong được giúp đỡ ạ."),
                    w(50, "致します", "いたします", "itashimasu", "Làm (Khiêm tốn ngữ của します)", note: "【Nhóm I】《致します・致す・致して》", exJp: "お荷物は私がお持ち致します。", exVi: "Hành lý đó xin để tôi mang giúp ngài ạ."),
                    w(50, "拝見します", "はいけんします", "haiken shimasu", "Xem, đọc, nhìn (Khiêm tốn ngữ của みます)", note: "【Nhóm III】《拝見する・拝見して》", exJp: "先生の本を拝見しました。", exVi: "Tôi đã được đọc qua quyển sách của thầy ạ."),
                    w(50, "お目にかかります", "おめにかかります", "ome ni kakarimasu", "Gặp gỡ, diện kiến (Khiêm tốn ngữ của あいます)", note: "【Nhóm I】《お目にかかる・お目にかかって》", exJp: "またお目にかかれる日を楽しみにしております。", exVi: "Tôi rất mong chờ ngày được diện kiến ngài lần nữa ạ.")
                ]
            )
        ]
    }
}
