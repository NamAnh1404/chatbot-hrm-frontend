using Admin.Data;
using Admin.DTOs;
using Admin.Models;
using Microsoft.EntityFrameworkCore;

namespace Admin.Services
{
    public class CompetencyService
    {
        private readonly AppDbContext _db;

        public CompetencyService(AppDbContext db)
        {
            _db = db;
        }

        public List<CompetencyDto> GetAll(int year, int month)
        {
            var employees = _db.Employees
                .Include(e => e.Department)
                .Include(e => e.Position)
                .AsNoTracking()
                .Where(e => e.Status == "Đang làm việc")
                .ToList();

            var attendanceByEmployee = _db.Attendances
                .AsNoTracking()
                .Where(a => a.Date.Year == year && a.Date.Month == month)
                .ToList()
                .GroupBy(a => a.EmployeeId)
                .ToDictionary(g => g.Key, g => g.ToList());

            return employees
                .Select(e =>
                {
                    attendanceByEmployee.TryGetValue(e.Id, out var attendance);
                    attendance ??= new List<Attendance>();

                    var attendanceScore = CalculateAttendanceScore(attendance);
                    var performanceScore = CalculatePerformanceScore(e.Id, attendanceScore);
                    var skillScore = CalculateSkillScore(e.Position?.Title, e.Department?.Name);
                    var disciplineScore = CalculateDisciplineScore(attendance);
                    var totalScore = (int)Math.Round(
                        attendanceScore * 0.30 +
                        performanceScore * 0.35 +
                        skillScore * 0.20 +
                        disciplineScore * 0.15
                    );

                    var rating = GetRating(totalScore);

                    return new CompetencyDto
                    {
                        EmployeeId = e.Id,
                        EmployeeName = e.FullName,
                        Department = e.Department?.Name ?? "Chưa phân phòng",
                        Position = e.Position?.Title ?? "Chưa có chức vụ",
                        AttendanceScore = attendanceScore,
                        PerformanceScore = performanceScore,
                        SkillScore = skillScore,
                        DisciplineScore = disciplineScore,
                        TotalScore = totalScore,
                        Rating = rating,
                        Strengths = BuildStrengths(attendanceScore, performanceScore, skillScore, disciplineScore),
                        Improvements = BuildImprovements(attendanceScore, performanceScore, skillScore, disciplineScore),
                        AiRecommendation = BuildRecommendation(e.FullName, rating, attendanceScore, performanceScore, skillScore, disciplineScore)
                    };
                })
                .OrderByDescending(x => x.TotalScore)
                .ThenBy(x => x.EmployeeName)
                .ToList();
        }

        public object GetDashboard(int year, int month)
        {
            var data = GetAll(year, month);

            return new
            {
                month,
                year,
                totalEmployees = data.Count,
                averageScore = data.Count == 0 ? 0 : Math.Round(data.Average(x => x.TotalScore), 1),
                excellent = data.Count(x => x.Rating == "Xuất sắc"),
                good = data.Count(x => x.Rating == "Tốt"),
                average = data.Count(x => x.Rating == "Trung bình"),
                needsImprovement = data.Count(x => x.Rating == "Cần cải thiện"),
                topEmployees = data.Take(5)
            };
        }

        public CompetencyDto? AnalyzeEmployee(int employeeId, int year, int month)
        {
            return GetAll(year, month).FirstOrDefault(x => x.EmployeeId == employeeId);
        }

        private static int CalculateAttendanceScore(List<Attendance> attendance)
        {
            if (attendance.Count == 0) return 75;

            var latePenalty = attendance.Count(x => x.IsLate) * 4;
            var earlyPenalty = attendance.Count(x => x.IsEarlyLeave) * 3;
            var incompletePenalty = attendance.Count(x => x.Status != "Completed") * 2;

            return Clamp(100 - latePenalty - earlyPenalty - incompletePenalty);
        }

