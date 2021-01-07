using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class StudentGateway : BaseGateway
    {
        public int Save(Student aStudent)
        {
            string query =
                "INSERT INTO Student(RegNo,Name,Email,ContactNo,Date,Address,DepartmentCode,Flag) VALUES(@regNo,@name,@email,@contactNo,@date,@address,@departmentCode,1)";
            Command = new SqlCommand(query, Connection);
            Command.Parameters.AddWithValue("@regNo", aStudent.RegNo);
            Command.Parameters.AddWithValue("@name", aStudent.Name);
            Command.Parameters.AddWithValue("@email", aStudent.Email);
            Command.Parameters.AddWithValue("@contactNo", aStudent.ContactNo);
            Command.Parameters.AddWithValue("@date", aStudent.Date.ToShortDateString());
            Command.Parameters.AddWithValue("@address", aStudent.Address);
            Command.Parameters.AddWithValue("@departmentCode", aStudent.DepartmentCode);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;

        }

        public bool IsExist(string email)

        {
            string query = "SELECT  * FROM Student WHERE Email=@email";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@email", email);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;

        }

        public string GetTheLastAddedRegNo(string regNo)
        {
            string regNoExist = null;
            string query =
                "SELECT * FROM Student WHERE RegNo LIKE '%"+regNo+"%' AND Id=( SELECT MAX(Id) FROM Student WHERE RegNo LIKE '%"+regNo+"%')";
            Command = new SqlCommand(query,Connection);            
            Connection.Open();
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                regNoExist = Reader["RegNo"].ToString();
            }
            Connection.Close();
            return regNoExist;
        }

        public Student GetStudentByEmail(string email)
        {
            string query = "SELECT *FROM Student WHERE Email = @email";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@email", email);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            Student aStudent = new Student()
            {
                RegNo = Reader["RegNo"].ToString(),
                Name = Reader["Name"].ToString(),
                Email = Reader["Email"].ToString(),
                Address = Reader["Address"].ToString(),
                ContactNo = Reader["ContactNo"].ToString(),
                DepartmentCode = Reader["DepartmentCode"].ToString(),
                Date = Convert.ToDateTime(Reader["Date"])
            };
            Connection.Close();
            return aStudent;
        }

        public List<Student> GetAllStudents()
        {
            List<Student> aList= new List<Student>();
            string query = "SELECT * FROM Student WHERE Flag = 1";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Student aStduent = new Student()
                {
                    Name = Reader["Name"].ToString(),
                    RegNo = Reader["RegNo"].ToString(),
                    DepartmentCode = Reader["DepartmentCode"].ToString(),
                    Date = Convert.ToDateTime(Reader["Date"]),
                    Address = Reader["Address"].ToString(),
                    Email = Reader["Email"].ToString(),
                    ContactNo = Reader["ContactNo"].ToString(),
                    Id = Convert.ToInt32(Reader["Id"])
                };
                aList.Add(aStduent);

            }

            Connection.Close();
            return aList;
        }
        
    }

}