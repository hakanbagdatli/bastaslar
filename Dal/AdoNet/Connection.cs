using System.Data.SqlClient;

namespace Dal.AdoNet
{
    public class Connection
    {

        public static string _connection = Utility.Constant.ConnectionString;

        public static SqlConnection StartConnection()
        {
            SqlConnection con = new SqlConnection(_connection);
            return con;
        }

    }
}
