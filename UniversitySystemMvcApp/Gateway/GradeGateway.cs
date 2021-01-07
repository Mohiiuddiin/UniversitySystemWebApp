using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Gateway
{
    public class GradeGateway:BaseGateway
    {
        public List<Grade> GetAllGrades()
        {
            List<Grade> grades = new List<Grade>();
            string query = "SELECT * FROM Grade";
            Command = new SqlCommand(query,Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                Grade grade = new Grade();
                grade.Grades = Reader["Grade"].ToString();
                grades.Add(grade);

            }
            Connection.Close();
            return grades;
        }

        public List<SelectListItem> GetAllGradesForDropDown()
        {
            List<SelectListItem> gradeList = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Value = "", Text = "--SELECT--"
                }
            };
            List<Grade> grades = GetAllGrades();
            foreach (Grade grade in grades)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Value = grade.Grades;
                selectListItem.Text = grade.Grades;
                gradeList.Add(selectListItem);
            }
            return gradeList;

        }
    }
}