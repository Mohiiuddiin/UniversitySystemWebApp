namespace UniversitySystemMvcApp.Models.ViewModels
{
    public class CourseStatisticsViewModel
    {
        public string CourseCode { get; set; }
        public string DepartmentCode { get; set; }
        public string CourseName { get; set; }
        public int  SemesterId { get; set; }
        public double Credit   {    get; set; }
        public string Description { get; set; }
        public string SemesterName { get; set; }
        public string TeacherName { get; set; }

        
    }
}