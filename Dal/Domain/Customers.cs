using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class Customers : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.Customers.tableName;

        public static List<Entities.Customers> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT CUS.*
            ,AGN.Title AS _AgencyName, AGN.RelevantID AS _SaleExecutiveID
            ,CONCAT(USR.Name, ' ' ,USR.Surname) AS _SaleExecutive
            FROM " + tableName + @" CUS
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON CUS.AgencyID=AGN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS USR ON AGN.RelevantID=USR.id
            WHERE isnull(CUS.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.Customers> dataList = new List<Entities.Customers>();
            Entities.Customers data = new Entities.Customers();
            dataList = SelectAnonyMous<Entities.Customers>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

