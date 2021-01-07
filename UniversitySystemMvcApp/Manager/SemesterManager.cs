using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Manager
{
    public class SemesterManager
    {
        private SemesterGateway SemesterGateway { get; set; }

        public SemesterManager()
        {
            SemesterGateway = new SemesterGateway();
        }

        public List<Semester> GetAllSemesters()
        {
            return SemesterGateway.GetAllSemester();
        }

        public List<SelectListItem> GetAllSemesterForDropDown()
        {
            List<Semester> semestersList = GetAllSemesters();
            List<SelectListItem> selectListItems = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "--SELECT--",
                    Value = ""
                }
            };
            foreach (Semester sem in semestersList)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Value = sem.Id.ToString();
                selectListItem.Text = sem.Name;
                selectListItems.Add(selectListItem);
            }
            return selectListItems;
        }
    }
}