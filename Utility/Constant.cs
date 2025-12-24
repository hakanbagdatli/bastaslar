namespace Utility
{
    public class Constant
    {
        public static string SqlServerName { get; set; }
        //---------------------------------------------------------
        public static string SqlDatabaseName { get; set; }
        //---------------------------------------------------------
        public static string SqlUsername { get; set; }
        //---------------------------------------------------------
        public static string SqlPassword { get; set; }
        //---------------------------------------------------------
        public static string LocationAppData { get; set; }
        //---------------------------------------------------------
        public static string ConnectionString = "Data Source=" + SqlServerName + "; Initial Catalog=" + SqlDatabaseName + "; uid=" + SqlUsername + "; pwd=" + SqlPassword + "; Connect Timeout=60;";
        //---------------------------------------------------------
        public static string dbName = "";
        //---------------------------------------------------------
        public static string dbNameTwin = "";
        //---------------------------------------------------------
        public const string ParameterSymbol = "@";
        //---------------------------------------------------------
        public const string SetDateFormat = " set dateformat DMY ";
        //---------------------------------------------------------
        public const string JoinInner = " INNER JOIN ";
        //---------------------------------------------------------
        public const string JoinLeft = " LEFT OUTER JOIN ";
        //---------------------------------------------------------
        public const string JoinRight = " RIGHT OUTER JOIN ";
        //---------------------------------------------------------
        public const string Where = " WHERE ";
        //---------------------------------------------------------
        public const string OrderBy = " ORDER BY ";
        //---------------------------------------------------------
        public const string GroupBy = " GROUP BY ";
        //---------------------------------------------------------
        public const string DateType = "104";
        //---------------------------------------------------------
        public const string EncyrptKey = "LIOPHINPASS";

    }
}
