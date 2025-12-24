using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class SiteSliders : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.SiteSliders.tableName;

        public static List<Entities.SiteSliders> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT SLD.*
            ,ZCD.Title AS _Language
            FROM " + tableName + @" SLD
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=SLD.LangID
            WHERE isnull(SLD.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.SiteSliders> dataList = new List<Entities.SiteSliders>();
            Entities.SiteSliders data = new Entities.SiteSliders();
            dataList = SelectAnonyMous<Entities.SiteSliders>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

