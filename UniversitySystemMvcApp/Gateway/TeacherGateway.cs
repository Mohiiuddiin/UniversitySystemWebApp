using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class TeacherGateway:BaseGateway
    {
        public int Save(Teacher aTeacher)
        {
            string query =
                "INSERT INTO Teacher(Name,Address,Email,ContactNo,DesignationId,DepartmentCode,MaximumCredit,Flag,CreditTaken) VALUES (@name,@address,@email,@contactNo,@designationId,@departmentCode,@maximumCredit,1,0)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@name", aTeacher.Name);
            Command.Parameters.AddWithValue("@address", aTeacher.Address);
            Command.Parameters.AddWithValue("@email", aTeacher.Email);
            Command.Parameters.AddWithValue("@contactNo", aTeacher.ContactNo);
            Command.Parameters.AddWithValue("@designationId", aTeacher.DesignationId);
            Command.Parameters.AddWithValue("@departmentCode", aTeacher.DepartmentCode);
            Command.Parameters.AddWithValue("@maximumCredit", aTeacher.MaximumCredit);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public bool IsExist(string email)
        {
            string query = "SELECT * FROM Teacher WHERE Email=@email AND Flag =1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@email", email);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public List<Teacher> GetAllTeachers()
        {
            List<Teacher> teachers = new List<Teacher>();
            string query = "SELECT * FROM Teacher WHERE Flag=1 ";
            Command = new SqlCommand(query,Connection);           
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Teacher aTeacher = new Teacher();
                aTeacher.Id = Convert.ToInt32(Reader["Id"]);
                aTeacher.Name = Reader["Name"].ToString();
                aTeacher.Address = Reader["Address"].ToString();
                aTeacher.Email = Reader["Email"].ToString();
                aTeacher.ContactNo = Reader["ContactNo"].ToString();
                aTeacher.DepartmentCode = Reader["DepartmentCode"].ToString();
                aTeacher.DesignationId = Convert.ToInt32(Reader["DesignationId"]);
                aTeacher.MaximumCredit = Convert.ToDouble(Reader["MaximumCredit"]);
                aTeacher.CreditTaken = Convert.ToDouble(Reader["CreditTaken"]);
                teachers.Add(aTeacher);
            }
            Connection.Close();
            return teachers;
        }

        public Teacher GetTeacherById(int id)
        {
            string query = "SELECT * FROM Teacher WHERE Id=@id AND Flag =1";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@id", id);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            Teacher aTeacher = new Teacher()
            {
                Name = Reader["Name"].ToString(),
                Email = Reader["Email"].ToString(),
                DesignationId = Convert.ToInt32(Reader["DesignationId"]),
                MaximumCredit = Convert.ToDouble(Reader["MaximumCredit"]),
                ContactNo = Reader["ContactNo"].ToString(),
                DepartmentCode = Reader["DepartmentCode"].ToString(),
                Id = Convert.ToInt32(Reader["Id"]),
                Address = Reader["Address"].ToString(),
                CreditTaken = Convert.ToDouble(Reader["CreditTaken"])
               
            };
            Connection.Close();
            return aTeacher;
        }

        public int UpdateTeacherCreditById(int id,double credit)
        {
            string query = "UPDATE TEACHER SET CreditTaken=CreditTaken+@credit WHERE Id=@id";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@credit", credit);
            Command.Parameters.AddWithValue("@id", id);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }
        
    }
}