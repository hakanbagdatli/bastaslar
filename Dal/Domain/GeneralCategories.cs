using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using Utility;

namespace Dal
{
    public class GeneralCategories : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = Entities.GeneralCategories.tableName;

        public static List<Entities.GeneralCategories> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran, string language = "")
        {
            if (String.IsNullOrEmpty(language))
                language = Feature.ActiveLanguage;
            //---------------------------------------------------------
            if (String.IsNullOrEmpty(sorting))
                sorting = " id ASC ";
            //---------------------------------------------------------
            string query = @" 
            SELECT * FROM (
            SELECT CAT.*
            ,(SELECT COUNT(*) FROM " + tableName + @" AS Sub WHERE Sub.CatID=CAT.id AND Sub.isTopMenu=1 AND Sub.Approved=1) AS _SubCategoryCount
            ,LANG.Title AS _Title
            ,LANG.AdditionalTitle AS _AdditionalTitle
            ,LANG.MetaTitle AS _MetaTitle
            ,LANG.MetaUrl AS _MetaUrl
            ,LANG.Description AS _Description
            ,LANG.Keywords AS _Keywords
            ,LANG.Image AS _Image
            ,LANG.Thumbnail AS _Thumbnail
            ,LANG.BannerImage AS _BannerImage
            ,LANG.ShortContent AS _ShortContent
            ,LANG.MainContent AS _MainContent
            ,LANG.Filename AS _Filename
            ,STYP.Sorting AS _SortingType
            FROM " + tableName + @" CAT
            LEFT JOIN " + Entities.zSortingType.tableName + @" AS STYP ON CAT.SortingType=STYP.id
            LEFT JOIN " + Entities.LangCategories.tableName + @" AS LANG ON LANG.LangID=" + language + @" AND LANG.CatID=CAT.id
            WHERE isnull(CAT.isDeleted,0)=0) as tbl where 1=1 ";
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
            List<Entities.GeneralCategories> dataList = new List<Entities.GeneralCategories>();
            Entities.GeneralCategories data = new Entities.GeneralCategories();
            dataList = SelectAnonyMous<Entities.GeneralCategories>(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}

