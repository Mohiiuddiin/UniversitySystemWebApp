using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class HomeGateway : BaseGateway
    {
        public RegisterViewModel GetUserById(string userId)
        {            
            string query = "SELECT * FROM AspNetUsers WHERE Id=@userId";
            Command = new SqlCommand(query, Connection);
            Command.Parameters.AddWithValue("@userId", userId);
            RegisterViewModel user = null;
            Connection.Open();            
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {                
                while (Reader.Read())
                {
                    user = new RegisterViewModel()
                    {
                        FirstName = Reader["FirstName"].ToString(),
                        LastName = Reader["LastName"].ToString(),
                        ContactNo = Reader["ContactNo"].ToString(),
                        Email = Reader["Email"].ToString()
                    };
                    
                }
            }
            else
            {
                user = new RegisterViewModel();
            }
            Connection.Close();
            return user;
        }
    }
}