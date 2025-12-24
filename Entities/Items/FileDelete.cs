using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Items
{
    public class FileDelete
    {
        public int table { get; set; }
        public string field { get; set; }
        public string filepath { get; set; }
        public string filename { get; set; }
    }
}
