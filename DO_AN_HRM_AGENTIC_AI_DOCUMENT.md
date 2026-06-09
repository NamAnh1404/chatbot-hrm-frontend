# Tài liệu phân tích đồ án HRM tích hợp AI

## 1. Tên đồ án đề xuất

Tên phù hợp với hiện trạng dự án:

**Xây dựng hệ thống quản trị nhân sự HRM tích hợp AI Chatbot hỗ trợ tra cứu và tư vấn nghiệp vụ nhân sự**

Nếu nhóm muốn nâng cấp đúng hướng Agentic AI, có thể dùng tên:

**Xây dựng hệ thống quản trị nhân sự thông minh tích hợp Agentic AI hỗ trợ phân tích và ra quyết định nhân sự**

Lưu ý: tên có "Agentic AI" chỉ thật sự phù hợp nếu hệ thống có thêm chức năng AI phân tích dữ liệu, đưa khuyến nghị, giải thích lý do và hỗ trợ HR ra quyết định.

## 2. Tổng quan đồ án hiện tại

Dự án hiện tại là một hệ thống quản trị nhân sự dạng web, gồm frontend React/Next.js và backend ASP.NET Core. Hệ thống đã có giao diện cho hai nhóm người dùng chính:

- Admin/HR Manager.
- Nhân viên.

Các chức năng chính hiện có ở frontend:

- Đăng nhập demo theo vai trò admin/employee.
- Dashboard tổng quan nhân sự.
- Quản lý nhân viên.
- Quản lý lương thưởng.
- Quản lý nghỉ phép.
- Chấm công và duyệt chấm công.
- Báo cáo, thống kê.
- Cổng nhân viên.
- Chatbot HR.

Sau khi gom lại, cấu trúc thư mục hiện tại:

```text
chatbot-hrm-react-typescript
├─ frontend
│  ├─ app
│  ├─ lib
│  ├─ public
│  ├─ services
│  ├─ package.json
│  └─ ...
└─ backend
   ├─ Admin
   │  ├─ Controllers
   │  ├─ Data
   │  ├─ DTOs
   │  ├─ Models
   │  ├─ Repositories
   │  ├─ Services
   │  ├─ Program.cs
   │  └─ Admin.csproj
   └─ Admin.slnx
```

## 3. Công nghệ sử dụng

### Frontend

- Next.js.
- React.
- TypeScript.
- Tailwind CSS.
- Radix UI/shadcn-style components.
- Lucide React icons.

### Backend

- ASP.NET Core Web API.
- .NET 8.
- Entity Framework Core.
- MySQL/Pomelo EntityFrameworkCore provider.
- JWT Authentication.
- Swagger/OpenAPI.

### AI/Chatbot

Frontend hiện có module AI Assistant/chatbot gọi API backend qua HTTP. Ngoài chatbot hỏi đáp theo rule, dự án đã bổ sung module **Đánh giá năng lực** để thể hiện phần AI phân tích dữ liệu nhân sự.

## 4. Đánh giá hiện trạng frontend

### Điểm tốt

Frontend đã dựng được giao diện khá đầy đủ cho một hệ thống HRM demo. Các màn hình chính có bố cục rõ ràng, có sidebar, navbar, dashboard, bảng dữ liệu, dialog và các trạng thái xử lý.

Các module đáng chú ý:

- `frontend/app/page.tsx`: điều phối luồng đăng nhập và hiển thị giao diện admin/employee.
- `frontend/app/components/Login.tsx`: giao diện đăng nhập demo.
- `frontend/app/components/Dashboard.tsx`: dashboard admin.
- `frontend/app/components/EmployeeTable.tsx`: quản lý nhân viên.
- `frontend/app/components/Salary.tsx`: quản lý lương.
- `frontend/app/components/Leave.tsx`: quản lý nghỉ phép.
- `frontend/app/components/AttendanceApproval.tsx`: duyệt chấm công.
- `frontend/app/components/Reports.tsx`: báo cáo.
- `frontend/app/components/Analytics.tsx`: thống kê.
- `frontend/app/components/Chatbot.tsx`: chatbot HR.
- `frontend/app/employees/*`: các màn hình dành cho nhân viên.

