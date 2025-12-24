using System;
using System.Data;
using System.Data.SqlClient;

namespace Dal.AdoNet
{
    /// <summary>
    /// return değeri -1 ise hata verildi demektir.
    /// </summary>
    /// <param name="cmdText"></param>
    /// <param name="con"></param>
    /// <param name="tran"></param>
    /// <returns></returns>
    
    public class Select : Connection
    {
        const string _symbol = Utility.Constant.ParameterSymbol;

        public static string Query(string tabloAdi, object[] alanAdlari, object[] joins, object[] where)
        {
            string text = Utility.Constant.SetDateFormat + " SELECT ";
            for (int i = 0; i < alanAdlari.Length; i++)
            {
                text += alanAdlari[i];
                if (i + 1 < alanAdlari.Length)
                    text += ",";
            }
            text += " FROM " + tabloAdi;
            if (joins != null)
            {
                for (int i = 0; i < joins.Length; i++)
                {
                    text += " " + joins[i];
                }
            }
            if (where != null)
            {
                for (int i = 0; i < where.Length; i++)
                {
                    text += " " + where[i];
                }
            }
            return text;

        }
        //---------------------------------------------------------

        public static DataTable DataTable(string cmdText, System.Data.CommandType _commType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            SqlConnection conLocal;
            if (con == null)
                conLocal = new SqlConnection(_connection);
            else conLocal = (SqlConnection)con;

            SqlCommand cmd = new SqlCommand(cmdText, conLocal);
            cmd.CommandType = _commType;
            if (tran != null)
                cmd.Transaction = (SqlTransaction)tran;


            if (parms != null)
            {
                SqlParameter[] pars = new SqlParameter[parms.Length];

                for (int i = 0; i < parms.Length; i++)
                {
                    string param = _symbol + parms[i].ToString().Replace(_symbol, "");
                    object valu = values[i];
                    if (valu == null)
                        pars[i] = new SqlParameter(param.ToString(), DBNull.Value);
                    else
                    {
                        var dataType = valu.GetType();
                        if (dataType.Name == "DateTime")
                        {
                            pars[i] = new SqlParameter(param.ToString(), SqlDbType.DateTime);
                            pars[i].Value = valu;
                        }
                        else
                            pars[i] = new SqlParameter(param.ToString(), valu);
                    }
                }

                for (int i = 0; i < pars.Length; i++)
                    cmd.Parameters.Add(pars[i]);
            }

            SqlDataAdapter adap = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adap.Fill(dt);
            return dt;
        }
        //---------------------------------------------------------

        public static SqlDataReader DataReader(string cmdText, System.Data.CommandType _cmdType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            try
            {
                SqlConnection conLocal;
                if (con == null)
                    conLocal = new SqlConnection(_connection);
                else conLocal = (SqlConnection)con;

                SqlCommand cmd = new SqlCommand(cmdText, conLocal);
                cmd.CommandTimeout = 0;
                cmd.CommandType = _cmdType;
                if (tran != null)
                    cmd.Transaction = (SqlTransaction)tran;

                if (parms != null)
                {

                    SqlParameter[] pars = new SqlParameter[parms.Length];

                    for (int i = 0; i < parms.Length; i++)
                    {
                        string param = _symbol + parms[i].ToString().Replace(_symbol, "");
                        object valu = values[i];
                        if (valu == null)
                            pars[i] = new SqlParameter(param.ToString(), DBNull.Value);
                        else
                        {
                            var dataType = valu.GetType();
                            if (dataType.Name == "DateTime")
                            {
                                pars[i] = new SqlParameter(param.ToString(), SqlDbType.DateTime);
                                pars[i].Value = valu;
                            }
                            else
                                pars[i] = new SqlParameter(param.ToString(), valu);
                        }
                    }

                    for (int i = 0; i < pars.Length; i++)
                        cmd.Parameters.Add(pars[i]);
                }
                if (con == null)
                {
                    if (conLocal.State != ConnectionState.Open)
                        conLocal.Open();
                }
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                //.Datareader için hasrow un çalışabilmesi için bunu kullanmak gerekiyor.
                // burada connection askıda kalıyor.
                return dr;
            }
            catch (Exception ex)
            {
                string exMessage = ex.Message.ToString();
                throw;
            }
        }
        //---------------------------------------------------------

        public static int Scalar(string cmdText, object con = null, object tran = null)
        {
            int sayi = -1;


            SqlConnection conLocal;
            if (con == null)
                conLocal = new SqlConnection(_connection);
            else conLocal = (SqlConnection)con;

            SqlCommand cmd = new SqlCommand(cmdText, conLocal);

            if (tran != null)
                cmd.Transaction = (SqlTransaction)tran;


            if (con == null)
            {
                if (conLocal.State != ConnectionState.Open)
                    conLocal.Open();
            }
            sayi = Convert.ToInt32(cmd.ExecuteScalar());

            if (con == null)
                conLocal.Close();

            return sayi;
        }
        //---------------------------------------------------------

        public static int ScalarByClause(string cmdText, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            int sayi = -1;


            SqlConnection conLocal;
            if (con == null)
                conLocal = new SqlConnection(_connection);
            else conLocal = (SqlConnection)con;

            SqlCommand cmd = new SqlCommand(cmdText, conLocal);

            if (tran == null)
                cmd.Transaction = (SqlTransaction)tran;

            if (parms != null)
            {
                SqlParameter[] pars = new SqlParameter[parms.Length];

                for (int i = 0; i < parms.Length; i++)
                {
                    string param = _symbol + parms[i].ToString().Replace(_symbol, "");
                    object valu = values[i];
                    if (valu == null)
                        pars[i] = new SqlParameter(param.ToString(), DBNull.Value);
                    else
                    {
                        var dataType = valu.GetType();
                        if (dataType.Name == "DateTime")
                        {
                            pars[i] = new SqlParameter(param.ToString(), SqlDbType.DateTime);
                            pars[i].Value = valu;
                        }
                        else
                            pars[i] = new SqlParameter(param.ToString(), valu);
                    }
                }

                for (int i = 0; i < pars.Length; i++)
                    cmd.Parameters.Add(pars[i]);
            }

            if (con == null)
            {
                if (conLocal.State != ConnectionState.Open)
                    conLocal.Open();
            }
            sayi = Convert.ToInt32(cmd.ExecuteScalar());

            if (con == null)
                conLocal.Close();

            return sayi;
        }
        //---------------------------------------------------------

        public static int RowCount(string tableName, string filter, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            string query = "SET dateformat dmy SELECT COUNT(*) FROM " + tableName + " WHERE isnull(isDeleted,0)=0  ";
            if (filter != "")
                query += filter;
            return ScalarByClause(query, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static int RowCountByClause(string query, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return ScalarByClause(query, parms, values, con, tran);
        }
        //---------------------------------------------------------

    }
}