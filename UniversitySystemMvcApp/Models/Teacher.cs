using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class Teacher
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Address { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string ContactNo { get; set; }
        [Required]
        [Display(Name = "Designation")]
        public int DesignationId { get; set; }
        [Required]
        [Display(Name = "Department")]
        public string DepartmentCode { get; set; }
        [Required]
        [Display(Name = "Credit to be taken")]
        [Range(1,int.MaxValue,ErrorMessage = "Negative value is not allowed")]
    
        public double MaximumCredit { get; set; }

        public double CreditTaken { get; set; }
    }
}