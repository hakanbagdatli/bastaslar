using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class Assignments : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.Assignments.tableName;

        public static List<Entities.Assignments> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT * FROM " + tableName + " WHERE isnull(isDeleted,0)=0) as tbl where 1=1 ";
            if (id > 0)
                query += " AND id=" + id;
            else
                query += filter;
           
            string[] keys = null;
            object[] vals = null;
            if (_parmsVals != null)
            {
                keys = _parmsVals.Keys.ToArray();
                vals = _parmsVals.Values.ToArray();                
            }
            //---------------------------------------------------------
            string queryForRowCount = " SET dateformat dmy SELECT COUNT(*) FROM (" + query + ") AS tbl";
            rowCountOfQuery = Dal.AdoNet.Select.ScalarByClause(queryForRowCount, keys, vals, con, tran);
            query = " SET dateformat dmy " + query;
            query += " ORDER BY " + sorting;
            //---------------------------------------------------------
            if (rowCount > 0)
                query += " offset " + startIndex + " ROWS fetch next " + rowCount + " ROWS only";
            //---------------------------------------------------------
            List<Entities.Assignments> dataList = new List<Entities.Assignments>();
            Entities.Assignments data = new Entities.Assignments();
            dataList = SelectAnonyMous<Entities.Assignments>(data, query, _cmdType, keys, vals, con, tran);
            foreach (var item in dataList)
            {
                item._Users = Dal.zUsers.Select(0, " AND id in (" + item.UserID + ")", "", 0, 0, _cmdType, _parmsVals, con, tran).ToList();
            }
            return dataList;
        }
    }
}

