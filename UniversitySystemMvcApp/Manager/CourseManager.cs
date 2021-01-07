using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class CourseManager
    {
        private CourseGateway CourseGateway { get; set; }

        public CourseManager()
        {
            CourseGateway = new CourseGateway();
        }
        public string Save(Course aCourse)
        {
            if (CourseGateway.IsExist(aCourse))
            {
                return ConstantMessage.courseExist;
            }
            else
            {
                int rowEffect = CourseGateway.Save(aCourse);
                if (rowEffect > 0)
                {
                    return ConstantMessage.saveCourseSucess;
                }
                return "Save Failed";
            }
        }

        public List<Course> GetAllCourses()
        {
            return CourseGateway.GetAllCourses();
        }

        public List<SelectListItem> GetAllCoursesForDropDown()
        {
            List<SelectListItem> allCourses = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "--SELECT--",Value = ""
                }
            };
            List<Course> courseList = GetAllCourses();
            foreach (Course course in courseList)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Text = course.Name;
                selectListItem.Value = course.Code;
                allCourses.Add(selectListItem);
            }
            return allCourses;
        }

        public List<StudentCourseView> GetCoursesByStudentId(int studentId)
        {
            return CourseGateway.GetCoursesByStudentId(studentId);
        }
    }
}