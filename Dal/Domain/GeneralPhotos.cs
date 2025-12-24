using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class GeneralPhotos : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralPhotos.tableName;

        public static List<Entities.GeneralPhotos> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT GAL.*
            ,PLN.Title AS _PropertyName
            ,ZCD.Title AS _Language
            FROM " + tableName + @" GAL
            LEFT JOIN " + Entities.GeneralPlans.tableName + @" AS PLN ON GAL.PropertyID=PLN.id
            LEFT JOIN " + Entities.zLangCodes.tableName + @" AS ZCD ON ZCD.id=GAL.LangID
            WHERE isnull(GAL.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralPhotos> dataList = new List<Entities.GeneralPhotos>();
            Entities.GeneralPhotos data = new Entities.GeneralPhotos();
            dataList = SelectAnonyMous<Entities.GeneralPhotos>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