### Hạn chế

Frontend hiện vẫn mang tính demo nhiều hơn sản phẩm hoàn chỉnh:

- Một số module vẫn hard-code dữ liệu trong component.
- Module Quản lý nhân viên đã gọi API backend và đọc được database thật `chatbot_hrm`.
- Module Đánh giá năng lực đã gọi API backend, nhưng vẫn có fallback demo nếu API không có dữ liệu.
- Các thao tác thêm/sửa/xóa chủ yếu dùng `alert` và `confirm`.
- Đăng nhập đang dùng tài khoản demo hard-code.
- Một số route chưa hoàn thiện:
  - `frontend/app/salary/page.tsx` chỉ là bản nháp.
  - `frontend/app/leave/page.tsx` đang trống.
  - `frontend/app/login/page.tsx` đang trống.
- Một số component quá dài, khó bảo trì:
  - `AttendanceApproval.tsx`.
  - `Attendance.tsx`.
  - `Salary.tsx`.
- Có dấu hiệu trùng lặp component/dialog:
  - Một số dialog nằm ở `frontend/app/dialogs`.
  - Nhưng dashboard và module chính vẫn viết dialog trực tiếp trong component.
- Chưa có quản lý trạng thái tập trung.
- Chưa có test.
- README frontend vẫn là mẫu mặc định của Next.js.

## 5. Đánh giá hiện trạng backend

Backend được clone từ repository riêng và hiện đã đặt trong thư mục `backend`.

Project chính:

```text
backend/Admin/Admin.csproj
```

Backend sử dụng ASP.NET Core Web API, có các phần:

- Controllers.
- Services.
- Repositories.
- Models.
- DTOs.
- AppDbContext.
- JWT Authentication.
- Swagger.
- CORS cho frontend.

Các nhóm API có thể thấy qua controller:

- Auth.
- Employee.
- Attendance.
- Leave Request.
- Salary.
- Test/WeatherForecast.

Backend chạy mặc định:

```text
http://localhost:5297
```

### Điểm tốt

- Có cấu trúc backend tương đối rõ.
- Có phân lớp Controller, Service, Repository.
- Có JWT Authentication.
- Có Swagger để test API.
- Có cấu hình CORS cho frontend.
- Có Entity Framework Core kết nối MySQL.

### Hạn chế/rủi ro

- Frontend đang dùng `NEXT_PUBLIC_API_BASE_URL` hoặc mặc định `http://localhost:5297`.
- Backend đã đọc được database local `chatbot_hrm` cho module nhân viên, phòng ban và chức vụ.
- Schema DB thật khác schema thiết kế ban đầu, nên backend đã phải map:
  - `employee_id` thay cho `id`
  - `department_name` thay cho `name`
  - `position_name` thay cho `title`
- Một số cột UI mong muốn như `cccd`, `salary_base`, `role` chưa có trong bảng `employees`.
- Cần tiếp tục đồng bộ schema cho lương, nghỉ phép, chấm công và đăng nhập.
- File cấu hình thật không nên public khi nộp hoặc đẩy GitHub; nên dùng biến môi trường cho mật khẩu DB/JWT secret.

## 6. Hệ thống hiện tại nên được gọi là gì?

Với code hiện tại, tên phù hợp là:

**Hệ thống quản trị nhân sự tích hợp Agentic AI đánh giá năng lực**

Lý do: hệ thống đã có module Đánh giá năng lực tự lấy dữ liệu nhân viên/chấm công, tính điểm, xếp loại và sinh khuyến nghị cho HR. Tuy nhiên đây vẫn là **Agentic AI mô phỏng theo rule-based logic**, chưa phải AI Agent hoàn chỉnh dùng mô hình AI thật.

## 7. Agentic AI là gì?

Agentic AI là AI hoạt động như một tác nhân thông minh. Khác với chatbot thường chỉ hỏi đáp, Agentic AI có thể:

- Nhận mục tiêu từ người dùng.
- Tự chia nhỏ công việc.
- Gọi công cụ/API để lấy dữ liệu.
- Phân tích dữ liệu.
- Đưa ra đề xuất.
- Giải thích lý do đề xuất.
- Ghi lại lịch sử hành động.
- Chờ con người duyệt trước khi thực hiện quyết định quan trọng.

