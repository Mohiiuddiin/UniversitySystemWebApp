using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class TeacherManager
    {
        private TeacherGateway TeacherGateway { get; set; }

        public TeacherManager()
        {
            TeacherGateway=new TeacherGateway();
        }

        public string Save(Teacher aTeacher)
        {
            if (TeacherGateway.IsExist(aTeacher.Email))
            {
                return ConstantMessage.teacherExist;
            }
            else
            {
                if (TeacherGateway.Save(aTeacher) > 0)
                {
                    return ConstantMessage.teacherAddSucess;
                }

            }
            return "Save Failed";
        }

        public List<Teacher> GetAllTeachers()
        {
            return TeacherGateway.GetAllTeachers();
        }

        public List<SelectListItem> GetAllTeacherForDropDown()
        {
            List<SelectListItem> allTeachers = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Value = "",
                    Text = "--SELECT--"
                }
            };
            List<Teacher> teachers = GetAllTeachers();
            foreach (Teacher teacher in teachers)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Value = teacher.Id.ToString();
                selectListItem.Text = teacher.Name;
                allTeachers.Add(selectListItem);
            }
            return allTeachers;
        }

        public Teacher GetTeacherById(int id)
        {
            return TeacherGateway.GetTeacherById(id);
        }

        public void UpdateTeacherById(int id, double credit)
        {
            TeacherGateway.UpdateTeacherCreditById(id, credit);
        }
    }
}