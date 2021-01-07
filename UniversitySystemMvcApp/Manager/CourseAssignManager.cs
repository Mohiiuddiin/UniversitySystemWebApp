using System;
using System.Collections.Generic;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class CourseAssignManager
    {
        private CourseAssignGateway CourseAssignGateway { get; set; }
        private CourseGateway CourseGateway { get; set; }
        private TeacherGateway TeacherGateWay { get; set; }

        public CourseAssignManager()
        {
            CourseAssignGateway = new CourseAssignGateway();
            TeacherGateWay = new TeacherGateway();
            CourseGateway = new CourseGateway();

        }

        public string Save(CourseAssign aCourseAssign)
        {
            if (CourseAssignGateway.IsExist(aCourseAssign.CourseCode))
            {
                return ConstantMessage.courseToTeacherExist;
            }
            else
            {
                if (CourseAssignGateway.Save(aCourseAssign) > 0)
                {
                    TeacherGateWay.UpdateTeacherCreditById(aCourseAssign.TeacherId,
                        CourseGateway.GetCourseByCourseCode(aCourseAssign.CourseCode).Credit);
                    return ConstantMessage.courseAssigned;
                }                                    
            }
            return "Assign Failed";
        }

        public List<CourseStatisticsViewModel> GetAllCoursesInfo()
        {
            List<CourseStatisticsViewModel> aCourseAssignList = CourseAssignGateway.GetAllCourseAssignInfo();
            foreach (CourseStatisticsViewModel aCourse in aCourseAssignList)
            {
                if (aCourse.TeacherName == String.Empty)
                {
                    aCourse.TeacherName = "Not Assigned Yet";
                }
            }
            return aCourseAssignList;
        }

        public string UnassignCourses()
        {
            if (CourseAssignGateway.UnassignAllCourse() > 0)
            {
                return ConstantMessage.unassignAllCourse;
            }
            return "Unassign Failed";
        }
    }
}