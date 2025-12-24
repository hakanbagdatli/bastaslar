using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class AgencyCallbacks : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.AgencyCallbacks.tableName;

        public static List<Entities.AgencyCallbacks> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT CLLB.*
            ,AGN.Title AS _AgencyName
            ,CONCAT(USR.Name, ' ' ,USR.Surname) AS _Username
            FROM " + tableName + @" CLLB
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON CLLB.AgencyID=AGN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS USR ON CLLB.CreatedUser=USR.id
            WHERE isnull(CLLB.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.AgencyCallbacks> dataList = new List<Entities.AgencyCallbacks>();
            Entities.AgencyCallbacks data = new Entities.AgencyCallbacks();
            dataList = SelectAnonyMous<Entities.AgencyCallbacks>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

