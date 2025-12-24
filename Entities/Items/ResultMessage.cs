namespace Entities.Items
{
    public class ResultMessage
    {
        public bool result { get; set; }
        public int count { get; set; }
        public bool hasPaging { get; set; }
        public int rowCount { get; set; }
        public int currentPage { get; set; }
        public string message { get; set; }
        public object items { get; set; }
    }
}
