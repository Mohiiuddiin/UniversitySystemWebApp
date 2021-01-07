using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class StudentResult
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please Select a Registration No")]
        [Display(Name = "Student Reg No.")]
        public int StudentId { get; set; }
        [Required(ErrorMessage = "Please Selecte a Valid Course")]
        [Display(Name = "Course")]
        public string CourseCode { get; set; }
        [Required(ErrorMessage = "Please Select a Grade")]
        [Display(Name = "Grade")]
        public string GradeCode { get; set; }
    }
}