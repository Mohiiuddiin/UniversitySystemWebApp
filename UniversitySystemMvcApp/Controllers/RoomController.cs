using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using UniversitySystemMvcApp.Manager;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Controllers
{
    [Authorize]
    public class RoomController : Controller
    {
        private RoomAllocateManager RoomAllocateManager { get; set; }
        private RoomManager RoomManager { get; set; }
        public DepartmentManager DepartmentManager { get; set; }
        public CourseManager CourseManager { get; set; }

        public RoomController()
        {
            RoomAllocateManager = new RoomAllocateManager();
            RoomManager = new RoomManager();
            DepartmentManager = new DepartmentManager();
            CourseManager = new CourseManager();
        }
        //
        // GET: /Room/
        [HttpGet]
        public ActionResult AllocateRoom()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            ViewBag.Rooms = RoomManager.GetAllRoomsForDropDown();
            ViewBag.Days = GetAllDaysForDropDown();
            return View();
        }

        [HttpPost]
        public ActionResult AllocateRoom(RoomAllocate aRoomAllocate)
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            ViewBag.Rooms = RoomManager.GetAllRoomsForDropDown();
            ViewBag.Days = GetAllDaysForDropDown();
            if (ModelState.IsValid)
            {
                ViewBag.Message = RoomAllocateManager.Save(aRoomAllocate);
            }
            else
            {
                ViewBag.Message = "Model State is invalid";
            }
            return View();

        }

        public JsonResult GetCourseByDepartmentCode(string departmentCode)
        {
            List<SelectListItem> courseList =
                CourseManager.GetAllCoursesForDropDown().FindAll(x => x.Value == departmentCode);
            return Json(courseList);
        }

        private List<SelectListItem> GetAllDaysForDropDown()
        {
            List<SelectListItem> dayList = new List<SelectListItem>()
            {
                new SelectListItem(){Value = "Saturday",Text = "Saturday"},
                new SelectListItem(){Value = "Sunday",Text = "Sunday"},
                new SelectListItem(){Value = "Monday",Text = "Monday"},
                new SelectListItem(){ Value = "Tuesday",Text = "Tuesday"},
                new SelectListItem(){ Value = "Wednesday",Text = "Wednesday"},
                new SelectListItem(){Value = "Thursday",Text = "Thursday"},
                new SelectListItem(){ Value = "Friday",Text = "Friday"}
            };
            return dayList;
        }

        [HttpGet]
        public ActionResult ViewRoomSchedule()
        {
            ViewBag.Departments = DepartmentManager.GetAllDepartmentsForDropDown();
            //IEnumerable<Course> courses = CourseManager.GetAllCourses();
            //var courseList = courses.ToList().FindAll(c => c.DepartmentCode == departmentCode);
            return View();

        }
        
        public JsonResult GetClassScheduleByDepartment(string departmentCode)
        {
            List<Course> courses = CourseManager.GetAllCourses().FindAll(x=>x.DepartmentCode==departmentCode);

            List<object> clsSches = new List<object>();

            foreach (Course course in courses)
            {
                var scheduleInfo = RoomAllocateManager.GetAllClassScheduleViewsByDeptandCourse(departmentCode, course.Code);
                if (scheduleInfo == "")
                {
                    scheduleInfo = "Not sheduled yet";
                }


                var clsSch = new
                {
                    CourseCode = course.Code,
                    CourseName = course.Name,
                    ScheduleInfo = scheduleInfo
                };
                clsSches.Add(clsSch);
            }
            return Json(clsSches);
        }
        public JsonResult GetCoursesByDepartmentId(string departmentCode)
        {
            IEnumerable<Course> courses = CourseManager.GetAllCourses();
            var courseList = courses.ToList().FindAll(c => c.DepartmentCode == departmentCode);
            return Json(courseList);
        }

        [HttpGet]
        public ActionResult UnallocateRooms()
        {
            return View();
        }
        [HttpPost]
        public ActionResult UnallocateRooms(int? id)
        {
            ViewBag.Message = RoomAllocateManager.UnallocateAllRooms();
            return View();
        }
	}
}