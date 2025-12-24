using System;

namespace Entities
{
    public class zUsers : IEntity
    {
        public zUsers() : base("zUsers")
        {

        }

        public int id { get; set; }
        public int Statu { get; set; }
        public int CatID { get; set; }
        public string _AgencyName { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Thumbnail { get; set; }
        public int? Language { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "zUsers";
        public string _tableName = "zUsers";

    }
}

