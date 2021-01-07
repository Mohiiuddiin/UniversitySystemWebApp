using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class RoomGateway:BaseGateway
    {
        public List<Room> GetAllRooms()
        {
            List<Room> allRooms = new List<Room>();
            string query = "SELECT * FROM Room";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Room aRoom = new Room();
                aRoom.RoomNo = Convert.ToInt32(Reader["RoomNo"]);
                allRooms.Add(aRoom);
            }
            Connection.Close();
            return allRooms;
        }
    }
}