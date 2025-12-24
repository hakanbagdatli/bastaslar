using Utility;
using Entities;
using System.Web;
using System.Net;
using System.Data;
using Newtonsoft.Json;

namespace Tools
{
    public class Language
    {

        public static DataView LanguageData;

        private static DataTable GetLang()
        {
            string pathAbsoluteUri = HttpContext.Current.Request.Url.AbsoluteUri;
            string pathAbsolutePath = HttpContext.Current.Request.Url.AbsolutePath;
            string URL = pathAbsoluteUri.Replace(pathAbsolutePath, "/raven/assets/panel-lang.json");
            string json = (new WebClient()).DownloadString(URL);
            return JsonConvert.DeserializeObject<DataTable>(json);
        }
        //---------------------------------------------------------

        public static string GetFixed(string IdTag)
        {
            try
            {
                if (LanguageData == null)
                    LanguageData = new DataView(GetLang());
                //---------------------------------------------------------
                LanguageData.RowFilter = "id = '" + IdTag + "'";
                if (LanguageData.Count > 0)
                {
                    switch (Feature.CRMLanguage)
                    {
                        case "EN":
                            return LanguageData[0]["EN"].ToString();
                        case "TR":
                            return LanguageData[0]["TR"].ToString();
                        case "RU":
                            return LanguageData[0]["RU"].ToString();
                        case "ES":
                            return LanguageData[0]["ES"].ToString();
                        case "DE":
                            return LanguageData[0]["DE"].ToString();
                        case "FR":
                            return LanguageData[0]["FR"].ToString();
                        case "IT":
                            return LanguageData[0]["IT"].ToString();
                        case "PT":
                            return LanguageData[0]["PT"].ToString();
                        default:
                            return LanguageData[0]["EN"].ToString();
                    }
                }
                else
                    return IdTag;

            }
            catch
            {
                return "0";
            }
        }
        //--------------------------------------------------------- id ve dil kodu verilen bilginin karşılığını databaseden getirir.

        public static string GetSite(int id)
        {
            try
            {
                id = id - 1;
                switch (Feature.ActiveLanguage)
                {
                    case "1":
                        return StaticList.SiteLangConstants[id].LangTR;
                    case "2":
                        return StaticList.SiteLangConstants[id].LangEN;
                    case "3":
                        return StaticList.SiteLangConstants[id].LangAR;
                    case "4":
                        return StaticList.SiteLangConstants[id].LangDE;
                    case "5":
                        return StaticList.SiteLangConstants[id].LangFR;
                    case "6":
                        return StaticList.SiteLangConstants[id].LangRU;
                    case "9":
                        return StaticList.SiteLangConstants[id].LangIT;
                    case "10":
                        return StaticList.SiteLangConstants[id].LangPT;
                    case "11":
                        return StaticList.SiteLangConstants[id].LangES;
                    default:
                        return StaticList.SiteLangConstants[id].LangEN;
                }
            }
            catch
            {
                Entities.StaticList.SiteLangConstants = Bll.LangFixed.Select(0, filter: "");
                GetSite(id);
                return "0";
            }
        }
        //--------------------------------------------------------- id ve dil kodu verilen bilginin karşılığını databaseden getirir.

        public static string GetPartner(string IdTag, string Language = "")
        {
            try
            {
                if (LanguageData == null)
                    LanguageData = new DataView(GetLang());
                //---------------------------------------------------------
                LanguageData.RowFilter = "id = '" + IdTag + "'";
                if (LanguageData.Count > 0)
                {
                    HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
                    if (RavenCookies != null)
                        Language = RavenCookies.Values["RavenLang"];
                    //---------------------------------------------------------
                    switch (Language)
                    {
                        case "1":
                            return LanguageData[0]["TR"].ToString();
                        case "4":
                            return LanguageData[0]["DE"].ToString();
                        case "5":
                            return LanguageData[0]["FR"].ToString();
                        case "6":
                            return LanguageData[0]["RU"].ToString();
                        case "9":
                            return LanguageData[0]["IT"].ToString();
                        case "10":
                            return LanguageData[0]["PT"].ToString();
                        case "11":
                            return LanguageData[0]["ES"].ToString();
                        default:
                            return LanguageData[0]["EN"].ToString();
                    }
                }
                else
                    return IdTag;

            }
            catch
            {
                return "0";
            }
        }
        //--------------------------------------------------------- id ve dil kodu verilen bilginin karşılığını databaseden getirir.
    }
}