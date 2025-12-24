using System;
using Utility;
using Entities;
using Tools;
using System.Web;

namespace WebSite
{
    public partial class Layout : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                form1.Action = Request.RawUrl.ToString();
                MetaTags();
                SiteProperties();
            }
        }
        //--------------------------------------------------------- pageLoad İşlemleri

        protected void MetaTags()
        {
            lblOgImage.Text = "<meta property='og:image' content='" + Feature.ImageFolder + StaticList.Settings.SiteLogo + "' />";
            //------------------------------------------
            if (Request.ServerVariables["URL"].ToLower() == "/default.aspx")
                lblOgTitle.Text = "<meta property='og:title' content ='" + StaticList.ActiveSite.MetaTitle + "' />";
            //---------------------------------------------------------
            if (Session["MetaDesc"] == null)
            {
                lblDescription.Text = "<meta name='description' content='" + StaticList.ActiveSite.MetaDescription + "' />";
                lblOgDescription.Text = "<meta property='og:description' content='" + StaticList.ActiveSite.MetaDescription + "' />";
            }
            //------------------------------------------
            //if (Session["MetaKeyw"] == null)
            //lblKeywords.Text = "<meta name='keywords'" content='" + Settings.MetaKeywords + "' />";
            //------------------------------------------
            Session["MetaOgTitle"] = null;
            Session["MetaDesc"] = null;
            Session["MetaKeyw"] = null;
        }
        //--------------------------------------------------------- description, meta tag vs.

        protected void SiteProperties()
        {
            lblAlternate.Text = SetLanguageAlternates();
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(StaticList.Settings.GoogleVerificationCode))
                lblGoogleVerificationCode.Text = StaticList.Settings.GoogleVerificationCode;
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(StaticList.Settings.GoogleAnalyticsCode))
                lblGoogleAnalyticsCode.Text = StaticList.Settings.GoogleAnalyticsCode;
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(StaticList.Settings.GeoTags))
                lblGeoTags.Text = StaticList.Settings.GeoTags;
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(StaticList.ActiveSite.AdditionalMetaTags))
                lblAdditionalMetaTags.Text = StaticList.ActiveSite.AdditionalMetaTags;
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(StaticList.Settings.Favicon))
                lblFavicon.Text = "<link rel='shortcut icon' href='" + Feature.ImageFolder + StaticList.Settings.Favicon + "' />";
        }
        //--------------------------------------------------------- genel site ayarları

        public string GetBaseUrl(HttpRequest request)
        {
            Uri uri = request.Url;
            string baseUrl = uri.GetLeftPart(UriPartial.Authority);
            return baseUrl;
        }
        //---------------------------------------------------------

        protected string SetLanguageAlternates()
        {
            string BaseURL = GetBaseUrl(Request);
            string RawUrl = Request.RawUrl.ToString();
            string AlternateLink = "<link rel='alternate' hreflang='x-default' href='" + BaseURL + RawUrl + "' />";
            //---------------------------------------------------------
            int CatID = Convert.ToInt32(hdnCatID.Value);
            int RecordID = Convert.ToInt32(hdnID.Value);
            foreach (var item in StaticList.LanguageCodes)
            {
                string AlternateURL = "/";
                //---------------------------------------------------------
                if (item.id == StaticList.Settings.DefaultLanguage)
                {
                    if (Feature.ActiveLanguage == item.id.ToString())
                        AlternateURL += RawUrl;
                    else
                    {
                        if (RecordID > 0)
                            AlternateURL += Select.GlobalSiteDetailLink(CatID, RecordID);
                        else
                            AlternateURL += Select.GlobalConstantLink(CatID);
                    }
                }
                else
                {
                    AlternateURL += item.Code.ToLower() + "/";
                    if (RecordID > 0)
                        AlternateURL += Select._GlobalSiteDetailLink(CatID, RecordID, item.id.ToString());
                    else
                        AlternateURL += Select._GlobalConstantLink(CatID, item.id.ToString());
                }
                AlternateLink += "<link rel='alternate' hreflang='" + item.Code.ToLower() + "' href='" + BaseURL + AlternateURL.Replace("//", "/") + "' />";
            }
            return AlternateLink;
        }
        //---------------------------------------------------------
    }
}