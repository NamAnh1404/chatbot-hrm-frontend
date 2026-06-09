# Module Đánh Giá Năng Lực Nhân Sự Tích Hợp Agentic AI

## 1. Mục đích của module

Module **Đánh giá năng lực** được xây dựng để hỗ trợ bộ phận nhân sự theo dõi, phân tích và đánh giá năng lực làm việc của nhân viên trong hệ thống HRM.

Module này không chỉ hiển thị thông tin nhân viên, mà còn tổng hợp dữ liệu từ nhiều nghiệp vụ nhân sự như:

- Hồ sơ nhân viên
- Chấm công
- Task/công việc do Manager giao
- Tiến độ và deadline task
- Kết quả review task của Manager
- Kỹ năng chuyên môn
- Kỷ luật lao động

Từ các dữ liệu đó, hệ thống tính điểm năng lực, xếp loại nhân viên và đưa ra nhận xét/đề xuất theo hướng Agentic AI.

Điểm cập nhật quan trọng: hiệu suất không nên do AI tự suy đoán. Hiệu suất nên lấy từ **task do Manager giao**, sau đó nhân viên cập nhật tiến độ và Manager review/chấm chất lượng.

## 2. Vai trò trong đề tài

Tên đề tài:

**Xây dựng hệ thống quản trị nhân sự tích hợp Agentic AI đánh giá năng lực**

Trong đề tài này, module **Đánh giá năng lực** là phần thể hiện rõ yếu tố AI/Agentic AI.

Hệ thống HRM thông thường chỉ quản lý dữ liệu như nhân viên, lương, nghỉ phép, chấm công. Khi tích hợp Agentic AI, hệ thống có thêm khả năng:

- Phân tích dữ liệu nhân sự
- Tự tính toán điểm năng lực
- Xếp loại nhân viên
- Đưa ra nhận xét tự động
- Gợi ý hướng đào tạo, khen thưởng hoặc theo dõi thêm

Theo hướng nghiệp vụ mới, Agentic AI không hoạt động độc lập. AI cần dữ liệu từ Manager và Employee:

- Manager giao task, deadline, độ ưu tiên.
- Employee cập nhật tiến độ.
- Manager review task, chấm chất lượng.
- AI tổng hợp task với chấm công và nghỉ phép để đánh giá năng lực.

## 3. Các chức năng chính

### 3.1. Hiển thị danh sách đánh giá năng lực

Hệ thống hiển thị bảng đánh giá năng lực của nhân viên theo tháng/năm.

Các thông tin gồm:

- Tên nhân viên
- Phòng ban
- Chức vụ
- Điểm chuyên cần
- Điểm hiệu suất
- Điểm kỹ năng
- Điểm kỷ luật
- Tổng điểm năng lực
- Xếp loại
- Nhận xét AI

### 3.2. Tính điểm năng lực nhân viên

Mỗi nhân viên được đánh giá dựa trên 4 nhóm điểm:

| Nhóm điểm | Ý nghĩa |
|---|---|
| Chuyên cần | Đánh giá mức độ đi làm đầy đủ, đúng giờ |
| Hiệu suất task | Đánh giá khả năng hoàn thành task được Manager giao |
| Kỹ năng/chất lượng | Đánh giá chất lượng đầu ra qua điểm review của Manager |
| Kỷ luật/trách nhiệm | Đánh giá mức độ tuân thủ deadline, cập nhật tiến độ và quy định làm việc |

### 3.3. Xếp loại năng lực

Sau khi tính tổng điểm, hệ thống xếp loại nhân viên:

| Tổng điểm | Xếp loại |
|---|---|
| Từ 90 trở lên | Xuất sắc |
| Từ 80 đến 89 | Tốt |
| Từ 65 đến 79 | Trung bình |
| Dưới 65 | Cần cải thiện |

### 3.4. AI nhận xét điểm mạnh

Hệ thống tự phân tích điểm số để xác định điểm mạnh của nhân viên.

Ví dụ:

- Chuyên cần ổn định
- Hiệu suất làm việc tốt
- Kỹ năng phù hợp với vị trí
- Kỷ luật làm việc tốt

### 3.5. AI đề xuất cải thiện

Nếu nhân viên có điểm thấp ở một nhóm nào đó, hệ thống sẽ đưa ra gợi ý cải thiện.

Ví dụ:

