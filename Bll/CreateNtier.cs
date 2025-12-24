namespace Bll
{
    public class CreateNtier
    {
        public static void Create(string fileName, string className, string table_name_without_schema, string table_name_with_schema, bool hasTwin)
        {
            string tamPath = @"C:\inetpub\wwwroot\AtaBilisim\sunvalleycyprus.com\";
            Dal.CreateNtier.ProjectAnaRoot = tamPath;
            Dal.CreateNtier.ELFileRoot = Dal.CreateNtier.ProjectAnaRoot + @"Entities\Domain";
            Dal.CreateNtier.BLFileRoot = Dal.CreateNtier.ProjectAnaRoot + @"Bll\Domain";
            Dal.CreateNtier.DALFileRoot = Dal.CreateNtier.ProjectAnaRoot + @"Dal\Domain";
            Dal.CreateNtier.Create(fileName, className, table_name_without_schema, table_name_with_schema, hasTwin);
        }
    }
}
