using System;
using System.Collections.Generic;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Models.ViewModels;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class StudentResultManager
    {
        private StudentResultGateway StudentResultGateway { get; set; }

        public StudentResultManager( )
        {
            StudentResultGateway = new StudentResultGateway();
        }

        public string Save(StudentResult aStudentResult)
        {
            if (StudentResultGateway.IsExist(aStudentResult))
            {
                int rowEffect = StudentResultGateway.UpdateByCourseAndId(aStudentResult);
                if (rowEffect > 0)
                {
                    return ConstantMessage.studentResultSaved;
                }
            }
            else
            {
                if (StudentResultGateway.Save(aStudentResult) > 0)
                {
                    return ConstantMessage.studentResultSaved;
                }
                
            }           
            return "Failed to Save";
        }

        public List<StudentResultView> GetResultsById(int id)
        {
            List<StudentResultView> aStudentResultViews = StudentResultGateway.GetAllResultViewsById(id);
            foreach (StudentResultView aView in aStudentResultViews)
            {
                if (aView.Grade == String.Empty)
                {
                    aView.Grade = "Not Graded Yet";
                }
            }
            return aStudentResultViews;
        }
    }
}