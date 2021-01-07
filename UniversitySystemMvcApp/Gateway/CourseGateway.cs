using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Gateway
{
    public class CourseGateway:BaseGateway
    {
        public int Save(Course aCourse)
        {
            string query =
                "INSERT INTO Course (Code,DepartmentCode,SemesterId,Name,Credit,Description,Flag) VALUES(@code,@departmentCode,@semesterId,@name,@credit,@description,1)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@code", aCourse.Code);
            Command.Parameters.AddWithValue("@departmentCode", aCourse.DepartmentCode);
            Command.Parameters.AddWithValue("@semesterId", aCourse.SemesterId);
            Command.Parameters.AddWithValue("@name", aCourse.Name);
            Command.Parameters.AddWithValue("@credit", aCourse.Credit);
            Command.Parameters.AddWithValue("@description", aCourse.Description);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public bool IsExist(Course aCourse)
        {
            string query = "SELECT * FROM Course WHERE Code=@code OR Name=@name AND Flag=1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@code", aCourse.Code);
            Command.Parameters.AddWithValue("@name", aCourse.Name);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public List<Course> GetAllCourses()
        {
            List<Course> courseList = new List<Course>();
            string query = "SELECT * FROM Course WHERE Flag =1";
            Command = new SqlCommand(query,Connection);
            
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Course aCourse = new Course();
                aCourse.Code = Reader["Code"].ToString();
                aCourse.Credit = Convert.ToDouble(Reader["Credit"]);
                aCourse.Name = Reader["Name"].ToString();
                aCourse.DepartmentCode = Reader["DepartmentCode"].ToString();
                aCourse.Description = Reader["Description"].ToString();
                aCourse.SemesterId = Convert.ToInt32(Reader["SemesterId"]);
                courseList.Add(aCourse);
            }
            Connection.Close();
            return courseList;
        }

        public Course GetCourseByCourseCode(string courseCode)
        {
            string query = "SELECT * FROM Course WHERE Code=@courseCode AND Flag=1 ORDER BY Code";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@courseCode", courseCode);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            Course aCourse = new Course()
            {
                Credit = Convert.ToDouble(Reader["Credit"])
            };
            Connection.Close();
            return aCourse;
        }

        public List<StudentCourseView> GetCoursesByStudentId(int studentId)
        {
            List<StudentCourseView> courseList;
            string query = "SELECT * FROM StudentCourseView WHERE StudentId=@studentId AND Flag =1 ORDER BY CourseCode";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", studentId);
            Connection.Open();
            courseList = null;
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                courseList = new List<StudentCourseView>();
                while (Reader.Read())
                {
                    StudentCourseView aCourse = new StudentCourseView()
                    {
                        StudentId = Convert.ToInt32(Reader["StudentId"]),
                        CourseCode = Reader["CourseCode"].ToString(),
                        CourseName = Reader["CourseName"].ToString(),
                        StudentRegId = Convert.ToInt32(Reader["StudentRegId"])

                    };
                    courseList.Add(aCourse);
                }
            }
            Connection.Close();
            return courseList;
        }
    }
}