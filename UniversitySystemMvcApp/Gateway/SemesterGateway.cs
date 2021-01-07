using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class SemesterGateway:BaseGateway
    {
        public List<Semester> GetAllSemester()
        {
            List<Semester> semesters = new List<Semester>();
            string query = "SELECT * FROM Semester";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Semester aSemester = new Semester();
                aSemester.Id = Convert.ToInt32(Reader["Id"]);
                aSemester.Name = Reader["Name"].ToString();
                semesters.Add(aSemester);
            }
            Connection.Close();
            return semesters;
        }
    }
}