- Nếu điểm chuyên cần thấp: cần cải thiện việc đi làm đúng giờ
- Nếu điểm hiệu suất task thấp: cần theo dõi tiến độ task, hỗ trợ xử lý công việc
- Nếu điểm kỹ năng/chất lượng thấp: cần đào tạo chuyên môn hoặc mentoring
- Nếu điểm kỷ luật/trách nhiệm thấp: cần cải thiện việc cập nhật tiến độ, tuân thủ deadline và chấm công

### 3.6. AI đề xuất hành động nhân sự

Agentic AI đưa ra khuyến nghị cho HR:

- Nhân viên xuất sắc: đề xuất khen thưởng hoặc giao nhiệm vụ quan trọng
- Nhân viên tốt: đề xuất duy trì và đào tạo nâng cao
- Nhân viên trung bình: đề xuất theo dõi thêm
- Nhân viên cần cải thiện: đề xuất trao đổi trực tiếp và lập kế hoạch cải thiện

### 3.7. Tìm kiếm và lọc

Giao diện hỗ trợ:

- Tìm kiếm theo tên nhân viên
- Tìm kiếm theo phòng ban
- Tìm kiếm theo chức vụ
- Lọc theo xếp loại năng lực

### 3.8. Xem chi tiết nhận xét AI

Khi HR bấm nút **AI đánh giá**, hệ thống hiển thị:

- Tổng điểm
- Xếp loại
- Điểm mạnh
- Điểm cần cải thiện
- Đề xuất Agentic AI

## 4. Công dụng của module

Module này giúp HR:

- Không cần đánh giá nhân viên hoàn toàn thủ công
- Có cái nhìn tổng quan về năng lực nhân sự
- Phát hiện nhân viên nổi bật
- Phát hiện nhân viên cần hỗ trợ
- Có dữ liệu để đề xuất đào tạo
- Có cơ sở để xét thưởng, tăng lương hoặc điều chuyển
- Tăng tính minh bạch trong quản trị nhân sự

Đối với nhân viên, module giúp:

- Biết mình đang được đánh giá theo tiêu chí nào
- Nhìn thấy điểm mạnh và điểm cần cải thiện
- Có định hướng phát triển rõ hơn

## 5. Cách hoạt động tổng quan

Luồng hoạt động tổng quát theo hướng Manager giao task:

```text
Manager giao task
    |
    |-- Chọn nhân viên
    |-- Nhập task, deadline, độ ưu tiên
    |
    v
Employee nhận task và cập nhật tiến độ
    |
    |-- Cập nhật phần trăm hoàn thành
    |-- Gửi hoàn thành
    |
    v
Manager review task
    |
    |-- Duyệt hoàn thành
    |-- Yêu cầu sửa
    |-- Chấm chất lượng task
    |
    v
Dữ liệu HRM liên quan
    |
    |-- Hồ sơ nhân viên
    |-- Dữ liệu chấm công
    |-- Dữ liệu nghỉ phép
    |-- Phòng ban, chức vụ
    |
    v
Agentic AI xử lý đánh giá năng lực
    |
    |-- Tính điểm chuyên cần
    |-- Tính điểm hiệu suất task
    |-- Tính điểm kỹ năng/chất lượng
    |-- Tính điểm kỷ luật/trách nhiệm
    |
    v
Tính tổng điểm năng lực
    |
    v
Xếp loại nhân viên
    |
    v
Agentic AI tạo nhận xét và đề xuất
    |
    v
Frontend hiển thị cho HR
```

Luồng cũ trong code hiện tại vẫn đang ở mức rule-based demo. Luồng mới này là định hướng nghiệp vụ đúng hơn để hệ thống có nguồn dữ liệu đánh giá rõ ràng.

## 6. Luồng hoạt động chi tiết

Các bước dưới đây mô tả hiện trạng module trong code. Phần mở rộng theo hướng Manager giao task được bổ sung sau đó để làm định hướng phát triển đúng nghiệp vụ hơn.

### Bước 1. HR mở màn hình Đánh giá năng lực

Người dùng truy cập module:

```text
Frontend -> Menu Đánh giá năng lực
```

Hoặc truy cập trực tiếp:

```text
http://localhost:3000/competency
```

### Bước 2. Frontend gọi API backend

Frontend gọi API:

```http
GET /api/admin/competency?month=...&year=...
GET /api/admin/competency/dashboard?month=...&year=...
```

Mục đích:

- Lấy danh sách điểm năng lực
- Lấy số liệu tổng quan
- Lấy top nhân viên có điểm cao

### Bước 3. Backend lấy dữ liệu từ database

Backend lấy dữ liệu từ các bảng:

```text
employees
departments
positions
attendance
```

Dữ liệu nhân viên dùng để biết:

