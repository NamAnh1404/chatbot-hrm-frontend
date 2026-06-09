using Admin.Models;
using Admin.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [ApiController]
    [Route("api/admin/employees")]
    public class EmployeeController : ControllerBase
    {
        private readonly EmployeeService _service;

        public EmployeeController(EmployeeService service)
        {
            _service = service;
        }

        // =========================
        // GET ALL
        // GET: api/admin/employees
        // =========================
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var employees = await _service.GetAll();
            return Ok(employees);
        }

        // =========================
        // GET BY ID
        // GET: api/admin/employees/{id}
        // =========================
        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var employee = await _service.GetById(id);

            if (employee == null)
                return NotFound(new { message = "Employee not found" });

            return Ok(employee);
        }

        [HttpGet("departments")]
        public async Task<IActionResult> GetDepartments()
        {
            return Ok(await _service.GetDepartments());
        }

        [HttpGet("positions")]
        public async Task<IActionResult> GetPositions()
        {
            return Ok(await _service.GetPositions());
        }

        // =========================
        // CREATE
        // POST: api/admin/employees
        // =========================
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Employee employee)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var created = await _service.Create(employee);
                var dto = await _service.GetById(created.Id);
                return Ok(dto ?? new EmployeeDto { Id = created.Id });
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // =========================
        // UPDATE ✅ SỬA: dùng EmployeeUpdateDto để không bắt Password
        // PUT: api/admin/employees/{id}
        // =========================
        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] EmployeeUpdateDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            bool ok;
            try
            {
                ok = await _service.Update(id, dto);
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { message = ex.Message });
            }

            if (!ok)
                return NotFound(new { message = "Employee not found" });

            return Ok(new { message = "Updated successfully" });
        }

        // =========================
        // DELETE
        // DELETE: api/admin/employees/{id}
        // =========================
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var success = await _service.Delete(id);

            if (!success)
                return NotFound(new { message = "Employee not found" });

            return Ok(new { message = "Deleted successfully" });
        }
    }
}
