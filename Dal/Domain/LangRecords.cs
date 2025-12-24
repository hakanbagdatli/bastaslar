using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class LangRecords : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.LangRecords.tableName;

        public static List<Entities.LangRecords> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT LANG.*
            ,CAT.PageTypeID AS _PageTypeID 
            ,ZCD.Title AS _Language
            FROM " + tableName + @" LANG
            LEFT JOIN " + Entities.GeneralRecords.tableName + @" AS REC ON LANG.CatID=REC.id
            LEFT JOIN " + Entities.GeneralCategories.tableName + @" AS CAT ON REC.CatID=CAT.id
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=LANG.LangID
            WHERE isnull(LANG.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.LangRecords> dataList = new List<Entities.LangRecords>();
            Entities.LangRecords data = new Entities.LangRecords();
            dataList = SelectAnonyMous<Entities.LangRecords>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