Ví dụ trong HRM:

Người dùng hỏi:

```text
Phân tích những nhân viên có nguy cơ nghỉ việc cao trong tháng này.
```

Một Agentic AI đúng nghĩa sẽ:

1. Lấy dữ liệu chấm công.
2. Lấy dữ liệu nghỉ phép.
3. Lấy dữ liệu hiệu suất.
4. Lấy lịch sử lương/thưởng nếu có.
5. So sánh xu hướng.
6. Phát hiện bất thường.
7. Đưa danh sách nhân viên rủi ro.
8. Giải thích lý do.
9. Đề xuất HR nên trao đổi, tăng phúc lợi, đào tạo hoặc theo dõi thêm.

## 8. Nếu áp dụng Agentic AI vào đồ án này thì thay đổi gì?

Đồ án sẽ chuyển từ:

```text
HRM + chatbot hỏi đáp
```

thành:

```text
HRM thông minh + AI Agent hỗ trợ phân tích và ra quyết định nhân sự
```

Các thay đổi chính:

### 8.1. Chatbot trở thành AI Agent

Chatbot không chỉ trả lời câu hỏi, mà có thể tra dữ liệu và phân tích.

Ví dụ:

- "Nhân viên nào nghỉ phép nhiều bất thường?"
- "Phòng ban nào có tỷ lệ đi trễ cao?"
- "Ai nên được đề xuất thưởng tháng này?"
- "Đơn nghỉ phép này có nên duyệt không?"

### 8.2. Dashboard có AI Insights

Dashboard nên có thêm khu vực:

- Cảnh báo bất thường.
- Dự đoán chi phí lương.
- Rủi ro nghỉ việc.
- Nhân viên cần quan tâm.
- Phòng ban có hiệu suất giảm.
- Gợi ý hành động cho HR.

### 8.3. Module nghỉ phép có đề xuất AI

AI có thể gợi ý duyệt hoặc từ chối dựa trên:

- Số ngày phép còn lại.
- Lịch nghỉ của phòng ban.
- Mức độ ảnh hưởng tới nhân sự.
- Lịch sử nghỉ phép.
- Lý do nghỉ.

### 8.4. Module chấm công có phát hiện bất thường

AI có thể phát hiện:

- Đi trễ nhiều lần.
- Check-in/check-out bất thường.
- Nghỉ nhiều ngày liên tiếp.
- Hiệu suất giảm theo thời gian.

### 8.5. Module lương có phân tích đề xuất

AI có thể:

- Phát hiện lương bất thường.
- Đề xuất thưởng dựa trên KPI.
- Cảnh báo chi phí lương tăng.
- Gợi ý danh sách nhân viên cần xem xét tăng lương.

### 8.6. Cần human-in-the-loop

AI không nên tự quyết định cuối cùng các vấn đề nhân sự. Hệ thống nên có:

- Nút "Chấp nhận đề xuất".
- Nút "Từ chối đề xuất".
- Lý do HR từ chối/chấp nhận.
- Lịch sử đề xuất của AI.

## 9. Khoảng cách giữa đồ án hiện tại và đề tài Agentic AI

| Tiêu chí | Hiện tại | Cần bổ sung để đúng Agentic AI |
|---|---|---|
| HRM cơ bản | Có | Tiếp tục hoàn thiện |
| Chatbot | Có | Cần gọi dữ liệu thật và phân tích |
| AI phân tích | Chưa rõ | Cần thêm AI Insights |
| AI đề xuất quyết định | Chưa có | Cần thêm recommendation engine |
| Nguồn dữ liệu hiệu suất | Chưa có task/KPI thật | Cần Manager giao task, Employee cập nhật tiến độ, Manager review |
| Human-in-the-loop | Chưa có | Cần nút duyệt/từ chối đề xuất AI |
| Lịch sử AI | Chưa có | Cần lưu log phân tích/đề xuất |
| Backend API đồng bộ FE | Chưa chắc | Cần nối API thật |
| Tài liệu đồ án | Chưa đủ | Cần README, báo cáo, kịch bản demo |

## 10. Chức năng nên bổ sung để nâng cấp thành Agentic AI

