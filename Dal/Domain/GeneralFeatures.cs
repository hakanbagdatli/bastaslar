using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class GeneralFeatures : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralFeatures.tableName;

        public static List<Entities.GeneralFeatures> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT FEA.*
            ,ZCD.Title AS _Language
            FROM " + tableName + @" FEA
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=FEA.LangID
            WHERE isnull(FEA.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralFeatures> dataList = new List<Entities.GeneralFeatures>();
            Entities.GeneralFeatures data = new Entities.GeneralFeatures();
            dataList = SelectAnonyMous<Entities.GeneralFeatures>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

