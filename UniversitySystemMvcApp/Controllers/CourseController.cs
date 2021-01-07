using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Manager;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Controllers
{
    [Authorize]
    public class CourseController : Controller
    {
        public CourseManager CourseManager { get; set; }
        public DepartmentManager DepartmentManager { get; set; }
        public SemesterManager SemesterManager { get; set; }
        public CourseAssignManager CourseAssignManager { get; set; }
        public StudentManager StudentManager { get; set; }
        public EnrollCourseManager EnrollCourseManager { get; set; }

        public CourseController()
        {
            CourseManager = new CourseManager();
            DepartmentManager = new DepartmentManager();
            SemesterManager = new SemesterManager();
            CourseAssignManager = new CourseAssignManager();
            StudentManager = new StudentManager();
            EnrollCourseManager = new EnrollCourseManager();
        }
        [HttpGet]
        public ActionResult SaveCourse()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            ViewBag.Semesters = SemesterManager.GetAllSemesterForDropDown();
            return View();
        }
        [HttpPost]
        public ActionResult SaveCourse(Course aCourse)
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            ViewBag.Semesters = SemesterManager.GetAllSemesterForDropDown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = CourseManager.Save(aCourse);
            }
            else
            {
                
                ViewBag.Message = "Model State is Invalid";
            }        
            return View();
        }

        [HttpGet]
        public ActionResult ViewCourseStatistics()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();           
            return View();
        }

        public JsonResult GetCourseViewsByDeptCode(string departmentCode)
        {
            List<CourseStatisticsViewModel> courses =
                CourseAssignManager.GetAllCoursesInfo().FindAll(x => x.DepartmentCode == departmentCode);
            return Json(courses);
        }

        [HttpGet]
        public ActionResult EnrollCourseToStudent()
        {
            ViewBag.StudentsReg = StudentManager.GetAllStudentsForDropdown();
            return View();
        }

        public JsonResult GetStudentByStudentId(int studentId)
        {
            Student student = StudentManager.GetAllStudents().Find(x=>x.Id==studentId);
            return Json(student);
        }
        
        [HttpPost]
        public ActionResult EnrollCourseToStudent(EnrollCourse enrollCourse)
        {
            ViewBag.StudentsReg = StudentManager.GetAllStudentsForDropdown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = EnrollCourseManager.Save(enrollCourse);
            }
            else
            {
                ViewBag.Message = "Model State is Invalid";
            }
            return View();
        }

        [HttpGet]
        public ActionResult UnassignCourses()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UnassignCourses(int? id)
        {
            ViewBag.Message = CourseAssignManager.UnassignCourses();
            return View();
        }
	}
}