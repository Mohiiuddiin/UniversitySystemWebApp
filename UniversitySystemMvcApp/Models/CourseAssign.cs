using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class CourseAssign
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please Select a Department First")]
        public string DepartmentCode { get; set; }
        [Required(ErrorMessage = "Please Select a Teacher")]
        public int TeacherId { get; set; }
        [Required(ErrorMessage = "Please Select a Course to assign")]
        public string CourseCode { get; set; }
        

    }
}