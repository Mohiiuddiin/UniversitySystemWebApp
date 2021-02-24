using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversitySystemMvcApp.Gateway;
using UniversitySystemMvcApp.Models;
using Microsoft.AspNet.Identity;

namespace UniversitySystemMvcApp.Controllers
{
    
    public class HomeController : Controller
    {
        public HomeGateway HomeGateway { get; set; }

        public HomeController()
        {
            HomeGateway = new HomeGateway();
        }
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public PartialViewResult UserInformation()
        {            
            RegisterViewModel user = HomeGateway.GetUserById(User.Identity.GetUserId());
            return PartialView(user);
        }
    }
}