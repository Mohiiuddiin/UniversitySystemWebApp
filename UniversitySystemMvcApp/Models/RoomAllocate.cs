using System.ComponentModel.DataAnnotations;

namespace UniversitySystemMvcApp.Models
{
    public class RoomAllocate
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please Select a Department Code")]
        [Display(Name = "Department")]
        public string DepartmentCode { get; set; }
        [Required(ErrorMessage = "Please Select a Course Code")]
        [Display(Name = "Course")]
        public string CourseCode { get; set; }
        [Required(ErrorMessage = "Please Select a room to allocate")]
        [Display(Name = "Room")]
        public int RoomNo { get; set; }
        [Required(ErrorMessage = "Please Choose a Day")]
        public string Day { get; set; }
        [Required(ErrorMessage = "Please Specify Initial Time")]
        public string From { get; set; }
        [Required(ErrorMessage = "Please specify End Time")]
        public string To { get; set; }
    }
}