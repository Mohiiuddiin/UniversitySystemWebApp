using System;
using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class Student
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please Fill the name of student")]
        public string Name { get; set; }
        public string RegNo { get; set; }
        [Required(ErrorMessage = "Please provide a valid and unique Email Address")]
        [EmailAddress]
        public string Email { get; set; }
        [Required(ErrorMessage = "Please provide Contact Number")]
        [Phone]
        [Display(Name = "Contact No.")]
        public string ContactNo { get; set; }
        [Required(ErrorMessage = "Please Select Registration Date")]
        
        
        public DateTime Date { get; set; }
        [Required(ErrorMessage = "Please provide Address of Student")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Please Select a Department")]
        [Display(Name="Department")]
        public string DepartmentCode { get; set; }
    }
}