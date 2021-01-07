using System;
using System.Collections.Generic;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class RoomAllocateManager
    {
        private RoomAllocateGateway RoomAllocateGateway { get; set; }

        public RoomAllocateManager()
        {
            RoomAllocateGateway = new RoomAllocateGateway();
        }

        //public string Save(RoomAllocate aRoomAllocate)
        //{
        //    if (RoomAllocateGateway.IsOverlap(aRoomAllocate.Day, aRoomAllocate.RoomNo, aRoomAllocate.From,
        //        aRoomAllocate.To))
        //    {
        //        return ConstantMessage.roomAllocateExist;
        //    }
        //    if (RoomAllocateGateway.Save(aRoomAllocate) > 0)
        //    {
        //        return ConstantMessage.roomAllocateSuccess;
        //    }
        //    return "Allocate Failed";
        //}
        public string Save(RoomAllocate room)
        {
            DateTime to = Convert.ToDateTime(room.To);
            DateTime from = Convert.ToDateTime(room.From);
            if (from > to)
            {
                return "Time is Un-valuable ! (Hint: To time can't less than From time )";
            }
            bool isTimeScheduleValid = IsTimeScheduleValid(room.RoomNo, room.Day, room.From, room.To);

            if (isTimeScheduleValid != true)
            {

                if (RoomAllocateGateway.Save(room) > 0)
                {
                    return "Saved Successfully !";
                }
                return "Failed to save";

            }
            return "Overlapping not allowed";
        }
        private bool IsTimeScheduleValid(int roomNo, string day, string to, string from)
        {
            List<RoomAllocate> schedule = RoomAllocateGateway.GetClassScheduleByStartAndEndingTime(roomNo, day, to, from);

            DateTime startTime = Convert.ToDateTime(to);
            DateTime endTime = Convert.ToDateTime(from);
            foreach (var sd in schedule)
            {
                if ((sd.Day == day && roomNo == sd.RoomNo) &&
                    (startTime < Convert.ToDateTime(sd.From) && endTime > Convert.ToDateTime(sd.From))
                    || (startTime < Convert.ToDateTime(sd.From) && endTime > Convert.ToDateTime(sd.From)) ||
                    (startTime == Convert.ToDateTime(sd.From)) || (Convert.ToDateTime(sd.From) < startTime && Convert.ToDateTime(sd.To) > startTime)
                )
                {
                    return true;
                }

            }
            return false;

        }
        public string GetAllClassScheduleViewsByDeptandCourse(string departmentCode,string courseCode)
        {
            List<ClassScheduleView> classScheduleViews =
                RoomAllocateGateway.GetAllClassScheduleViews().FindAll(x => x.DepartmentCode == departmentCode);
            List<ClassScheduleView> classes = classScheduleViews.FindAll(x => x.CourseCode == courseCode);
            string output = "";
            foreach (ClassScheduleView schedule in classes)
            {

                if (schedule.RoomNo!="")
                {
                    output +="Room No:"+ schedule.RoomNo + ", " + schedule.RoomDay + ", " + schedule.From+"AM" + " - " + schedule.To+"PM" + ";<br />";
                }

                else
                {
                    output = schedule.RoomNo;

                }
            }

            return output;
        }

        public string UnallocateAllRooms()
        {
            if (RoomAllocateGateway.UnallocateAllRooms() > 0)
            {
                return ConstantMessage.unallocateRooms;
            }
            return "Failed unallocating";
        }
    }
}