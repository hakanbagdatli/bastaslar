using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class DailyReports : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.DailyReports.tableName;

        public static List<Entities.DailyReports> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT DALY.*
            ,DFN.Title AS _ReportName, DFN.Filename AS _ReportTemp
            ,CONCAT(USR.Name, ' ' ,USR.Surname) AS _Username
            FROM " + tableName + @" DALY
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS DFN ON DALY.ReportID=DFN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS USR ON DALY.CreatedUser=USR.id
            WHERE isnull(DALY.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.DailyReports> dataList = new List<Entities.DailyReports>();
            Entities.DailyReports data = new Entities.DailyReports();
            dataList = SelectAnonyMous<Entities.DailyReports>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

