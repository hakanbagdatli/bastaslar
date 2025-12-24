using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Service
{
    public class ProjectSearch
    {
        public int id { get; set; }
        public string Title { get; set; }
        public int Statu { get; set; }
        public int CurrentPage { get; set; }
        public int RowCount { get; set; }
    }
}