- Nhân viên là ai
- Thuộc phòng ban nào
- Giữ chức vụ gì
- Trạng thái còn làm việc hay không

Dữ liệu chấm công trong DB thật hiện nằm ở bảng `attendance` với các cột chính:

- `attendance_id`
- `employee_id`
- `work_date`
- `check_in`
- `check_out`

Từ dữ liệu này hệ thống có thể biết:

- Nhân viên có bản ghi chấm công trong tháng hay không
- Nhân viên có giờ check-in/check-out hay không
- Có thể suy luận đi trễ/về sớm nếu bổ sung logic so sánh giờ
- Tổng số ngày có bản ghi chấm công trong tháng

Các cột như `is_late`, `is_early_leave`, `status`, `total_hours` hiện chưa có trong DB thật CDIO4. Backend đã tạm bỏ map các cột này để tránh lỗi schema. Nếu muốn đánh giá chuyên cần/kỷ luật chính xác hơn, nên bổ sung các cột này hoặc tính trực tiếp từ `check_in/check_out`.

### Bước 4. Backend tính điểm chuyên cần

Điểm chuyên cần được tính dựa vào dữ liệu chấm công.

Logic hiện tại:

```text
Nếu không có dữ liệu chấm công -> điểm mặc định 75
Nếu có dữ liệu:
    điểm = 100
    trừ điểm nếu đi trễ
    trừ điểm nếu về sớm
    trừ điểm nếu ngày công chưa hoàn thành
```

Ví dụ:

```text
Điểm chuyên cần = 100 - số lần đi trễ * 4 - số lần về sớm * 3
```

### Bước 5. Backend tính điểm hiệu suất

Điểm hiệu suất hiện tại là điểm mô phỏng theo dữ liệu nhân viên và điểm chuyên cần.

Logic demo:

```text
Điểm nền = 78 đến 93
Nếu chuyên cần cao -> cộng điểm
Nếu chuyên cần thấp -> trừ điểm
```

Trong phiên bản nâng cấp theo hướng Manager giao task, điểm hiệu suất nên lấy từ:

- Task do Manager giao
- Số task hoàn thành
- Tỷ lệ task đúng hạn
- Phần trăm tiến độ
- Task được Manager duyệt
- Đánh giá của quản lý

Công thức đề xuất:

```text
TaskPerformanceScore =
    tỷ lệ task hoàn thành * 50%
  + điểm đúng hạn * 30%
  + điểm cập nhật tiến độ * 20%
```

### Bước 6. Backend tính điểm kỹ năng

Điểm kỹ năng được tính dựa trên chức vụ và phòng ban.

Ví dụ:

```text
Nhân viên IT, Developer, DevOps, QA -> cộng điểm kỹ năng chuyên môn
Nhân viên Manager, Team Lead -> cộng điểm kỹ năng quản lý
Nhân viên HR -> cộng điểm kỹ năng nghiệp vụ nhân sự
Nhân viên Sales/Marketing -> cộng điểm kỹ năng theo nghiệp vụ
```

Trong phiên bản nâng cấp, điểm kỹ năng/chất lượng có thể lấy từ:

- Điểm chất lượng task do Manager chấm
- Nhận xét Manager sau khi review task
- Bài test nội bộ
- Chứng chỉ
- Khóa đào tạo đã hoàn thành

Công thức đề xuất:

```text
QualitySkillScore = trung bình quality_score của các task đã review
```

### Bước 7. Backend tính điểm kỷ luật

Điểm kỷ luật phản ánh mức độ tuân thủ quy định làm việc.

Logic hiện tại:

```text
Nếu không có dữ liệu -> điểm mặc định 80
Nếu có dữ liệu:
    điểm = 96
    trừ điểm theo số lần đi trễ, về sớm hoặc ngày công chưa hoàn thành
```

Theo hướng Manager giao task, điểm kỷ luật/trách nhiệm cần tính thêm:

```text
Task quá hạn
Task không cập nhật tiến độ
Task bị từ chối hoàn thành
Lỗi chấm công
```

Nếu nhân viên có nghỉ phép đã duyệt trong thời gian làm task, hệ thống không nên phạt deadline quá nặng.

### Bước 8. Backend tính tổng điểm năng lực

Tổng điểm được tính theo trọng số:

```text
Tổng điểm =
    Chuyên cần * 30%
  + Hiệu suất * 35%
  + Kỹ năng * 20%
  + Kỷ luật * 15%
```

Ví dụ:

```text
Chuyên cần: 90
Hiệu suất: 85
Kỹ năng: 80
Kỷ luật: 95

Tổng điểm = 90*0.3 + 85*0.35 + 80*0.2 + 95*0.15 = 87
```

