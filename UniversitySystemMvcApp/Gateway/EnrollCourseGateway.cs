using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class EnrollCourseGateway:BaseGateway
    {
        public int Save(EnrollCourse enrollCourse)
        {
            string query =
                "INSERT INTO EnrollCourse(StudentId,CourseCode,Date,Flag) VALUES(@studentId,@courseCode,@date,1)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", enrollCourse.StudentId);
            Command.Parameters.AddWithValue("@courseCode", enrollCourse.CourseCode);
            Command.Parameters.AddWithValue("@date", enrollCourse.Date);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public bool IsExist(int id, string courseCode)
        {
            string query = "SELECT * FROM EnrollCourse WHERE StudentId=@id AND CourseCode=@courseCode AND Flag=1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@id", id);
            Command.Parameters.AddWithValue("@courseCode", courseCode);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public List<EnrollCourse> GetStudentRegistersById(int studentId)
        {
            List<EnrollCourse> enrollCourses = new List<EnrollCourse>();
            string query = "SELECT * FROM EnrollCourse WHERE StudentId=@studentId AND Flag=1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", studentId);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                EnrollCourse enrollCourse = new EnrollCourse()
                {
                    CourseCode = Reader["CourseCode"].ToString(),
                    Date = Reader["Date"].ToString(),
                    Id = Convert.ToInt32(Reader["Id"]),
                    StudentId = Convert.ToInt32(Reader["StudentId"])
                };
                enrollCourses.Add(enrollCourse);
                
            }
            Connection.Close();
            return enrollCourses;
        }
        
    }
}