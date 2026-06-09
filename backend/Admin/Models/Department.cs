using System.ComponentModel.DataAnnotations.Schema;

namespace Admin.Models
{
    [Table("departments")]
    public class Department
    {
        [Column("department_id")]
        public int Id { get; set; }

        [Column("department_name")]
        public string Name { get; set; } = null!;

        [NotMapped]
        public string? Description { get; set; }

        public ICollection<Employee> Employees { get; set; } = new List<Employee>();
    }
}