        private static int CalculatePerformanceScore(int employeeId, int attendanceScore)
        {
            var baseline = 78 + (employeeId % 6) * 3;
            var attendanceBoost = attendanceScore >= 90 ? 5 : attendanceScore < 70 ? -6 : 0;

            return Clamp(baseline + attendanceBoost);
        }

        private static int CalculateSkillScore(string? position, string? department)
        {
            var text = $"{position} {department}".ToLowerInvariant();
            var score = 78;

            if (text.Contains("manager") || text.Contains("lead") || text.Contains("trưởng")) score += 9;
            if (text.Contains("developer") || text.Contains("it") || text.Contains("devops") || text.Contains("qa")) score += 7;
            if (text.Contains("hr") || text.Contains("nhân sự")) score += 5;
            if (text.Contains("sales") || text.Contains("marketing")) score += 4;

            return Clamp(score);
        }

        private static int CalculateDisciplineScore(List<Attendance> attendance)
        {
            if (attendance.Count == 0) return 80;

            var issueCount = attendance.Count(x => x.IsLate || x.IsEarlyLeave || x.Status != "Completed");
            return Clamp(96 - issueCount * 5);
        }

        private static string GetRating(int totalScore)
        {
            if (totalScore >= 90) return "Xuất sắc";
            if (totalScore >= 80) return "Tốt";
            if (totalScore >= 65) return "Trung bình";
            return "Cần cải thiện";
        }

        private static string BuildStrengths(int attendance, int performance, int skill, int discipline)
        {
            var strengths = new List<string>();

            if (attendance >= 85) strengths.Add("chuyên cần ổn định");
            if (performance >= 85) strengths.Add("hiệu suất làm việc tốt");
            if (skill >= 85) strengths.Add("nền tảng kỹ năng phù hợp");
            if (discipline >= 85) strengths.Add("kỷ luật làm việc tốt");

            return strengths.Count == 0 ? "Có nền tảng làm việc cơ bản, cần thêm dữ liệu để đánh giá sâu hơn." : string.Join(", ", strengths) + ".";
        }

        private static string BuildImprovements(int attendance, int performance, int skill, int discipline)
        {
            var improvements = new List<string>();

            if (attendance < 80) improvements.Add("cải thiện chuyên cần và đúng giờ");
            if (performance < 80) improvements.Add("nâng hiệu suất xử lý công việc");
            if (skill < 80) improvements.Add("bổ sung kỹ năng chuyên môn");
            if (discipline < 80) improvements.Add("giảm vi phạm chấm công");

            return improvements.Count == 0 ? "Duy trì phong độ hiện tại và chuẩn bị mục tiêu phát triển cao hơn." : string.Join(", ", improvements) + ".";
        }

        private static string BuildRecommendation(string employeeName, string rating, int attendance, int performance, int skill, int discipline)
        {
            if (rating == "Xuất sắc")
            {
                return $"{employeeName} có năng lực nổi bật. Đề xuất đưa vào nhóm nhân sự nòng cốt, giao nhiệm vụ có độ khó cao hơn và cân nhắc khen thưởng.";
            }

            if (rating == "Tốt")
            {
                return $"{employeeName} có năng lực tốt và ổn định. Đề xuất duy trì mục tiêu hiện tại, bổ sung đào tạo ngắn hạn để tăng điểm kỹ năng hoặc hiệu suất.";
            }

            if (attendance < 75 || discipline < 75)
            {
                return $"{employeeName} cần ưu tiên cải thiện chuyên cần và kỷ luật làm việc. HR nên trao đổi trực tiếp, đặt mục tiêu theo dõi trong tháng tiếp theo.";
            }

            if (skill < 75)
            {
                return $"{employeeName} cần kế hoạch đào tạo kỹ năng chuyên môn. Đề xuất học nội bộ hoặc mentoring với nhân sự có kinh nghiệm.";
            }

            return $"{employeeName} ở mức trung bình. Đề xuất đặt KPI rõ hơn, theo dõi tiến độ hằng tuần và đánh giá lại sau 1 tháng.";
        }

        private static int Clamp(int value)
        {
            return Math.Max(0, Math.Min(100, value));
        }
    }
}
