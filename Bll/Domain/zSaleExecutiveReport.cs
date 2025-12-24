using System.Data.SqlClient;
using System.Collections.Generic;

namespace Bll
{
    public class zSaleExecutiveReport : Base
    {
        public static int rowCountOfQuery;
        //---------------------------------------------------------

        public static List<Entities.zSaleExecutiveReport> Select(int rowCount = 0, System.Data.CommandType _cmdType = System.Data.CommandType.Text, IDictionary<string, object> _parmsVals = null, SqlConnection con = null, SqlTransaction tran = null, int? saleExecutiveID = null, string StartDate = null, string EndDate = null)
        {
            rowCountOfQuery = 0; // hata verdiği zaman sıfırlansın diye.
            //---------------------------------------------------------
            List<Entities.zSaleExecutiveReport> dlist = Dal.zSaleExecutiveReport.Select(rowCount, _cmdType, _parmsVals, con, tran, saleExecutiveID, StartDate, EndDate);
            //---------------------------------------------------------
            rowCountOfQuery = Dal.zSaleExecutiveReport.rowCountOfQuery;
            //---------------------------------------------------------
            return dlist;
        }
    }
}

