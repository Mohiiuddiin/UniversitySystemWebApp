using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class Department
    {
        [Required(ErrorMessage = "Please Enter Department Code")]
        [StringLength(7,MinimumLength = 2)]
        public string Code { get; set; }
        [Required(ErrorMessage = "Please Enter Name of the Department")]
        public string Name { get; set; }

    }
}