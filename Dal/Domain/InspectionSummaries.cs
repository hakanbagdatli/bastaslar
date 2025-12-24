using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class InspectionSummaries : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.InspectionSummaries.tableName;

        public static List<Entities.InspectionSummaries> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT SUMM.*
            ,CONCAT(CUS.Name, ' ', CUS.Surname) AS _CustomerName
            ,REC.Title AS _InterestedProject
            ,AGN.Title AS _AgencyName, AGN.RelevantID AS _SaleExecutiveID
            FROM " + tableName + @" SUMM
            LEFT JOIN " + Entities.Customers.tableName + @" AS CUS ON SUMM.CustomerID=CUS.id
            LEFT JOIN " + Entities.GeneralRecords.tableName + @" AS REC ON SUMM.InterestedProjects=REC.id
            LEFT JOIN " + Entities.Inspections.tableName + @" AS INSP ON INSP.PNRCode=SUMM.InspectionNumber
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON INSP.AgencyID=AGN.id
            WHERE isnull(SUMM.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.InspectionSummaries> dataList = new List<Entities.InspectionSummaries>();
            Entities.InspectionSummaries data = new Entities.InspectionSummaries();
            dataList = SelectAnonyMous<Entities.InspectionSummaries>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

