namespace Admin.DTOs
{
    public class CompetencyDto
    {
        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; } = string.Empty;
        public string Department { get; set; } = string.Empty;
        public string Position { get; set; } = string.Empty;
        public int AttendanceScore { get; set; }
        public int PerformanceScore { get; set; }
        public int SkillScore { get; set; }
        public int DisciplineScore { get; set; }
        public int TotalScore { get; set; }
        public string Rating { get; set; } = string.Empty;
        public string Strengths { get; set; } = string.Empty;
        public string Improvements { get; set; } = string.Empty;
        public string AiRecommendation { get; set; } = string.Empty;
    }
}
