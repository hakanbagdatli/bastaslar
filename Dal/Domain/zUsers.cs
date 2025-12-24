using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class zUsers : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.zUsers.tableName;

        public static List<Entities.zUsers> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT USR.*
            ,AGN.Title AS _AgencyName
            FROM " + tableName + @" USR
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON USR.CatID=AGN.id
            WHERE isnull(USR.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.zUsers> dataList = new List<Entities.zUsers>();
            Entities.zUsers data = new Entities.zUsers();
            dataList = SelectAnonyMous<Entities.zUsers>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

