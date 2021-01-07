using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Gateway
{
    public class StudentResultGateway:BaseGateway
    {
        public int Save(StudentResult aStudentResult)
        {
            string query =
                "INSERT INTO StudentResult(StudentId,CourseCode,GradeCode,Flag) VALUES(@studentId,@courseCode,@gradeCode,1)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", aStudentResult.StudentId);
            Command.Parameters.AddWithValue("@courseCode", aStudentResult.CourseCode);
            Command.Parameters.AddWithValue("@gradeCode", aStudentResult.GradeCode);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public bool IsExist(StudentResult aStudentResult)
        {
            string query = "SELECT * FROM StudentResult WHERE StudentId=@studentId AND CourseCode=@courseCode";
            Command= new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", aStudentResult.StudentId);
            Command.Parameters.AddWithValue("@courseCode", aStudentResult.CourseCode);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public int UpdateByCourseAndId(StudentResult aStudentResult)
        {
            string query =
                "UPDATE StudentResult SET GradeCode=@gradeCode WHERE StudentId=@studentId AND CourseCode =@courseCode";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@gradeCode", aStudentResult.GradeCode);
            Command.Parameters.AddWithValue("@studentId", aStudentResult.StudentId);
            Command.Parameters.AddWithValue("@courseCode", aStudentResult.CourseCode);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public List<StudentResultView> GetAllResultViewsById(int id)
        {
            List<StudentResultView> aStudentResultViews = new List<StudentResultView>();
            string query = "SELECT * FROM StudentResultView WHERE StudentId=@studentId";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@studentId", id);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                StudentResultView studentResultView = new StudentResultView()
                {
                    Grade = Reader["GradeCode"].ToString(),
                    CourseCode = Reader["CourseCode"].ToString(),
                    Name = Reader["Name"].ToString(),
                    StudentId = Convert.ToInt32(Reader["StudentId"])
                    
                   
                };
                aStudentResultViews.Add(studentResultView);
            }
            Connection.Close();
            return aStudentResultViews;
        }
    }
}