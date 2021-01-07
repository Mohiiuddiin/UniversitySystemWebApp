using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(UniversitySystemMvcApp.Startup))]
namespace UniversitySystemMvcApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
