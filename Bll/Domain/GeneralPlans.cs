using System.Data.SqlClient;
using System.Collections.Generic;

namespace Bll
{
    public class GeneralPlans : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<Entities.GeneralPlans> Select(int id, string filter, string sorting="", int startIndex = 0, int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null)
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<Entities.GeneralPlans> dlist = Dal.GeneralPlans.Select(id, filter, sorting, startIndex, rowCount, _cmdType, _parmsVals, con, tran);
            //---------------------------------------------------------
            rowCountOfQuery = Dal.GeneralPlans.rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}

