using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;

namespace UniversitySystemMvcApp.Gateway
{
    public class RoomAllocateGateway:BaseGateway
    {
        public int Save(RoomAllocate aRoomAllocate)
        {
            string query =
                "INSERT INTO RoomAllocate(DepartmentCode,CourseCode,RoomNo,Day,[From],[To],Flag)VALUES(@departmentCode,@courseCode,@roomNo,@day,@from,@to,@flag)";
            Command = new SqlCommand(query,Connection);
            Command.Parameters.AddWithValue("@departmentCode", aRoomAllocate.DepartmentCode);
            Command.Parameters.AddWithValue("@courseCode", aRoomAllocate.CourseCode);
            Command.Parameters.AddWithValue("@roomNo", aRoomAllocate.RoomNo);
            Command.Parameters.AddWithValue("@day", aRoomAllocate.Day);
            Command.Parameters.AddWithValue("@from", aRoomAllocate.From);
            Command.Parameters.AddWithValue("@to", aRoomAllocate.To);
            Command.Parameters.AddWithValue("@flag", 1);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();

            Connection.Close();
            return rowEffect;
        }
        public List<RoomAllocate> GetClassScheduleByStartAndEndingTime(int roomNo, string day, string to, string from)
        {
           
               string query = "Select * from RoomAllocate Where Day='" + day + "' AND RoomNo=" + roomNo + " AND Flag=" + 1;
                List<RoomAllocate> classSchedules = new List<RoomAllocate>();
                Command = new SqlCommand(query, Connection);
                Connection.Open();
                Reader = Command.ExecuteReader();
                while (Reader.Read())
                {
                    RoomAllocate room = new RoomAllocate()
                    {
                        Id = Convert.ToInt32(Reader["Id"].ToString()),
                        DepartmentCode = Reader["DepartmentCode"].ToString(),
                        CourseCode = Reader["CourseCode"].ToString(),
                        RoomNo = Convert.ToInt32(Reader["RoomNo"].ToString()),
                        Day = Reader["Day"].ToString(),
                        To = Reader["To"].ToString(),
                        From =Reader["From"].ToString()

                    };
                    classSchedules.Add(room);
                }
                Reader.Close();
                Connection.Close();
                return classSchedules;
        }
        public List<ClassScheduleView> GetAllClassScheduleViews()
        {
            List<ClassScheduleView> allClassScheduleViews = new List<ClassScheduleView>();
            string query = "SELECT * FROM ClassScheduleView WHERE Flag = 1 ";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                ClassScheduleView aClassScheduleView = new ClassScheduleView()
                {
                    RoomNo = (Reader["RoomNo"]).ToString(),
                    DepartmentCode = Reader["DepartmentCode"].ToString(),
                    CourseCode = Reader["CourseCode"].ToString(),
                    CourseName = Reader["CourseName"].ToString(),
                    From = Reader["FromTime"].ToString(),
                    To = Reader["ToTime"].ToString(),
                    RoomDay = Reader["RoomDay"].ToString()                                      
                };
                allClassScheduleViews.Add(aClassScheduleView);                                 
            }
            Connection.Close();
            return allClassScheduleViews;
        }

        public int UnallocateAllRooms()
        {
            string query = "UPDATE ClassScheduleView SET Flag = 0";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            int rowEffect = Command.ExecuteNonQuery();
            Connection.Close();
            return rowEffect;
        }

    }
}