Nhóm nên chọn một số chức năng vừa sức, không nên làm quá rộng.

### Chức năng nền: Manager giao task cho nhân viên

Mục tiêu:

- Tạo nguồn dữ liệu thật cho tiêu chí hiệu suất.
- Cho Manager có vai trò trực tiếp trong đánh giá nhân viên.
- Cho Employee cập nhật tiến độ công việc.
- Cho AI có dữ liệu task để phân tích năng lực.

Luồng:

```text
Manager giao task
Employee cập nhật tiến độ
Manager review/chấm chất lượng
AI tổng hợp task + chấm công + nghỉ phép
AI đánh giá năng lực và đề xuất hành động
```

Chức năng này là nền tảng cho module đánh giá năng lực, vì KPI/hiệu suất không nên do AI tự sinh.

### Chức năng 1: AI phân tích nghỉ phép

Mục tiêu:

- Phát hiện nhân viên nghỉ phép nhiều.
- Cảnh báo phòng ban thiếu người.
- Gợi ý duyệt/từ chối đơn nghỉ phép.

Input:

- Danh sách nhân viên.
- Lịch sử nghỉ phép.
- Phòng ban.
- Số ngày phép còn lại.

Output:

- Mức rủi ro: thấp/trung bình/cao.
- Lý do.
- Đề xuất xử lý.

### Chức năng 2: AI phát hiện bất thường chấm công

Mục tiêu:

- Phát hiện đi trễ, về sớm, thiếu công.
- Phân tích xu hướng theo tuần/tháng.

Output:

- Danh sách nhân viên bất thường.
- Loại bất thường.
- Mức độ ảnh hưởng.
- Đề xuất HR theo dõi hoặc trao đổi.

### Chức năng 3: AI gợi ý quyết định nhân sự

Mục tiêu:

- Đưa ra khuyến nghị cho HR dựa trên dữ liệu.

Ví dụ đề xuất:

- Nên duyệt đơn nghỉ phép.
- Nên xem xét thưởng.
- Nên trao đổi với nhân viên.
- Nên kiểm tra lại dữ liệu chấm công.

### Chức năng 4: AI tạo báo cáo nhân sự

Mục tiêu:

- Tự tổng hợp dữ liệu tháng.
- Sinh báo cáo ngắn cho HR.

Output:

- Tổng quan nhân sự.
- Điểm nổi bật.
- Cảnh báo.
- Khuyến nghị.

## 11. Luồng Agentic AI đề xuất

```text
Người dùng nhập yêu cầu
        ↓
AI Agent phân tích mục tiêu
        ↓
Agent chọn công cụ/API cần gọi
        ↓
Lấy dữ liệu nhân viên, nghỉ phép, chấm công, lương
        ↓
Phân tích và tạo insight
        ↓
Đưa ra đề xuất + giải thích lý do
        ↓
HR duyệt/từ chối đề xuất
        ↓
Lưu lịch sử quyết định
```

Luồng Agentic AI theo hướng mới của module đánh giá năng lực:

```text
Manager giao task cho nhân viên
        ↓
Employee nhận task và cập nhật tiến độ
        ↓
Manager review task, duyệt/chấm chất lượng
        ↓
AI Agent lấy dữ liệu task, chấm công, nghỉ phép, phòng ban, chức vụ
        ↓
AI Agent tính điểm chuyên cần, hiệu suất task, kỹ năng/chất lượng, kỷ luật/trách nhiệm
        ↓
AI Agent xếp loại năng lực và tạo nhận xét
        ↓
AI Agent đề xuất hành động: đào tạo, mentoring, khen thưởng, theo dõi
        ↓
Manager/HR duyệt kết quả cuối cùng
        ↓
Lưu lịch sử đánh giá năng lực
```

Luồng này hợp lý hơn vì KPI/hiệu suất có nguồn rõ ràng từ task do Manager giao, không phải AI tự suy đoán.

## 12. API cần đồng bộ giữa frontend và backend

Frontend hiện cần các nhóm API sau:

### Auth

- `POST /api/auth/login`
- `POST /api/auth/logout`
- `GET /api/auth/me`

### Employee

