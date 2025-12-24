using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Collections;

namespace Dal
{
    public class Inspections : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.Inspections.tableName;

        public static List<Entities.Inspections> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT ISP.*
            ,AGN.Title AS _AgencyName, AGN.RelevantID AS _SaleExecutiveID
            ,CONCAT(USR.Name, ' ' ,USR.Surname) AS _SaleExecutive
            ,STA.Title AS _Statu, STA.Color AS _StatuColor
            ,MRM.Title AS _MeetingRoom
            FROM " + tableName + @" ISP
            LEFT JOIN " + Entities.Agencies.tableName + @" AS AGN ON ISP.AgencyID=AGN.id
            LEFT JOIN " + Entities.zUsers.tableName + @" AS USR ON AGN.RelevantID=USR.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS STA ON ISP.Statu=STA.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS MRM ON ISP.MeetingRoomID=MRM.id
            WHERE isnull(ISP.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.Inspections> dataList = new List<Entities.Inspections>();
            Entities.Inspections data = new Entities.Inspections();
            dataList = SelectAnonyMous<Entities.Inspections>(data, query, _cmdType, keys, vals, con, tran);
            if (dataList.Count > 0)
            {
                foreach (var item in dataList)
                {
                    item._Projects = Dal.GeneralRecords.Select(0, " AND id in (" + item.ProjectID + ")", "", 0, 0, _cmdType, _parmsVals, con, tran).ToList();
                }
            }
            return dataList;
        }
    }
}

