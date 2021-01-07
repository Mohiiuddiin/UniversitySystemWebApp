using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class Course
    {
        [Required(ErrorMessage = "Please Enter a Course Name")]
        [StringLength(10, MinimumLength = 5, ErrorMessage = "Enter valid lenght")]
        public string Code { get; set; }
        [Required(ErrorMessage = "Please Select a Department")]
        [Display(Name = "Department")]
        public string DepartmentCode { get; set; }
        [Required(ErrorMessage = "Please Select a Semester")]
        [Display(Name="Semester")]
        public int SemesterId { get; set; }
        [Required(ErrorMessage = "Please Fill the name of the Course")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Specify credit for the course")]
        [Range(1, int.MaxValue, ErrorMessage = "Negative value is not allowed")]
        
        public double Credit { get; set; }
        [Required(ErrorMessage = "Please fill the Description")]
        
        public string Description { get; set; }
        
    }
}