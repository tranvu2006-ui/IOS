# App Học Tiếng Nhật N5 (iOS)

Ứng dụng học tiếng Nhật dành cho hệ điều hành iOS, tập trung vào phương pháp ghi nhớ qua **Flashcard lật thẻ 3D** và **Luyện nghe trắc nghiệm âm thanh (Listening Quiz)** với giọng đọc chuẩn Nhật Bản (`ja-JP`).

## 🌟 Tính năng chính

### 1. Bảng chữ cái cơ bản (Hiragana & Katakana)
- Đầy đủ 46 ký tự Hiragana và 46 ký tự Katakana.
- Kèm theo phiên âm Romaji, từ vựng ví dụ thực tế và giải nghĩa tiếng Việt.
- Chế độ **Flashcard 3D**: Lật thẻ xem nghĩa, tự động phát âm khi chuyển thẻ, vuốt trái/phải.
- Chế độ **Luyện nghe (Audio Quiz)**: Nghe phát âm và chọn 1 trong 4 đáp án đúng, phản hồi trực quan xanh/đỏ và rung xúc giác (Haptic Feedback).

### 2. Hán tự Kanji N5 (漢字)
- Tuyển chọn các chữ Hán căn bản nhất trong cấp độ JLPT N5.
- Cung cấp: **Âm Hán Việt** (dễ nhớ cho người Việt), Âm On, Âm Kun, Số nét, và các từ ghép thông dụng.
- Luyện nghe từ vựng Kanji và chọn chữ Hán tương ứng.

### 3. Từ vựng N5 theo Chủ đề
- Phân loại theo 5 chủ đề giao tiếp:
  - 💬 Chào hỏi & Giao tiếp (Aisatsu)
  - 👨‍👩‍👧 Gia đình & Bản thân (Kazoku)
  - ⏰ Thời gian & Lịch trình (Jikan)
  - 🍜 Ẩm thực & Nhà hàng (Tabemono)
  - 🚆 Đi lại & Phương tiện (Norimono)
- Kèm câu ví dụ mẫu trong ngữ cảnh và audio phát âm câu ví dụ.

### 4. Quản lý Tiến độ học tập
- Đánh dấu từ đã thuộc (nút sao ⭐).
- Theo dõi chuỗi ngày học liên tục (Streak 🔥).
- Thống kê tỷ lệ phần trăm chính xác khi luyện nghe (🎯 Accuracy).

## 🛠 Yêu cầu kỹ thuật
- **Ngôn ngữ**: Swift 5+
- **Nền tảng**: iOS 15.0+
- **Frameworks**: `UIKit`, `AVFoundation` (Speech Synthesis & Audio Session)
- **Công cụ phát triển**: Xcode 15/16+

## 🚀 Hướng dẫn cài đặt & Chạy ứng dụng
1. Clone repository về máy:
   ```bash
   git clone https://github.com/tranvu2006-ui/IOS.git
   ```
2. Mở file `AppHocTiengNhat.xcodeproj` bằng **Xcode**.
3. Chọn thiết bị mô phỏng (ví dụ: iPhone 15 / iPhone 16) và nhấn `Cmd + R` để chạy.
