using Tools;
using System;
using Entities;
using System.Xml;
using System.Web;
using System.Linq;
using System.Collections.Generic;

namespace WebSite
{
    public partial class Sitemap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "text/xml";
                XmlTextWriter xr = new XmlTextWriter(HttpContext.Current.Response.OutputStream, System.Text.Encoding.UTF8);
                xr.WriteStartDocument();
                xr.WriteStartElement("urlset");
                xr.WriteAttributeString("xmlns", "https://www.sitemaps.org/schemas/sitemap/0.9");
                xr.WriteAttributeString("xmlns:xsi", "https://www.w3.org/2001/XMLSchema-instance");
                xr.WriteAttributeString("xsi:schemaLocation", "https://www.sitemaps.org/schemas/sitemap/0.9 https://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd");
                //---------------------------------------------------------
                xr.WriteStartElement("url");
                xr.WriteElementString("loc", "https://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"].Replace("www.", "") + Handler.GetLanguageMain() + "");
                xr.WriteElementString("lastmod", DateTime.Now.ToString("yyyy-MM-dd"));
                xr.WriteElementString("changefreq", "daily");
                xr.WriteElementString("priority", "1");
                xr.WriteEndElement();
                //---------------------------------------------------------

                #region for Records

                List<Entities.GeneralRecords> recordList = StaticList.Records.Where(x => (x.Approved == 1) && (x.DontAppearSiteMap == 0)).OrderByDescending(o => o.id).ToList();
                foreach (var item in recordList)
                {
                    bool DontShowSiteMap = Convert.ToBoolean(StaticList.PageTypes.Where(x => (x.id == Convert.ToInt32(item._PageTypeID))).FirstOrDefault().DontAppearSiteMap);
                    if (DontShowSiteMap == false)
                    {
                        xr.WriteStartElement("url");
                        xr.WriteElementString("loc", "https://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"].Replace("www.", "") + Handler.SetMetaURL(item.CatID, item.id, true));
                        xr.WriteElementString("lastmod", DateTime.Now.ToString("s").Substring(0, 10));
                        xr.WriteElementString("priority", "0.5");
                        //xr.WriteElementString("changefreq", "monthly");
                        xr.WriteElementString("changefreq", "daily");
                        xr.WriteEndElement();
                    }
                }
                #endregion

                #region for Categories
                List<Entities.GeneralCategories> categoryList = StaticList.Categories.Where(x => (x.Approved == 1) && (x.DontAppearSiteMap == 0)).OrderByDescending(o => o.id).ToList();
                foreach (var item in categoryList)
                {
                    if (item.PageTypeID > 6)
                    {
                        xr.WriteStartElement("url");
                        xr.WriteElementString("loc", "https://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"].Replace("www.", "") + Handler.SetMetaURL(item.PageTypeID, item.id, false));
                        xr.WriteElementString("lastmod", DateTime.Now.ToString("s").Substring(0, 10));
                        xr.WriteElementString("priority", "0.5");
                        //xr.WriteElementString("changefreq", "monthly");
                        xr.WriteElementString("changefreq", "daily");
                        xr.WriteEndElement();
                    }
                }
                #endregion

                //---------------------------------------------------------
                xr.WriteEndDocument();
                xr.Flush();
                xr.Close();
                HttpContext.Current.Response.End();
            }
            catch { }
        }
        //--------------------------------------------------------- pageLoad işlemleri
    }
}