using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Gateway
{
    public class CourseAssignGateway:BaseGateway
    {
        public int Save(CourseAssign aCourseAssign)
        {
            string query =
                "INSERT INTO CourseAssigned(DepartmentCode,TeacherId,CourseCode,Flag) VALUES(@departmentCode,@teacherId,@courseCode,1)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@departmentCode", aCourseAssign.DepartmentCode);
            Command.Parameters.AddWithValue("@teacherId", aCourseAssign.TeacherId);
            Command.Parameters.AddWithValue("@courseCode", aCourseAssign.CourseCode);
            
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;

        }

        public bool IsExist(string courseCode)
        {
            string query = "SELECT * FROM CourseAssigned WHERE CourseCode=@courseCode AND Flag=1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@courseCode", courseCode);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public List<CourseStatisticsViewModel> GetAllCourseAssignInfo()
        {
            List<CourseStatisticsViewModel> allCourseList = new List<CourseStatisticsViewModel>();
            string query = "SELECT * FROM CourseStatisticsView WHERE Flag =1";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                CourseStatisticsViewModel aCourseStatisticsViewModel = new CourseStatisticsViewModel();

                aCourseStatisticsViewModel.CourseCode = Reader["CourseCode"].ToString();
                aCourseStatisticsViewModel.DepartmentCode = Reader["DepartmentCode"].ToString();
                aCourseStatisticsViewModel.CourseName = Reader["CourseName"].ToString();
                aCourseStatisticsViewModel.SemesterName = Reader["SemesterName"].ToString();
                aCourseStatisticsViewModel.TeacherName = Reader["TeacherName"].ToString();
                aCourseStatisticsViewModel.Description = Reader["Description"].ToString();
                aCourseStatisticsViewModel.SemesterId = Convert.ToInt32(Reader["SemesterId"]);
               
                    
                
                allCourseList.Add(aCourseStatisticsViewModel);
            }
            Connection.Close();
            return allCourseList;
        }

        public int UnassignAllCourse()
        {
            string query = "UPDATE CourseStatisticsView SET Flag=0";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }
    }
}