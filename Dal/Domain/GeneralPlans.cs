using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class GeneralPlans : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralPlans.tableName;

        public static List<Entities.GeneralPlans> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT PLN.*
            ,REC.Title AS _CategoryName
            ,ZCD.Title AS _Language
            FROM " + tableName + @" PLN
            LEFT JOIN " + Entities.GeneralRecords.tableName + @" AS REC ON PLN.CatID=REC.id
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=PLN.LangID
            WHERE isnull(PLN.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralPlans> dataList = new List<Entities.GeneralPlans>();
            Entities.GeneralPlans data = new Entities.GeneralPlans();
            dataList = SelectAnonyMous<Entities.GeneralPlans>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

