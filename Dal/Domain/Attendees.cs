using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class Attendees : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.Attendees.tableName;

        public static List<Entities.Attendees> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT ATT.*
            ,AGN.id AS _AgencyID,AGN.Title AS _AgencyName, AGN.RelevantID AS _SaleExecutiveID
            ,CONCAT(USR.Name, ' ' ,USR.Surname) AS _SaleExecutive
            FROM " + tableName + @" ATT
            INNER JOIN " + Entities.Inspections.tableName + @" AS ISP ON ATT.InspectionNumber=ISP.PNRCode
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON ISP.AgencyID=AGN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS USR ON AGN.RelevantID=USR.id
            WHERE isnull(ATT.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.Attendees> dataList = new List<Entities.Attendees>();
            Entities.Attendees data = new Entities.Attendees();
            dataList = SelectAnonyMous<Entities.Attendees>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

