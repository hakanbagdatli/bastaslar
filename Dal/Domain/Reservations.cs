using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class Reservations : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.Reservations.tableName;

        public static List<Entities.Reservations> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT RES.*
            ,REC.Title AS _ProjectName
            ,PLN.Title AS _PlanName
            ,INS.PNRCode AS _InspectionNumber
            ,AGN.Title AS _AgencyName, AGN.RelevantID AS _SaleExecutiveID
            ,CONCAT(RUSR.Name, ' ' ,RUSR.Surname) AS _SaleExecutive
            ,CUS.Name AS _CustomerName, CUS.Surname AS _CustomerSurname, CUS.Email AS _CustomerEmail, CUS.Phone AS _CustomerPhone, CUS.Country AS _CustomerCountry
            ,STA.Title AS _Statu, STA.Color AS _StatuColor
            FROM " + tableName + @" RES
            LEFT JOIN " + Entities.Inspections.tableName + @" AS INS ON RES.InspectionNumber=INS.id
            LEFT JOIN " + Entities.GeneralRecords.tableName + @" AS REC ON RES.ProjectID=REC.id
            LEFT JOIN " + Entities.GeneralPlans.tableName + @" AS PLN ON RES.PlanID=PLN.id
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON RES.AgencyID=AGN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS RUSR ON AGN.RelevantID=RUSR.id
            LEFT JOIN " + Entities.Customers.tableName + @" AS CUS ON RES.CustomerID=CUS.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS STA ON RES.Statu=STA.id
            WHERE isnull(RES.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.Reservations> dataList = new List<Entities.Reservations>();
            Entities.Reservations data = new Entities.Reservations();
            dataList = SelectAnonyMous<Entities.Reservations>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

