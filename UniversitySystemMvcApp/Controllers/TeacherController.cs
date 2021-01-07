using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Manager;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Controllers
{
    [Authorize]
    public class TeacherController : Controller
    {
        private DesignationManager DesignationManager { get; set; }
        private DepartmentManager DepartmentManager { get; set; }
        private TeacherManager TeacherManager { get; set; }
        private CourseManager CourseManager { get; set; }
        public CourseAssignManager CourseAssignManager { get; set; }

        public TeacherController()
        {
            DesignationManager = new DesignationManager();
            DepartmentManager = new DepartmentManager();
            TeacherManager = new TeacherManager();
            CourseManager = new CourseManager();
            CourseAssignManager = new CourseAssignManager();
        }
        [HttpGet]
        public ActionResult SaveTeacher()
        {
            ViewBag.Designation = DesignationManager.GetAllDesognationForDropDown();
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            return View();
        }
        [HttpPost]
        public ActionResult SaveTeacher(Teacher aTeacher)
        {
            ViewBag.Designation = DesignationManager.GetAllDesognationForDropDown();
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = TeacherManager.Save(aTeacher);
            }
            else
            {
                ViewBag.Message = "Model State is Invalid";
            }
            return View();
        }

        [HttpGet]
        public ActionResult CourseAssignToTeacher()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();

            return View();
        }

        public JsonResult GetTeacherByDepartmentCode(string departmentCode)
        {
            List<Teacher> teachers = TeacherManager.GetAllTeachers().FindAll(x=>x.DepartmentCode==departmentCode);
            return Json(teachers,JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseByDepartmentCode(string departmentCode)
        {
            List<Course> courses = CourseManager.GetAllCourses().FindAll(x=>x.DepartmentCode==departmentCode);
            return Json(courses,JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTeacherInfoByTeacherId(int teacherId)
        {
            Teacher aTeacher = TeacherManager.GetTeacherById(teacherId);
            return Json(aTeacher);
        }

        public JsonResult GetCourseByCourseCode(string courseCode)
        {
            List<Course> aCourseList = CourseManager.GetAllCourses().FindAll(x => x.Code == courseCode);
            Course aCourse = aCourseList.Find(x => x.Code == courseCode);
            return Json(aCourse);

        }

        [HttpPost]
        public ActionResult CourseAssignToTeacher(CourseAssign aCourseAssign)
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            //ViewBag.Courses = CourseManager.GetAllCourses();
            //ViewBag.Teachers = TeacherManager.GetAllTeachers();
            if (ModelState.IsValid)
            {
                ViewBag.Message = CourseAssignManager.Save(aCourseAssign); 
            }
            else
            {
                ViewBag.Message = "Model State is invalid";
            }

            
            return View();
        }
	}
}