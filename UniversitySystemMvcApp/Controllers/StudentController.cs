using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Manager;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Controllers
{
    [Authorize]
    public class StudentController : Controller
    {
        private DepartmentManager DepartmentManager { get; set; }
        private StudentManager StudentManager { get; set; }
        public CourseManager CourseManager { get; set; }
        private GradeManager GradeManager { get; set; }
        private StudentResultManager StudentResultManager { get; set; }
        public EnrollCourseManager EnrollCourseManager { get; set; }

        public StudentController()
        {
            DepartmentManager = new DepartmentManager();
            StudentManager = new StudentManager();
            GradeManager = new GradeManager();
            CourseManager = new CourseManager();  
            StudentResultManager = new StudentResultManager();
            EnrollCourseManager = new EnrollCourseManager();
        }
       
        [HttpGet]
        public ActionResult SaveStudent()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            return View();
        }
        [HttpPost]
        public ActionResult SaveStudent(Student student)
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = StudentManager.Save(student);
                ViewBag.LastStudent = StudentManager.GetStudentByEmail(student.Email);                
            }
            else
            {
                
                ViewBag.Message = "Model State is Invalid";
            }
            return View();
        }
        
        public JsonResult GetCourseCodeByStudentId(int id)
        {
            Student student = StudentManager.GetAllStudents().Find(x => x.Id == id);
            List<Course> courses =
                CourseManager.GetAllCourses().FindAll(x => x.DepartmentCode == student.DepartmentCode);
            return Json(courses);
        }

        

        [HttpGet]
        public ActionResult SaveResult()
        {
            ViewBag.StudentsReg = StudentManager.GetAllStudentsForDropdown();
            ViewBag.Grades = GradeManager.GetAllGradesForDropDown();
            return View();
        }
        [HttpPost]
        public ActionResult SaveResult(StudentResult studentResult)
        {
            ViewBag.StudentsReg = StudentManager.GetAllStudentsForDropdown();
            ViewBag.Grades = GradeManager.GetAllGradesForDropDown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = StudentResultManager.Save(studentResult);
            }
            else
            {
                ViewBag.Message = "Model State is Invalid";
            }
            return View();
        }
        public JsonResult GetCourseRegByStudentId(int studentId)
        {
            List<StudentCourseView> enrolledCourseList = CourseManager.GetCoursesByStudentId(studentId);
            return Json(enrolledCourseList);
        }
        

        [HttpGet]
        public ActionResult ViewStudentResult()
        {
            ViewBag.StudentsReg = StudentManager.GetAllStudentsForDropdown();
            return View();
        }

        public JsonResult GetResultViewByStudentId(int studentId)
        {
            List<StudentResultView> resultViews = StudentResultManager.GetResultsById(studentId);
            return Json(resultViews);
        }

      
	}
}