Theo hướng mới, công thức đề xuất là:

```text
Tổng điểm =
    Chuyên cần * 20%
  + Hiệu suất task * 40%
  + Kỹ năng/chất lượng * 25%
  + Kỷ luật/trách nhiệm * 15%
```

### Bước 9. Backend xếp loại nhân viên

Sau khi có tổng điểm, backend phân loại:

```text
>= 90       -> Xuất sắc
80 - 89    -> Tốt
65 - 79    -> Trung bình
< 65       -> Cần cải thiện
```

### Bước 10. Agentic AI tạo nhận xét

Hệ thống tạo 3 nhóm nội dung:

```text
1. Điểm mạnh
2. Điểm cần cải thiện
3. Đề xuất hành động
```

Ví dụ:

```text
Nhân viên Nguyễn Văn A có năng lực tốt và ổn định.
Điểm mạnh: chuyên cần ổn định, hiệu suất làm việc tốt.
Cần cải thiện: bổ sung kỹ năng chuyên môn.
Đề xuất: tham gia khóa đào tạo nội bộ trong tháng tới.
```

### Bước 11. Frontend hiển thị kết quả

Frontend nhận dữ liệu từ backend và hiển thị:

- Thẻ thống kê tổng quan
- Bảng điểm năng lực
- Thanh điểm trực quan
- Xếp loại bằng badge màu
- Khung nhận xét AI
- Danh sách top nhân viên

### Bước 12. HR bấm AI đánh giá

Khi HR bấm nút **AI đánh giá**, frontend gọi API:

```http
GET /api/admin/competency/{employeeId}/analyze?month=...&year=...
```

Backend trả về phân tích chi tiết của nhân viên đó.

Frontend hiển thị:

- Tổng điểm
- Xếp loại
- Điểm mạnh
- Điểm cần cải thiện
- Đề xuất Agentic AI

### Luồng mở rộng theo hướng Manager giao task

```text
1. Manager mở màn Nhân viên phòng ban.
2. Manager chọn một nhân viên và tạo task.
3. Manager nhập tên task, mô tả, deadline, độ ưu tiên và điểm KPI/task point.
4. Employee nhận thông báo task mới ở giao diện nhân viên.
5. Employee cập nhật tiến độ theo phần trăm và ghi chú công việc.
6. Employee gửi yêu cầu hoàn thành khi task đạt 100%.
7. Manager review task, chấm chất lượng và chọn duyệt/yêu cầu sửa/từ chối.
8. Agentic AI lấy dữ liệu task, chấm công, nghỉ phép, phòng ban và chức vụ.
9. AI tính điểm chuyên cần, hiệu suất task, kỹ năng/chất lượng, kỷ luật/trách nhiệm.
10. AI tạo nhận xét, điểm mạnh, điểm cần cải thiện và đề xuất hành động.
11. Manager/HR duyệt kết quả cuối cùng.
12. Hệ thống lưu lịch sử đánh giá.
```

Luồng này hợp lý hơn vì Manager có vai trò trực tiếp trong đánh giá, Employee không tự quyết định kết quả, còn AI có nguồn dữ liệu rõ ràng để phân tích.

## 7. API của module

### 7.1. Lấy danh sách đánh giá năng lực

```http
GET /api/admin/competency?month=6&year=2026
```

Trả về danh sách nhân viên kèm điểm năng lực.

### 7.2. Lấy dashboard đánh giá năng lực

```http
GET /api/admin/competency/dashboard?month=6&year=2026
```

Trả về:

- Tổng số nhân viên
- Điểm trung bình
- Số nhân viên xuất sắc
- Số nhân viên tốt
- Số nhân viên trung bình
- Số nhân viên cần cải thiện
- Top nhân viên có điểm cao

### 7.3. Phân tích chi tiết một nhân viên

```http
GET /api/admin/competency/1/analyze?month=6&year=2026
```

Trả về nhận xét AI chi tiết cho nhân viên có `employeeId = 1`.

### 7.4. API đề xuất cho hướng Manager giao task

Nếu triển khai theo luồng mới, cần bổ sung các nhóm API:

```http
GET    /api/manager/employees
GET    /api/manager/tasks
POST   /api/manager/tasks
PUT    /api/manager/tasks/{id}
POST   /api/manager/tasks/{id}/review
```

```http
GET    /api/employee/tasks
POST   /api/employee/tasks/{id}/progress
POST   /api/employee/tasks/{id}/submit
```

