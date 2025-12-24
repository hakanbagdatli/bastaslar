using System.Data.SqlClient;
using System.Collections.Generic;

namespace Bll
{
    public class InspectionSummaries : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<Entities.InspectionSummaries> Select(int id, string filter, string sorting="", int startIndex = 0, int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null)
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<Entities.InspectionSummaries> dlist = Dal.InspectionSummaries.Select(id, filter, sorting, startIndex, rowCount, _cmdType, _parmsVals, con, tran);
            //---------------------------------------------------------
            rowCountOfQuery = Dal.InspectionSummaries.rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}

