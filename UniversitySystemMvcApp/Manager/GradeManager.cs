using System.Collections.Generic;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;

namespace UniversitySystemMvcApp.Manager
{
    public class GradeManager
    {
        private GradeGateway GradeGateway { get; set; }

        public GradeManager()
        {
            GradeGateway = new GradeGateway();
        }

        public List<SelectListItem> GetAllGradesForDropDown()
        {
            return GradeGateway.GetAllGradesForDropDown();
        }
    }
}