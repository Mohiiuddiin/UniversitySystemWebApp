using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Manager;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Controllers
{
    [Authorize]
    public class DepartmentController : Controller
    {
        private DepartmentManager DepartmentManager { get; set; }

        public DepartmentController( )
        {
            DepartmentManager = new DepartmentManager();

        }       
        
        [HttpGet]
        public ActionResult SaveDepartment()
        {
            List<Department> departments = DepartmentManager.GetAllDepartments();
            ViewBag.Departments = departments;
            return View();
        }

        [HttpPost]
        public ActionResult SaveDepartment(Department department)
        {
            if (ModelState.IsValid)
            {                
                ViewBag.Message = DepartmentManager.Save(department);
                List<Department> departments = DepartmentManager.GetAllDepartments();
                ViewBag.Departments = departments;
            }
            else
            {
                ViewBag.Message = "Model State is not valid";
            }
            
            return View();
        }

        [HttpGet]
        public ActionResult ViewAllDepartments()
        {
            List<Department> departments = DepartmentManager.GetAllDepartments();
            ViewBag.Departments = departments;
            return View(departments);
        }
	}
}