- `GET /api/employees`
- `GET /api/employees/{id}`
- `POST /api/employees`
- `PUT /api/employees/{id}`
- `DELETE /api/employees/{id}`

### Leave

- `GET /api/leave-requests`
- `POST /api/leave-requests`
- `PUT /api/leave-requests/{id}/approve`
- `PUT /api/leave-requests/{id}/reject`

### Attendance

- `GET /api/attendance`
- `POST /api/attendance/check-in`
- `POST /api/attendance/check-out`
- `POST /api/attendance/requests`
- `PUT /api/attendance/requests/{id}/approve`
- `PUT /api/attendance/requests/{id}/reject`

### Task/Manager

- `GET /api/manager/employees`
- `GET /api/manager/tasks`
- `POST /api/manager/tasks`
- `PUT /api/manager/tasks/{id}`
- `POST /api/manager/tasks/{id}/review`
- `GET /api/employee/tasks`
- `POST /api/employee/tasks/{id}/progress`
- `POST /api/employee/tasks/{id}/submit`

### Salary

- `GET /api/salaries`
- `GET /api/salaries/dashboard`
- `POST /api/salaries/calculate`
- `PUT /api/salaries/{id}/approve`
- `PUT /api/salaries/{id}/pay`

### AI/Agent

- `POST /api/ai/chat`
- `POST /api/ai/analyze-leave`
- `POST /api/ai/analyze-attendance`
- `POST /api/ai/recommendations`
- `GET /api/ai/recommendations/history`
- `PUT /api/ai/recommendations/{id}/accept`
- `PUT /api/ai/recommendations/{id}/reject`

## 13. Đề xuất cấu trúc frontend sau khi hoàn thiện

```text
frontend
├─ app
│  ├─ page.tsx
│  ├─ layout.tsx
│  ├─ dashboard
│  ├─ employees
│  ├─ salary
│  ├─ leave
│  ├─ attendance
│  ├─ reports
│  ├─ chatbot
│  └─ ai-insights
├─ components
│  ├─ layout
│  ├─ ui
│  ├─ dashboard
│  ├─ employees
│  ├─ salary
│  ├─ leave
│  ├─ attendance
│  └─ ai
├─ services
│  ├─ auth.ts
│  ├─ employees.ts
│  ├─ leave.ts
│  ├─ attendance.ts
│  ├─ salary.ts
│  └─ ai.ts
├─ types
└─ data
```

## 14. Đề xuất cấu trúc backend sau khi hoàn thiện

```text
backend/Admin
├─ Controllers
│  ├─ AuthController.cs
│  ├─ EmployeeController.cs
│  ├─ AttendanceController.cs
│  ├─ LeaveRequestController.cs
│  ├─ SalaryController.cs
│  └─ AiAgentController.cs
├─ Services
│  ├─ AuthService.cs
│  ├─ EmployeeService.cs
│  ├─ AttendanceService.cs
│  ├─ LeaveRequestService.cs
│  ├─ SalaryService.cs
│  └─ AiAgentService.cs
├─ Repositories
├─ Models
├─ DTOs
└─ Data
```

## 15. Các vấn đề cần sửa trước khi demo

### Frontend

- Hoàn thiện các page trống/bản nháp.
- Đưa API base vào `.env`.
- Duy trì `NEXT_PUBLIC_API_BASE_URL` để frontend gọi đúng backend `http://localhost:5297` hoặc URL deploy.
- Thay đăng nhập hard-code bằng API login.
- Thay dữ liệu hard-code bằng API thật.
- Tách component quá dài.
- Sửa lỗi mutate state trực tiếp trong form sửa nhân viên.
- Thêm loading/error state cho các API call.

### Backend

- Kiểm tra Swagger chạy được.
- Kiểm tra kết nối database.
- Bổ sung seed data nếu cần.
- Ẩn connection string/JWT secret.
- Kiểm tra CORS cho frontend.
- Kiểm tra JWT role admin/employee.
- Bổ sung API AI nếu làm Agentic AI.

### Tài liệu

- Viết README tổng.
- Viết hướng dẫn chạy frontend/backend.
- Viết tài khoản demo.
- Viết mô tả chức năng.
- Viết sơ đồ kiến trúc.
- Viết kịch bản demo.

