using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class GeneralVideos : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralVideos.tableName;

        public static List<Entities.GeneralVideos> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT VID.*
            ,ZCD.Title AS _Language
            FROM " + tableName + @" VID
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=VID.LangID
            WHERE isnull(VID.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralVideos> dataList = new List<Entities.GeneralVideos>();
            Entities.GeneralVideos data = new Entities.GeneralVideos();
            dataList = SelectAnonyMous<Entities.GeneralVideos>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

