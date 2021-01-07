using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using UniversitySystemMvcApp.Utility;

namespace UniversitySystemMvcApp.Manager
{
    public class DepartmentManager
    {
        private DepartmentGateway DepartmentGateway { get; set; }

        public DepartmentManager()
        {
            DepartmentGateway = new DepartmentGateway();
        }

        public string Save(Department department)
        {
            if (DepartmentGateway.IsExist(department))
            {
                return ConstantMessage.departmentAlreadyExist;
            }
            else
            {
                int rowEffect = DepartmentGateway.Save(department);
                if (rowEffect > 0)
                {
                    return ConstantMessage.saveSuccessfulDepartment;
                }
            }

            return "Save Failed";
        }


        public List<Department> GetAllDepartments()
        {
            return DepartmentGateway.GetAllDepartments();
        }

        public List<SelectListItem> GetAllDepartmentsForDropDown()
        {
            List<Department> departments = GetAllDepartments();
            List<SelectListItem> selectListItems = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Value = "",
                    Text = "--SELECT--"
                }
            };
            foreach (Department department in departments)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Value = department.Code;
                selectListItem.Text = department.Name;
                selectListItems.Add(selectListItem);
            }
            return selectListItems;
        }
    }
}