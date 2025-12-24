using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace Tools
{
    public class Connection
    {

        public static string ConnString = "Server=178.157.10.243;Database=valley_site;Uid=valley_site;Pwd=546n9HFUMqJM";

        public static DataTable GetDataTable(string strsql)
        {
            MySqlCommand cmd = new MySqlCommand();
            MySqlConnection conn = new MySqlConnection();
            DataTable dt = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = cmd;
            try
            {
                conn.ConnectionString = ConnString;
                cmd.CommandText = strsql;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = conn;
                da.Fill(dt);
                cmd.Dispose();
            }
            catch (Exception) { }
            finally
            {
                da.Dispose();
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
            }
            return dt;
        }
        //-------------------------------------------------------------------

        public static string GetDataCell(string strsql)
        {
            DataTable table = GetDataTable(strsql);
            if (table.Rows.Count == 0)
            { return null; }
            return table.Rows[0][0].ToString();
        }
        //-------------------------------------------------------------------

        public static DataRow GetDataRow(string strsql)
        {
            MySqlConnection conn = new MySqlConnection();
            MySqlCommand cmd = new MySqlCommand();
            DataRow dr = null;
            DataTable dt = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = cmd;
            try
            {
                conn.ConnectionString = ConnString;
                cmd.CommandText = strsql;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = conn;
                da.Fill(dt);
            }
            catch (Exception) { }
            finally
            {
                cmd.Dispose();
                da.Dispose();
                conn.Close();
                conn.Dispose();
            }
            if (dt.Rows.Count > 0)
            { dr = dt.Rows[0]; }
            return dr;
        }
        //-------------------------------------------------------------------

        public static object ExecuteScaler(string strsql)
        {
            MySqlConnection conn = new MySqlConnection();
            MySqlCommand cmd = new MySqlCommand();
            object result = null;
            try
            {
                conn.ConnectionString = ConnString;
                conn.Open();
                cmd.CommandText = strsql;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = conn;
                result = cmd.ExecuteScalar();
            }
            catch (Exception) { }
            finally
            {
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
            }
            return result;
        }
        //-------------------------------------------------------------------

        public static void ExecuteQuery(string strsql)
        {
            MySqlConnection conn = new MySqlConnection();
            MySqlCommand cmd = new MySqlCommand();
            try
            {
                conn.ConnectionString = ConnString;
                conn.Open();
                cmd.CommandText = strsql;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = conn;
                cmd.ExecuteNonQuery();
            }
            catch (Exception) { }
            finally
            {
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
            }
        }
        //-------------------------------------------------------------------

        public static DataTable GetDataTableSayflama(string strsql, int page, int sayfadakiSayi)
        {
            MySqlCommand cmd = new MySqlCommand();
            MySqlConnection conn = new MySqlConnection();
            DataTable dt = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = cmd;
            try
            {
                if (Convert.ToInt32(page) == 0)
                { page = 1; }
                conn.ConnectionString = ConnString;
                cmd.CommandText = strsql;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = conn;
                da.Fill((page - 1) * (sayfadakiSayi), sayfadakiSayi, dt);
                cmd.Dispose();
            }
            catch { }
            finally
            {
                da.Dispose();
                cmd.Dispose();
                conn.Close();
                conn.Dispose();
            }
            return dt;
        }
        //-------------------------------------------------------------------
    }
}
