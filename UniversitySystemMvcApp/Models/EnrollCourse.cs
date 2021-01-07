using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class EnrollCourse
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please select a Student Registration No")]
        [Display(Name = "Student ID")]
        public int StudentId { get; set; }
        [Required(ErrorMessage = "Please Select a Course to Enroll")]
        [Display(Name = "Course Code")]
        public string CourseCode { get; set; }
        [Required(ErrorMessage = "Please Enter a Valid Date")]
        public string Date { get; set; }
    }
}