```http
GET    /api/manager/competency?startDate=...&endDate=...
GET    /api/manager/competency/{employeeId}/analyze?startDate=...&endDate=...
POST   /api/manager/competency/{employeeId}/approve
```

## 8. Các file đã triển khai

### Backend

```text
backend/Admin/DTOs/CompetencyDto.cs
backend/Admin/Services/CompetencyService.cs
backend/Admin/Controllers/CompetencyController.cs
backend/Admin/Controllers/ChatController.cs
backend/Admin/Program.cs
```

### Frontend

```text
frontend/services/competency.ts
frontend/app/components/CompetencyEvaluation.tsx
frontend/app/competency/page.tsx
frontend/app/components/Sidebar.tsx
frontend/app/components/Chatbot.tsx
frontend/app/employees/EmployeeSidebar.tsx
```

## 9. Mối liên hệ với AI Assistant

Chatbot cũ được đổi vai trò thành **AI Assistant**.

AI Assistant có thể trả lời các câu hỏi như:

```text
Đánh giá năng lực nhân viên
Agentic AI hoạt động như thế nào?
Cho tôi xem năng lực nhân viên
Nhân viên nào cần cải thiện?
```

Hiện tại AI Assistant đang trả lời theo rule/template. Trong phiên bản nâng cấp, AI Assistant có thể được phát triển thành agent thật:

```text
Người dùng hỏi
    |
AI Agent phân tích ý định
    |
AI Agent gọi API nhân viên/chấm công/lương/nghỉ phép/đánh giá năng lực
    |
AI Agent tổng hợp dữ liệu
    |
AI Agent trả về nhận xét và đề xuất
```

## 10. Điểm Agentic AI nằm ở đâu?

Yếu tố Agentic AI thể hiện ở việc hệ thống không chỉ trả lời tĩnh, mà có quy trình:

```text
Nhận mục tiêu: đánh giá năng lực nhân viên
    |
Thu thập dữ liệu HRM
    |
Phân tích từng tiêu chí
    |
Tính điểm và xếp loại
    |
Tạo nhận xét
    |
Đề xuất hành động cho HR
```

Trong bản hiện tại, Agentic AI được mô phỏng bằng rule-based logic để phù hợp demo đồ án.

Trong bản nâng cấp, có thể thay phần rule bằng mô hình AI thật như:

- OpenAI API
- LangChain
- Semantic Kernel
- AI Agent gọi nhiều API nội bộ

## 11. Kịch bản demo đề xuất

### Kịch bản 1. HR xem tổng quan năng lực

```text
1. HR đăng nhập hệ thống
2. HR chọn menu Đánh giá năng lực
3. Hệ thống hiển thị số nhân viên, điểm trung bình, số nhân viên tốt/xuất sắc
4. HR xem top nhân viên có điểm cao
```

### Kịch bản 2. HR phân tích một nhân viên

```text
1. HR tìm nhân viên Nguyễn Văn A
2. HR bấm AI đánh giá
3. Hệ thống hiển thị điểm chuyên cần, hiệu suất, kỹ năng, kỷ luật
4. AI đưa ra điểm mạnh, điểm cần cải thiện và đề xuất hành động
```

### Kịch bản 3. HR hỏi AI Assistant

```text
1. HR mở AI Assistant
2. HR nhập: "Đánh giá năng lực nhân viên"
3. AI Assistant giải thích module đánh giá năng lực
4. HR chuyển sang màn hình Đánh giá năng lực để xem chi tiết
```

## 12. Hướng phát triển tiếp theo

Module có thể mở rộng thêm:

- Lưu kết quả đánh giá vào database
- Thêm bảng `competency_reviews`
- Cho HR chỉnh trọng số điểm
- Cho quản lý nhập KPI thủ công
- Tích hợp OpenAI để sinh nhận xét tự nhiên hơn
- Cho nhân viên xem kết quả đánh giá của bản thân
- Xuất báo cáo PDF/Excel
- Theo dõi tiến bộ năng lực qua từng tháng

## 13. Kết luận

Module **Đánh giá năng lực** giúp hệ thống HRM chuyển từ quản lý dữ liệu đơn thuần sang hỗ trợ phân tích và ra quyết định nhân sự.

Module này là phần quan trọng để đề tài phù hợp với hướng:

**Hệ thống quản trị nhân sự tích hợp Agentic AI đánh giá năng lực**

Hệ thống có thể hỗ trợ HR đánh giá nhân viên nhanh hơn, có cơ sở dữ liệu hơn và đưa ra đề xuất phát triển nhân sự phù hợp hơn.
