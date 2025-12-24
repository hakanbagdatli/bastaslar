using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using Utility;

namespace Dal
{
    public class GeneralRecords : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralRecords.tableName;

        public static List<Entities.GeneralRecords> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran, string language = "")
        {
            if (String.IsNullOrEmpty(language))
                language = Feature.ActiveLanguage;
            //---------------------------------------------------------
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT REC.*
            ,CAT.Title AS _CategoryName
            ,CAT.PageTypeID AS _PageTypeID 
            ,LANG.Title AS _Title
            ,LANG.AdditionalTitle AS _AdditionalTitle
            ,LANG.MetaTitle AS _MetaTitle
            ,LANG.MetaUrl AS _MetaUrl
            ,LANG.Description AS _Description
            ,LANG.Keywords AS _Keywords
            ,LANG.Image AS _Image
            ,LANG.Thumbnail AS _Thumbnail
            ,LANG.ShortContent AS _ShortContent
            ,LANG.MainContent AS _MainContent
            ,LANG.Filename AS _Filename
            ,LANG.PropertyPaymentPlan AS _PropertyPaymentPlan
            ,DFNT.Title AS _PropertyType
            ,DFNS.Title AS _PropertyStatu, DFNS.Color AS _PropertyStatuColor
            ,DFNC.Title AS _PropertyCountry
            ,DFNP.Title AS _PropertyProvince
            FROM " + tableName + @" REC
            LEFT JOIN " + Entities.GeneralCategories.tableName + @" AS CAT ON REC.CatID=CAT.id
            LEFT JOIN " + Entities.LangRecords.tableName + @" AS LANG ON LANG.LangID=" + language + @" AND REC.id=LANG.CatID
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS DFNT ON REC.PropertyType=DFNT.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS DFNS ON REC.PropertyStatu=DFNS.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS DFNC ON REC.PropertyCountry=DFNC.id
            LEFT JOIN " + Entities.zDefineDetails.tableName + @" AS DFNP ON REC.PropertyProvince=DFNP.id
            WHERE isnull(REC.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralRecords> dataList = new List<Entities.GeneralRecords>();
            Entities.GeneralRecords data = new Entities.GeneralRecords();
            dataList = SelectAnonyMous<Entities.GeneralRecords>(data, query, _cmdType, keys, vals, con, tran);
            return dataList;
        }
    }
}

