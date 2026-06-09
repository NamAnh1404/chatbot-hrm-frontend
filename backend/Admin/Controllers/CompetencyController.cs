using Admin.Services;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [ApiController]
    [Route("api/admin/competency")]
    public class CompetencyController : ControllerBase
    {
        private readonly CompetencyService _service;

        public CompetencyController(CompetencyService service)
        {
            _service = service;
        }

        [HttpGet]
        public IActionResult GetAll([FromQuery] int? month, [FromQuery] int? year)
        {
            var now = DateTime.Now;
            return Ok(_service.GetAll(year ?? now.Year, month ?? now.Month));
        }

        [HttpGet("dashboard")]
        public IActionResult Dashboard([FromQuery] int? month, [FromQuery] int? year)
        {
            var now = DateTime.Now;
            return Ok(_service.GetDashboard(year ?? now.Year, month ?? now.Month));
        }

        [HttpGet("{employeeId:int}/analyze")]
        public IActionResult AnalyzeEmployee(int employeeId, [FromQuery] int? month, [FromQuery] int? year)
        {
            var now = DateTime.Now;
            var result = _service.AnalyzeEmployee(employeeId, year ?? now.Year, month ?? now.Month);

            if (result == null)
            {
                return NotFound(new { message = "Không tìm thấy dữ liệu đánh giá năng lực của nhân viên" });
            }

            return Ok(result);
        }
    }
}
