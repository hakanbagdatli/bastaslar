using System;

namespace Entities
{
    public class zSaleExecutiveReport : IEntity
    {
        public zSaleExecutiveReport() : base("zSaleExecutiveReport")
        {

        }

        public string SalesExecutive { get; set; }
        public int? Touch { get; set; }
        public int? Completed { get; set; }
        public int? Reservation { get; set; }
        public int? Inspection { get; set; }
        public int? PropertyView { get; set; }

    }
}

