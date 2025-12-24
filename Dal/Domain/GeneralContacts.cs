using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class GeneralContacts : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralContacts.tableName;

        public static List<Entities.GeneralContacts> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT CNT.*
            ,CAT.Title AS _CategoryName
            FROM " + tableName + @" CNT
            INNER JOIN " + Entities.GeneralCategories.tableName + @" AS CAT ON CNT.CatID=CAT.id
            WHERE isnull(CNT.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralContacts> dataList = new List<Entities.GeneralContacts>();
            Entities.GeneralContacts data = new Entities.GeneralContacts();
            dataList = SelectAnonyMous<Entities.GeneralContacts>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

