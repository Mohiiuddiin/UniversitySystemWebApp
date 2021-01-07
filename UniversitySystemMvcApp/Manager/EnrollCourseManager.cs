using System.Collections.Generic;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class EnrollCourseManager
    {
        private EnrollCourseGateway EnrollCourseGateway { get; set; }

        public EnrollCourseManager()
        {
            EnrollCourseGateway = new EnrollCourseGateway();
        }

        public string Save(EnrollCourse enrollCourse)
        {
            if (EnrollCourseGateway.IsExist(enrollCourse.StudentId, enrollCourse.CourseCode))
            {
                return ConstantMessage.courseExist;
            }
            else
            {
                if (EnrollCourseGateway.Save(enrollCourse) > 0)
                {
                    return ConstantMessage.enrollCourseToStudent;
                }                            
            }
            return "Save Failed";
        }

        public List<EnrollCourse> GetStudentRegistersById(int studentId)
        {
            return EnrollCourseGateway.GetStudentRegistersById(studentId);
        }

    }
}