## 16. Hướng dẫn chạy dự án

### Chạy frontend

```powershell
cd E:\New\chatbot-hrm-react-typescript\frontend
npm install
npm run dev
```

Frontend mặc định:

```text
http://localhost:3000
```

### Chạy backend

```powershell
cd E:\New\chatbot-hrm-react-typescript\backend\Admin
dotnet run
```

Backend mặc định:

```text
http://localhost:5297
```

Swagger thường ở:

```text
http://localhost:5297/swagger
```

Lưu ý: frontend đã build được bằng Next.js trong môi trường hiện tại. Backend cũng build được, còn một số warning nullable cũ nhưng không chặn chạy.

## 17. Phân chia nhiệm vụ cho 4 người

| Thành viên | Vai trò chính | Phụ trách |
|---|---|---|
| TV1 | Frontend Admin + Manager | Giao diện Admin/HR, Dashboard, quản lý nhân viên, lương, nghỉ phép, đánh giá năng lực phía quản lý |
| TV2 | Backend + Database | API, MySQL, Auth/JWT, nhân viên, phòng ban, chức vụ, nghỉ phép, chấm công, lương |
| TV3 | Agentic AI + Logic nghiệp vụ | Module đánh giá năng lực, công thức tính điểm, AI nhận xét, AI đề xuất hành động, chatbot/AI Assistant |
| TV4 | Frontend Employee + Document | Giao diện nhân viên, hồ sơ cá nhân, chấm công cá nhân, xin nghỉ phép, xem lương, viết báo cáo, slide, tài liệu demo |

Nói ngắn gọn:

- TV1: làm frontend cho bên Admin/Manager.
- TV2: làm Backend + Database.
- TV3: làm Agentic AI + xử lý nghiệp vụ đánh giá năng lực.
- TV4: làm frontend cho bên Employee + tài liệu/báo cáo/slide.

Cách chia này hợp lý hơn vì TV1 và TV4 đều làm frontend nhưng tách rõ:

- TV1 làm màn hình quản trị và quản lý.
- TV4 làm màn hình nhân viên và tài liệu.

### Chi tiết nhiệm vụ TV1

- Hoàn thiện giao diện Admin/HR.
- Làm giao diện Manager: dashboard phòng ban, nhân viên phòng ban, quản lý task, duyệt task, đánh giá năng lực.
- Nối API cho danh sách nhân viên, lương, nghỉ phép, chấm công.
- Hiển thị dữ liệu AI đánh giá năng lực ở phía quản lý.

### Chi tiết nhiệm vụ TV2

- Chạy và kiểm tra backend.
- Thiết kế database.
- Hoàn thiện API nhân viên, phòng ban, chức vụ, nghỉ phép, chấm công, lương.
- Tích hợp JWT và phân quyền.
- Viết seed data và kiểm tra Swagger.
- Chuẩn bị API/task schema để phục vụ đánh giá năng lực nếu nhóm triển khai.

### Chi tiết nhiệm vụ TV3

- Định nghĩa Agentic AI trong đồ án.
- Thiết kế logic nghiệp vụ đánh giá năng lực.
- Đề xuất luồng Manager giao task, Employee cập nhật tiến độ, Manager review task.
- Xây dựng công thức tính điểm từ task, chấm công, nghỉ phép và review của Manager.
- Viết nhận xét AI, đề xuất hành động cho HR/Manager.
- Phân tích giới hạn hiện tại: phần AI đang rule-based, chưa phải AI Agent hoàn chỉnh.

### Chi tiết nhiệm vụ TV4

- Hoàn thiện giao diện Employee.
- Làm hồ sơ cá nhân, chấm công cá nhân, xin nghỉ phép, xem lương.
- Nếu triển khai task: làm màn hình Task của tôi, cập nhật tiến độ, gửi hoàn thành.
- Viết tài liệu báo cáo, slide, README và kịch bản demo.

## 18. Lộ trình thực hiện đề xuất

### Giai đoạn 1: Ổn định dự án

- Gom frontend/backend vào cùng workspace.
- Chạy được frontend.
- Chạy được backend.
- Kiểm tra Swagger.
- Sửa route trống.
- Đồng bộ API base.

