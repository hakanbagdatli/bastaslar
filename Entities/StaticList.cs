using System.Data;
using System.Collections.Generic;

namespace Entities
{
    public class StaticList
    {
        public static string GlobalReWriteLink;

        //---------------------------------------------------------
        public static Entities.zSettings Settings { get; set; }
        public static Entities.zLangCodes ActiveSite { get; set; }
        public static List<Entities.zLangCodes> LanguageCodes { get; set; }
        public static List<Entities.zLangFixed> FixedLanguage { get; set; }
        public static List<Entities.LangFixed> SiteLangConstants { get; set; }
        //---------------------------------------------------------
        public static List<Entities.GeneralContacts> Contact { get; set; }
        public static List<Entities.zPageTypes> PageTypes { get; set; }
        public static List<Entities.zDefineDetails> Defines { get; set; }
        public static List<Entities.GeneralCategories> Categories { get; set; }
        public static List<Entities.GeneralRecords> Records { get; set; }
    }
}