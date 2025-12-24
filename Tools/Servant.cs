using Entities.Items;

namespace Tools
{
    public class Servant
    {
        public static ResultMessage ResultMessage(object list, int count, int rowCount, int currentpage, bool result, string message)
        {
            ResultMessage data = new ResultMessage();
            data.items = list;
            data.count = count;
            if (rowCount > 0) { data.hasPaging = true; } else { data.hasPaging = false; }
            data.currentPage = currentpage;
            data.rowCount = rowCount;
            data.message = message;
            data.result = result;
            return data;
        }
    }
}
