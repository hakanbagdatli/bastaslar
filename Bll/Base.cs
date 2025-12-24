using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.ComponentModel;

namespace Bll
{
    public class Base
    {
        public static object Save(Entities.IEntity entry, object Connection = null, object tran = null)
        {
            object donen = Dal.Base.Save(entry, entry._TableName, Connection, tran);
            var idProp = entry.GetType().GetProperty("id");
            if (idProp == null)
                return donen;
            return donen;
        }
        //---------------------------------------------------------


        public static object DirectSave(string tableName, bool insert, Entities.Items.RootData entry, object con = null, object tran = null)
        {
            return Dal.Base.SaveDirect(tableName, insert, entry, con, tran);
        }
        //---------------------------------------------------------

        public static void SaveMultiple<T>(List<T> entry, string tableName, object con = null, object tran = null)
        {
            foreach (var item in entry)
            {
                Dal.Base.Save(item, tableName, con, tran);
            }
        }
        //---------------------------------------------------------

        public static object Delete(int anaId, string tableName, object con = null, object tran = null)
        {
            return Dal.Base.Delete(tableName, anaId, con, tran);
        }
        //---------------------------------------------------------

        public static object DeleteByClause(string tableName, string where, object con = null, object tran = null)
        {
            return Dal.Base.DeleteByClause(tableName, where, con, tran);
        }
        //---------------------------------------------------------

        public static SqlDataReader GetDataReader(string query, CommandType _commandType, object[] parms, object[] values, SqlTransaction tran, SqlConnection con)
        {
            return Dal.Base.DataReader(query, _commandType, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static DataTable GetDataTable(string query, CommandType _commandType, object[] parms, object[] values, SqlTransaction tran = null, SqlConnection con = null)
        {
            return Dal.Base.DataTable(query, _commandType, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static object ExecuteQuery(string cmdText, string tableName, int dataID = 0, object[] parms = null, object[] vals = null, object con = null, object tran = null, bool isUpdated = false, bool isDeleted = false, bool hasTwin = true)
        {
            return Dal.AdoNet.Query.Execute(cmdText, tableName, dataID, parms, vals, con, tran, isUpdated, isDeleted, hasTwin);
        }
        //---------------------------------------------------------

        public static int RowCount(string filter, string tableName, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return Dal.Base.RowCount(tableName, filter, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static int RowCountByClause(string filter, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return Dal.Base.RowCountByClause(filter, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static DataTable ListToExcel<T>(IList<T> _list)
        {
            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            DataTable dt = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                dt.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in _list)
            {
                DataRow row = dt.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                dt.Rows.Add(row);
            }
            return dt;

        }
        //---------------------------------------------------------

    }
}
