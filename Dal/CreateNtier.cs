using System.IO;
using System.Text;
using System.Data.SqlClient;

namespace Dal
{
    public class CreateNtier
    {
        public static string ProjectAnaRoot = "";
        public static string ELFileRoot = ProjectAnaRoot + @"\Entities\Domain\";
        public static string BLFileRoot = ProjectAnaRoot + @"\Bll\Domain\";
        public static string DALFileRoot = ProjectAnaRoot + @"\Dal\Domain\";
        public static string ELNameSpace = "Entities";
        public static string BLNameSpace = "Bll";
        public static string DALNameSpace = "Dal";
        public static string UtilityNameSpace = "Utility";
        public static string mySqlListCols = @"
            SELECT 
            CONCAT('public ',
            CASE WHEN data_type = 'int' then 'int'
            WHEN data_type = 'tinyint' then 'int'
            WHEN data_type='varchar' then 'string'
            WHEN data_type='decimal' then 'decimal'
            ELSE data_type
             END 
             ,' ', column_name, ' {get; set;}')  

            FROM information_schema.columns col
            WHERE table_name = 'table_name'";
        static string primaryKey = "";

        public static void Create(string fileName, string className, string table_name_without_schema, string table_name_with_schema, bool hasTwin)
        {
            EntitiesLayer(fileName, className, table_name_without_schema, table_name_with_schema, hasTwin); // primaryKey will set in EL and then call from DAL
            DataLayer(fileName, className);
            BusinessLayer(fileName, className);
        }
        //--------------------------------------------------------- create all schemes

