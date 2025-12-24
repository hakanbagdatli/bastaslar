using System.Data.SqlClient;
using System.Collections.Generic;

namespace Bll
{
    public class GeneralCategories : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<Entities.GeneralCategories> Select(int id, string filter, string sorting="", int startIndex = 0, int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null, string lang = "")
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<Entities.GeneralCategories> dlist = Dal.GeneralCategories.Select(id, filter, sorting, startIndex, rowCount, _cmdType, _parmsVals, con, tran, lang);
            //---------------------------------------------------------
            rowCountOfQuery = Dal.GeneralCategories.rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}

