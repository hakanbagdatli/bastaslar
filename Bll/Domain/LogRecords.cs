using System.Data.SqlClient;
using System.Collections.Generic;

namespace Bll
{
    public class LogRecords : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<Entities.LogRecords> Select(int id, string filter, string sorting="", int startIndex = 0, int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null)
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<Entities.LogRecords> dlist = Dal.LogRecords.Select(id, filter, sorting, startIndex, rowCount, _cmdType, _parmsVals, con, tran);
            //---------------------------------------------------------
            rowCountOfQuery = Dal.LogRecords.rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}

