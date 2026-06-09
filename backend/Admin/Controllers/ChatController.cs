using Microsoft.AspNetCore.Mvc;
using System.Collections.Concurrent;

namespace Admin.Controllers
{
    [ApiController]
    [Route("chat")]
    public class ChatController : ControllerBase
    {
        private static readonly ConcurrentDictionary<int, ChatSession> Sessions = new();
        private static int _nextSessionId = 1;

        [HttpPost("session")]
        public IActionResult CreateSession([FromQuery] int user_id)
        {
            var sessionId = Interlocked.Increment(ref _nextSessionId);
            var session = new ChatSession
            {
                SessionId = sessionId,
                UserId = user_id,
                CreatedAt = DateTime.Now,
                Title = $"Session #{sessionId}",
                Messages = new List<ChatMessage>()
            };

            Sessions[sessionId] = session;

            return Ok(new { session_id = sessionId });
        }

        [HttpGet("sessions")]
        public IActionResult GetSessions([FromQuery] int user_id, [FromQuery] int limit = 10)
        {
            var sessions = Sessions.Values
                .Where(x => x.UserId == user_id)
                .OrderByDescending(x => x.CreatedAt)
                .Take(limit)
                .Select(x => new
                {
                    session_id = x.SessionId,
                    created_at = x.CreatedAt.ToString("dd/MM/yyyy HH:mm"),
                    title = x.Title,
                    last_message = x.Messages.LastOrDefault()?.Text
                })
                .ToList();

            return Ok(sessions);
        }

        [HttpGet("history/{sessionId:int}")]
        public IActionResult GetHistory(int sessionId)
        {
            if (!Sessions.TryGetValue(sessionId, out var session))
            {
                return Ok(Array.Empty<ChatMessage>());
            }

            return Ok(session.Messages);
        }

        [HttpPost]
        public IActionResult Chat([FromBody] ChatRequest request)
        {
            if (!Sessions.TryGetValue(request.Session_Id, out var session))
            {
                return NotFound(new { message = "Session not found" });
            }

            var now = DateTime.Now.ToString("HH:mm");
            var userMessage = new ChatMessage
            {
                Id = DateTimeOffset.Now.ToUnixTimeMilliseconds(),
                Text = request.Message,
                Sender = "user",
                Time = now
            };

            var botMessage = new ChatMessage
            {
                Id = DateTimeOffset.Now.ToUnixTimeMilliseconds() + 1,
                Text = CreateReply(request.Message),
                Sender = "bot",
                Time = now
            };

            session.Messages.Add(userMessage);
            session.Messages.Add(botMessage);

            if (session.Messages.Count == 2)
            {
                session.Title = request.Message.Length > 35
                    ? request.Message[..35] + "..."
                    : request.Message;
            }

            return Ok(new { reply = botMessage.Text });
        }

        [HttpDelete("session/{sessionId:int}")]
        public IActionResult DeleteSession([FromQuery] int user_id, int sessionId)
        {
            if (Sessions.TryGetValue(sessionId, out var session) && session.UserId == user_id)
            {
                Sessions.TryRemove(sessionId, out _);
            }

            return Ok(new { ok = true });
        }

        private static string CreateReply(string message)
        {
            var text = message.ToLowerInvariant();

            if (text.Contains("năng lực") || text.Contains("nang luc") || text.Contains("đánh giá") || text.Contains("danh gia") || text.Contains("agentic"))
            {
                return "Bạn có thể vào mục Đánh giá năng lực để xem điểm chuyên cần, hiệu suất, kỹ năng, kỷ luật và nhận xét AI cho từng nhân viên. Agentic AI sẽ tổng hợp dữ liệu HRM, phân loại năng lực và đề xuất đào tạo hoặc theo dõi thêm.";
            }

            if (text.Contains("lương") || text.Contains("luong"))
            {
                return "Bạn có thể xem lương tại mục Lương thưởng. Với bản demo hiện tại, hệ thống đang có dữ liệu lương mẫu theo tháng, trạng thái duyệt và thanh toán.";
            }

            if (text.Contains("nghỉ") || text.Contains("nghi") || text.Contains("phép") || text.Contains("phep"))
            {
                return "Bạn có thể tạo đơn nghỉ phép trong mục Nghỉ phép. HR sẽ xem số ngày nghỉ, lý do và trạng thái để duyệt hoặc từ chối.";
            }

            if (text.Contains("chấm công") || text.Contains("cham cong") || text.Contains("đi trễ") || text.Contains("di tre"))
            {
                return "Mục Chấm công hỗ trợ xem lịch sử, check-in/check-out và gửi yêu cầu bổ sung hoặc điều chỉnh giờ làm.";
            }

            if (text.Contains("nhân viên") || text.Contains("nhan vien"))
            {
                return "Module Quản lý nhân viên cho phép xem danh sách, tìm kiếm, lọc theo phòng ban và quản lý hồ sơ nhân sự.";
            }

            if (text.Contains("báo cáo") || text.Contains("bao cao"))
            {
                return "Bạn có thể vào mục Báo cáo để xem báo cáo nhân sự, lương, nghỉ phép và hiệu suất. Nếu nâng cấp Agentic AI, hệ thống có thể tự tổng hợp insight cho HR.";
            }

            return "Tôi là AI Assistant bản demo của hệ thống HRM. Tôi có thể hỗ trợ các chủ đề như đánh giá năng lực, lương, nghỉ phép, chấm công, nhân viên và báo cáo.";
        }
    }

    public class ChatRequest
    {
        public string Message { get; set; } = string.Empty;
        public int Session_Id { get; set; }
    }

    public class ChatSession
    {
        public int SessionId { get; set; }
        public int UserId { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Title { get; set; } = string.Empty;
        public List<ChatMessage> Messages { get; set; } = new();
    }

    public class ChatMessage
    {
        public long Id { get; set; }
        public string Text { get; set; } = string.Empty;
        public string Sender { get; set; } = string.Empty;
        public string Time { get; set; } = string.Empty;
    }
}
