using System;
using System.IO;
using System.Data;
using System.Text;
using System.Collections;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web;

namespace Dal.AdoNet
{
    public class Query : Connection
    {

        const string symbol = Utility.Constant.ParameterSymbol;
        static string dbTwinName = Utility.Constant.dbNameTwin + ".";
        //--------------------------------------------------------- parametre olarak gönderilen dataların başında bulunan simge

        public static string Insert(string tableName, IDictionary _dic, bool hasIdentity)
        {
            string insert = " INSERT INTO " + tableName + "(";
            string values = " VALUES(";

            int i = -1;
            int count = _dic.Count;
            foreach (var item in _dic.Keys)
            {
                i++;
                insert += item.ToString();
                values += symbol + item.ToString();
                if (i + 1 < count)
                {
                    insert += ", ";
                    values += ", ";
                }
            }

            insert += ")";
            values += ")";
            if (hasIdentity)
                values += "  select scope_identity()";
            insert += values;
            return insert;
        }
        //--------------------------------------------------------- standart insert sorgusu

        public static string Update(string tableName, IDictionary _dic)
        {
            string update = " UPDATE " + tableName + " SET ";
            int i = -1;
            string whereClause = "";
            int count = _dic.Count;
            //---------------------------------------------------------
            foreach (var item in _dic.Keys)
            {
                i++;
                if (i == 0)
                {
                    whereClause = " where " + item.ToString() + "=" + symbol + item.ToString();
                    continue;
                }
                //---------------------------------------------------------
                update += item.ToString() + "=" + symbol + item.ToString();
                //---------------------------------------------------------
                if (i + 1 < count)
                    update += ", ";

            }

            update += whereClause;
            return update;
        }
        //--------------------------------------------------------- standart update sorgusu

        public static object Delete(string tableName, int dataID, object con, object tran, bool hasTwin)
        {
            string query = string.Format("DELETE FROM {0} WHERE id={1}", tableName, dataID);
            return Execute(query, tableName, dataID, null, null, con, tran, false, true, hasTwin);
        }
        //--------------------------------------------------------- standart delete sorgusu

        public static object DeleteByClause(string tableName, string whereClause, object con, object tran, bool hasTwin)
        {
            string query = "DELETE FROM " + tableName + " WHERE " + whereClause;
            return Execute(query, tableName, 0, null, null, con, tran, false, true, hasTwin);
        }
        //--------------------------------------------------------- şartlı delete sorgusu

        public static object Execute(string cmdText, string tableName, int dataID, object[] parms, object[] vals, object con, object tran, bool isUpdated, bool isDeleted, bool hasTwin)
        {
            int retId = 0;
            SqlConnection conLocal;
            if (con != null)
                conLocal = (SqlConnection)con;
            else conLocal = new SqlConnection(_connection);


            SqlCommand cmd = new SqlCommand(cmdText, conLocal);
            cmd.CommandTimeout = 0;
            if (tran != null)
                cmd.Transaction = (SqlTransaction)tran;


            if (parms != null)
            {
                for (int i = 0; i < parms.Length; i++)
                {
                    string param = symbol + parms[i].ToString().Replace(symbol, "");
                    object valu = vals[i];
                    if (i == 0 && isUpdated)
                        dataID = Convert.ToInt32(vals[i]);

                    if (valu == null)
                        cmd.Parameters.AddWithValue(param, DBNull.Value);
                    else
                        cmd.Parameters.AddWithValue(param, valu);
                }
            }

            try
            {
                if (con == null)
                {
                    //mutex.WaitOne();
                    if (conLocal.State != ConnectionState.Open)
                        conLocal.Open();
                }


                if (isDeleted) // satır gerçekten silinmişse isDeleted=1 değilse. çalışacak.
                {
                    retId = cmd.ExecuteNonQuery(); // return row effected.   
                }
                else if (isUpdated) // is_delete=1 olduğunda da son satırın delete halini sisteme aktaracak. silindiğini de görebilmek için
                {
                    if (hasTwin)
                        cmd.CommandText += " INSERT INTO " + dbTwinName + tableName + "_ SELECT * FROM " + tableName + " WHERE id=" + dataID;
                    retId = cmd.ExecuteNonQuery(); // return row effected.
                }
                else
                {
                    if (hasTwin)
                        cmd.CommandText += " INSERT INTO " + dbTwinName + tableName + "_ SELECT * FROM " + tableName + " WHERE id= (select SCOPE_IDENTITY())";

                    retId = Convert.ToInt32(cmd.ExecuteScalar());// return value of scope_identity
                }
                cmd.Dispose();
                if (con == null)
                {
                    conLocal.Close();
                    conLocal.Dispose();
                }
            }
            catch (Exception ex)
            {
                string logsPath = HttpContext.Current.Server.MapPath("~/uploads/logs");
                if (!Directory.Exists(logsPath))
                    Directory.CreateDirectory(logsPath);

                using (StreamWriter sw = new StreamWriter(logsPath + "\\log.txt", true, Encoding.UTF8))
                {
                    if (parms != null && parms.Length > 0)
                    {
                        sw.WriteLine("" + ex.ToString() + ", {" + DateTime.Now + "},{");
                        for (int i = 0; i < parms.Length; i++)
                        {
                            sw.WriteLine(parms[i] + "=" + vals[i]);
                        }
                        sw.WriteLine("}");

                    }
                    else
                        sw.WriteLine("2. " + ex.Message + " ,{" + DateTime.Now + "},{" + cmd.CommandText + "}");
                }
                throw;
            }
            finally
            {
                if (con == null)
                {
                    conLocal.Close();
                    conLocal.Dispose();
                }
            }
            return retId;
        }
        //--------------------------------------------------------- sorguyu çalıştır

    }
}