using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;

namespace UniversitySystemMvcApp.Manager
{
    public class DesignationManager
    {
        private DesignationGateway DesignationGateway { get; set; }

        public DesignationManager( )
        {
            DesignationGateway = new DesignationGateway();
        }

        public List<Designation> GetAllDesignations()
        {
            return DesignationGateway.GetAllDesignations();
        }

        public List<SelectListItem> GetAllDesognationForDropDown()
        {
            List<SelectListItem> allDesignations = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Value = "",
                    Text = "--SELECT--"

                }
            };
            List<Designation> designations = GetAllDesignations();
            foreach (Designation designation in designations)
            {
                SelectListItem selectListItem = new SelectListItem();
                selectListItem.Value = designation.Id.ToString();
                selectListItem.Text = designation.Name;
                allDesignations.Add(selectListItem);
            }
            return allDesignations;
        }

    }
}