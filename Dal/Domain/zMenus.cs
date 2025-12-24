using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class zMenus : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.zMenus.tableName;

        public static List<Entities.zMenus> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT MEN.*
            ,CAT.Title AS _CategoryName,CAT.Icon AS _CategoryIcon
            FROM " + tableName + @" MEN
            LEFT JOIN " + Entities.zMenus.tableName + @" AS CAT ON MEN.CatID=CAT.id
            WHERE isnull(MEN.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.zMenus> dataList = new List<Entities.zMenus>();
            Entities.zMenus data = new Entities.zMenus();
            dataList = SelectAnonyMous<Entities.zMenus>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