### Giai đoạn 2: Nối dữ liệu thật

- Frontend login gọi backend.
- Danh sách nhân viên lấy từ API.
- Nghỉ phép lấy từ API.
- Chấm công lấy từ API.
- Lương lấy từ API.

### Giai đoạn 3: Thêm AI/Agentic AI

- Thêm endpoint AI.
- Thêm dữ liệu đầu vào cho AI.
- Làm AI phân tích nghỉ phép.
- Làm AI phát hiện bất thường chấm công.
- Làm AI recommendations.
- Thêm giao diện AI Insights.

### Giai đoạn 4: Hoàn thiện đồ án

- Viết README.
- Viết báo cáo.
- Làm slide.
- Chuẩn bị dữ liệu demo.
- Test toàn bộ luồng.
- Quay/chạy demo.

## 19. Kịch bản demo đề xuất

### Demo 1: Admin đăng nhập

1. Mở hệ thống.
2. Đăng nhập với vai trò admin.
3. Xem dashboard tổng quan.
4. Xem số lượng nhân viên, lương, nghỉ phép, chấm công.

### Demo 2: Quản lý nhân viên

1. Vào danh sách nhân viên.
2. Tìm kiếm nhân viên.
3. Lọc theo phòng ban/trạng thái.
4. Xem/sửa thông tin nhân viên.

### Demo 3: Quản lý nghỉ phép

1. Xem danh sách đơn nghỉ phép.
2. Duyệt đơn.
3. Từ chối đơn và nhập lý do.
4. Xem trạng thái cập nhật.

### Demo 4: Quản lý chấm công

1. Xem lịch sử chấm công.
2. Xem đơn bổ sung/điều chỉnh.
3. Duyệt hoặc từ chối.

### Demo 5: Lương thưởng

1. Xem danh sách lương.
2. Tính lương.
3. Duyệt lương.
4. Thanh toán lương.

### Demo 6: AI Chatbot/Agentic AI

1. Manager giao task cho nhân viên trong phòng ban.
2. Nhân viên cập nhật tiến độ và gửi hoàn thành.
3. Manager review task, chấm chất lượng và duyệt kết quả.
4. Mở module Đánh giá năng lực.
5. AI tổng hợp dữ liệu task, chấm công, nghỉ phép, phòng ban và chức vụ.
6. AI tính điểm năng lực, xếp loại và đưa khuyến nghị.
7. Manager/HR xem lý do và quyết định chấp nhận/chỉnh sửa/từ chối.

## 20. Tiêu chí đánh giá đồ án

Đồ án sẽ được đánh giá tốt hơn nếu có:

- Giao diện hoàn chỉnh, dễ dùng.
- Chức năng HRM rõ ràng.
- Backend API chạy được.
- Database có dữ liệu thật/demo.
- Đăng nhập phân quyền.
- Chatbot hoặc AI hoạt động.
- Có AI phân tích và khuyến nghị nếu dùng tên Agentic AI.
- Có tài liệu rõ ràng.
- Có demo mạch lạc.

## 21. Nhận xét tổng kết

Đồ án hiện tại đã có nền tảng giao diện HRM khá rộng, phù hợp để phát triển thành một hệ thống quản trị nhân sự hoàn chỉnh. Tuy nhiên, phần lớn chức năng hiện vẫn đang ở mức demo frontend, dữ liệu hard-code và thao tác giả lập. Backend đã được đưa vào cùng workspace nhưng cần kiểm tra, nối API và đồng bộ với frontend.

Với chức năng hiện tại, tên **Hệ thống quản trị nhân sự tích hợp Agentic AI đánh giá năng lực** đã phù hợp ở mức đồ án demo, vì có module đánh giá năng lực tự phân tích dữ liệu và đưa khuyến nghị. Nếu muốn nâng cấp mạnh hơn, có thể bổ sung thêm AI phân tích nghỉ phép, phát hiện bất thường chấm công và lưu lịch sử khuyến nghị nhân sự.

Hướng phát triển hợp lý nhất là không làm lại từ đầu, mà giữ nền frontend/backend hiện tại, sau đó bổ sung tầng AI Agent và cải thiện kết nối dữ liệu thật.
