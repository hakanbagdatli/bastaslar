namespace Entities
{
    public abstract class IEntity
    {
        public IEntity(string table)
        {
            _TableName = table;
        }

        public string _TableName { get; set; }
        public string _ValidationMessage { get; set; }

    }
}
