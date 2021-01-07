using System.Data.SqlClient;
using System.Web.Configuration;

namespace UniversitySystemMvcApp.Gateway
{
    public class BaseGateway
    {
        public SqlCommand Command { get; set; }
        public SqlConnection Connection { get; set; }
        public SqlDataReader Reader { get; set; }

        public BaseGateway()
        {
            string connectionString =
                WebConfigurationManager.ConnectionStrings["UniversityManagementDB"].ConnectionString;
            Connection = new SqlConnection(connectionString);
        }
    }
}