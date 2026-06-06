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

Frontend hiện có module chatbot gọi API backend qua HTTP. Tuy nhiên hiện tại phần AI mới ở mức chatbot/trợ lý hỏi đáp, chưa thể hiện đầy đủ mô hình Agentic AI.

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

- Dữ liệu phần lớn đang hard-code trong component.
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

- Frontend chatbot hiện đang gọi `http://localhost:8000`, trong khi backend mới chạy `http://localhost:5297`.
- Cần kiểm tra lại API thực tế có khớp với frontend hay chưa.
- File cấu hình backend đang chứa connection string/JWT secret, không nên public khi nộp hoặc đẩy GitHub.
- Cần tách cấu hình nhạy cảm sang biến môi trường hoặc `appsettings.Development.json` không commit.
- Chưa thấy migration/database seed rõ ràng trong phân tích nhanh.
- Cần kiểm tra API có hỗ trợ đầy đủ các nghiệp vụ mà frontend đang hiển thị hay chưa.

## 6. Hệ thống hiện tại nên được gọi là gì?

Với code hiện tại, tên chính xác hơn là:

**Hệ thống quản trị nhân sự HRM tích hợp AI Chatbot hỗ trợ nhân viên**

Hoặc:

**Hệ thống quản trị nhân sự tích hợp chatbot hỗ trợ tra cứu và tư vấn nghiệp vụ nhân sự**

Không nên gọi là Agentic AI hoàn chỉnh nếu chưa bổ sung chức năng AI phân tích và ra quyết định.

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
| Human-in-the-loop | Chưa có | Cần nút duyệt/từ chối đề xuất AI |
| Lịch sử AI | Chưa có | Cần lưu log phân tích/đề xuất |
| Backend API đồng bộ FE | Chưa chắc | Cần nối API thật |
| Tài liệu đồ án | Chưa đủ | Cần README, báo cáo, kịch bản demo |

## 10. Chức năng nên bổ sung để nâng cấp thành Agentic AI

Nhóm nên chọn một số chức năng vừa sức, không nên làm quá rộng.

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
- Sửa chatbot từ `localhost:8000` sang đúng API backend hoặc endpoint AI riêng.
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

Lưu ý: môi trường phân tích hiện tại chưa chạy được `npm run build` vì máy không nhận `npm` trong PATH và chưa có `node_modules`. Cần kiểm tra lại trên máy có Node.js/npm đầy đủ.

## 17. Phân chia nhiệm vụ cho 4 người

| Thành viên | Vai trò | Nhiệm vụ |
|---|---|---|
| Người 1 | Frontend Admin | Dashboard admin, quản lý nhân viên, lương, nghỉ phép, duyệt chấm công, báo cáo |
| Người 2 | Frontend Employee | Cổng nhân viên, chấm công, xin nghỉ phép, xem lương, hồ sơ cá nhân, chatbot UI |
| Người 3 | Backend + Database | Auth/JWT, API nhân viên, lương, nghỉ phép, chấm công, database, Swagger |
| Người 4 | AI + Tài liệu + Demo | AI chatbot/Agentic AI, AI insights, báo cáo, slide, README, kịch bản demo |

### Chi tiết nhiệm vụ Người 1

- Hoàn thiện giao diện admin.
- Nối API cho danh sách nhân viên.
- Nối API cho lương, nghỉ phép, chấm công.
- Làm dashboard tổng quan.
- Hiển thị AI Insights trong dashboard nếu có.

### Chi tiết nhiệm vụ Người 2

- Hoàn thiện giao diện nhân viên.
- Làm chấm công, xin nghỉ phép, xem lương.
- Làm hồ sơ cá nhân.
- Hoàn thiện chatbot UI.
- Kiểm tra responsive.

### Chi tiết nhiệm vụ Người 3

- Chạy và kiểm tra backend.
- Thiết kế database.
- Hoàn thiện API.
- Tích hợp JWT.
- Xử lý role admin/employee.
- Viết seed data.
- Kiểm tra Swagger.

### Chi tiết nhiệm vụ Người 4

- Định nghĩa Agentic AI trong đồ án.
- Làm module AI phân tích dữ liệu.
- Tạo API recommendation.
- Viết phần giải thích khuyến nghị.
- Viết tài liệu báo cáo.
- Chuẩn bị slide và kịch bản demo.

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

1. Mở chatbot HR.
2. Hỏi thông tin nhân sự.
3. Yêu cầu AI phân tích nghỉ phép/chấm công.
4. AI đưa khuyến nghị.
5. HR xem lý do và quyết định chấp nhận/từ chối.

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

Nếu nhóm chỉ giữ chức năng hiện tại, tên phù hợp nhất là hệ thống HRM tích hợp AI Chatbot. Nếu muốn dùng tên Agentic AI, cần bổ sung ít nhất các chức năng AI phân tích nghỉ phép, phát hiện bất thường chấm công và đưa khuyến nghị nhân sự có giải thích.

Hướng phát triển hợp lý nhất là không làm lại từ đầu, mà giữ nền frontend/backend hiện tại, sau đó bổ sung tầng AI Agent và cải thiện kết nối dữ liệu thật.

