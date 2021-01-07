using System;
using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class StudentManager
    {
        private StudentGateway StudentGateway { get; set; }

        public StudentManager()
        {
            StudentGateway = new StudentGateway();
        }

        public string Save(Student aStudent)
        {
            
            aStudent.RegNo = aStudent.DepartmentCode + "-" + aStudent.Date.Year + "-";
            if (StudentGateway.IsExist(aStudent.Email))
            {
                return ConstantMessage.registerStudentExist;
            }
            if(StudentGateway.GetTheLastAddedRegNo(aStudent.RegNo)==null)
            {
                aStudent.RegNo += "001";
                if (StudentGateway.Save(aStudent) > 0)
                {
                    return ConstantMessage.studentRegister;
                }
                
            }
            else
            {
               int counter =
                    Convert.ToInt32(
                        StudentGateway.GetTheLastAddedRegNo(aStudent.RegNo)
                            .Substring((StudentGateway.GetTheLastAddedRegNo(aStudent.RegNo).Length - 3), 3));
                string serial = (counter + 1).ToString();
                if (serial.Length == 1)
                {
                    aStudent.RegNo = aStudent.RegNo + "00" + serial;
                }
                else if (serial.Length == 2)
                {
                    aStudent.RegNo = aStudent.RegNo + "0" + serial;
                }
                else
                {
                    aStudent.RegNo = aStudent.RegNo + serial;
                }
                if (StudentGateway.Save(aStudent)>0)
                {
                    return ConstantMessage.studentRegister;
                }
            }

            return "Save Failed";
        }

        public Student GetStudentByEmail(string email)
        {
            return StudentGateway.GetStudentByEmail(email);
        }

        public List<Student> GetAllStudents()
        {
            return StudentGateway.GetAllStudents();
        }

        public List<SelectListItem> GetAllStudentsForDropdown()
        {
            List<SelectListItem> aList = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "--SELECT--",Value = ""
                }
            };
            List<Student> students = GetAllStudents();
            foreach (Student student in students)
            {
                SelectListItem selectListItem = new SelectListItem()
                {
                    Value = student.Id.ToString(),Text = student.RegNo
                };
                aList.Add(selectListItem);
            }
            return aList;
        }
    }
}