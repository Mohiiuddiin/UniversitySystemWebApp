using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class DepartmentGateway:BaseGateway
    {
        public int Save(Department department)
        {
            string query = "INSERT INTO Department(Code,Name) VALUES (@code,@name)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@code", department.Code);
            Command.Parameters.AddWithValue("@name", department.Name);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

        public bool IsExist(Department department)
        {
            
            string query = "SELECT * FROM Department WHERE Code=@code OR Name=@name";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@code", department.Code);
            Command.Parameters.AddWithValue("@name", department.Name);
            Connection.Open();
            Reader = Command.ExecuteReader();
            Reader.Read();
            bool isExist = Reader.HasRows;
            Connection.Close();
            return isExist;
        }

        public List<Department> GetAllDepartments()
        {
            string query = "SELECT * FROM Department ORDER BY Code";
            Command = new SqlCommand(query,Connection);
            List<Department> departments = new List<Department>();
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Department aDepartment = new Department();
                aDepartment.Code = Reader["Code"].ToString();
                aDepartment.Name = Reader["Name"].ToString();
                departments.Add(aDepartment);
            }
            Connection.Close();
            return departments;
        }
    }
}