        static void EntitiesLayer(string fileName, string className, string table_name_without_schema, string table_name_with_schema, bool hasTwin)
        {

            string tabloYapisi = @"
SELECT 'public ' + case when DATA_TYPE = 'nvarchar' then 'string'
when DATA_TYPE = 'datetime' then 'DateTime?' when DATA_TYPE ='smalldatetime' then 'DateTime?' when DATA_TYPE = 'char' then 'string'
when DATA_TYPE = 'varchar' then 'string'
when DATA_TYPE = 'int' then 'int?' when DATA_TYPE ='float' then 'decimal?'
when DATA_TYPE = 'decimal' then 'decimal?'
when DATA_TYPE = 'bit' then 'byte?'
when DATA_TYPE = 'smallint' then 'int?'
    else DATA_TYPE 
    end
    + ' ' + COLUMN_NAME + ' {get; set;}' as prop
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'" + table_name_without_schema + "'";
            //---------------------------------------------------------
            if (fileName != "" && !Directory.Exists(ELFileRoot + fileName))
                Directory.CreateDirectory(ELFileRoot + fileName);
            //---------------------------------------------------------
            string fileNameWithNokta = fileName != "" ? "." + fileName : "";
            using (SqlDataReader dr = Dal.AdoNet.Select.DataReader(tabloYapisi))
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(@"using System;

namespace " + ELNameSpace + fileNameWithNokta + @"
{
    public class " + className + @": IEntity
    {
        public " + className + @"(): base(""" + table_name_with_schema + @""")
        {
 
        }
");
                //---------------------------------------------------------
                int i = -1;
                while (dr.Read())
                {
                    string colAdi = dr[0].ToString();
                    i++;
                    if (i == 0)
                    {
                        int startInd = colAdi.IndexOf("?");
                        string d = colAdi.Remove(0, startInd).Replace("? ", "");
                        startInd = d.IndexOf(" ");
                        string son = d.Substring(0, startInd);
                        primaryKey = son;
                        colAdi = colAdi.Replace("?", "");
                    }
                    sb.AppendLine("         " + colAdi);
                }
                sb.AppendLine(@" 
        public bool _hasTwin { get{ return " + hasTwin.ToString().ToLower() + @"; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = """ + table_name_with_schema + @""";
        public string _tableName = """ + table_name_with_schema + @""";");
                //---------------------------------------------------------
                dr.Close();
                sb.AppendLine(@"
    }
}");
                StreamWriter sw = new StreamWriter(ELFileRoot + fileName + "\\" + className + ".cs", false, Encoding.UTF8);
                sw.WriteLine(sb.ToString());
                sw.Dispose();
                sw.Close();

            }
        }
        //--------------------------------------------------------- create entities layer

        static void DataLayer(string fileName, string className)
        {
            if (fileName != "" && !Directory.Exists(DALFileRoot + fileName))
                Directory.CreateDirectory(DALFileRoot + fileName);
            //---------------------------------------------------------
            string fileNameWithNokta = fileName != "" ? "." + fileName : "";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(@"using System;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace " + DALNameSpace + fileNameWithNokta + @"
{
    public class " + className + @" : Base
    {     
        public static int rowCountOfQuery;
        public static string tableName = " + ELNameSpace + fileNameWithNokta + "." + className + @".tableName;

        public static List<" + ELNameSpace + "." + className + @"> Select(int id, string filter, string sorting, int startIndex, int rowCount, System.Data.CommandType _cmdType, IDictionary<string, object> _parmsVals, SqlConnection con, SqlTransaction tran)
        {
            if (String.IsNullOrEmpty(sorting))
                sorting = "" id ASC "";
            //---------------------------------------------------------
            string query = @"" 
            SELECT * FROM (
            SELECT * FROM "" + tableName + "" WHERE isnull(isDeleted,0)=0) as tbl where 1=1 "";
            if (id > 0)
                query += "" AND " + primaryKey + @"="" + id;
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
            string queryForRowCount = "" SET dateformat dmy SELECT COUNT(*) FROM ("" + query + "") AS tbl"";
            rowCountOfQuery = Dal.AdoNet.Select.ScalarByClause(queryForRowCount, keys, vals, con, tran);
            query = "" SET dateformat dmy "" + query;
            query += "" ORDER BY "" + sorting;
            //---------------------------------------------------------
            if (rowCount > 0)
                query += "" offset "" + startIndex + "" ROWS fetch next "" + rowCount + "" ROWS only"";
            //---------------------------------------------------------
            List<" + ELNameSpace + "." + className + "> dataList = new List<" + ELNameSpace + "." + className + @">();
            " + ELNameSpace + "." + className + " data = new " + ELNameSpace + "." + className + @"();
            dataList = SelectAnonyMous<" + ELNameSpace + "." + className + @">(data, query, _cmdType, keys, vals, con, tran);   
            return dataList;
        }
    }
}");
            //---------------------------------------------------------
            StreamWriter sw = new StreamWriter(DALFileRoot + fileName + "\\" + className + ".cs", false, Encoding.UTF8);
            sw.WriteLine(sb.ToString());
            sw.Dispose();
            sw.Close();
        }
        //--------------------------------------------------------- data layer

        static void BusinessLayer(string fileName, string className)
        {
            if (fileName != "" && !Directory.Exists(BLFileRoot + fileName))
                Directory.CreateDirectory(BLFileRoot + fileName);
            //---------------------------------------------------------
            string fileNameWithNokta = fileName != "" ? "." + fileName : "";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(@"using System.Data.SqlClient;
using System.Collections.Generic;

namespace " + BLNameSpace + fileNameWithNokta + @"
{
    public class " + className + @" : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<" + ELNameSpace + "." + className + @"> Select(int id, string filter, string sorting="""", int startIndex = 0, int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null)
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<" + ELNameSpace + "." + className + @"> dlist = " + DALNameSpace + "." + className + @".Select(id, filter, sorting, startIndex, rowCount, _cmdType, _parmsVals, con, tran);
            //---------------------------------------------------------
            rowCountOfQuery = " + DALNameSpace + "." + className + @".rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}");
            using (StreamWriter sw = new StreamWriter(BLFileRoot + fileName + "\\" + className + ".cs", false, Encoding.UTF8))
            {
                sw.WriteLine(sb.ToString());
                sw.Dispose();
                sw.Close();
            }
        }
        //--------------------------------------------------------- business layer
    }
}