using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Manager
{
    public class RoomManager
    {
        private RoomGateway RoomGateway { get; set; }

        public RoomManager()
        {
            RoomGateway = new RoomGateway();
        }

        public List<SelectListItem> GetAllRoomsForDropDown()
        {
            List<SelectListItem> roomList = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "--SELECT--",
                    Value=""
                }
            };
            List<Room> rooms = RoomGateway.GetAllRooms();
            foreach (Room room in rooms)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Text = room.RoomNo.ToString();
                selectListItem.Value = room.RoomNo.ToString();
                roomList.Add(selectListItem);
            }
            return roomList;
        }
    }
}