using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class DesignationGateway:BaseGateway
    {
        public List<Designation> GetAllDesignations()
        {
            List<Designation> allDesignations = new List<Designation>();
            string query = "SELECT * FROM Designation";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Designation aDesignation = new Designation();
                aDesignation.Id = Convert.ToInt32(Reader["Id"]);
                aDesignation.Name = Reader["Name"].ToString();
                allDesignations.Add(aDesignation);
            }
            Connection.Close();
            return allDesignations;
        }
    }
}