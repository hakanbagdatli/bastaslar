using System;
using Utility;
using Entities;
using System.Web;
using System.Linq;
using System.Web.UI;
using System.Collections;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace Tools
{
    public class Breadcrumb
    {
        Literal ltrlTree = new Literal();
        static ArrayList allTree = new ArrayList();
        static string spPassive = null;
        //---------------------------------------------------------

        public static void Clear() { allTree.Clear(); }
        //---------------------------------------------------------

        public static void Add(string name, string url) { allTree.Add(new ListItem(name, url)); }
        //---------------------------------------------------------

        public static void Add(object name, bool pasif) { spPassive = name.ToString(); }
        //---------------------------------------------------------

        static string[] IncomingData = new string[3];
        //---------------------------------------------------------

        public static string ResolveUrl(string relativeUrl) { System.Web.UI.Page p = HttpContext.Current.Handler as System.Web.UI.Page; return p.ResolveUrl(relativeUrl); }
        //---------------------------------------------------------

        public static string SetTitle(string metaContent, Page p)
        {
            string SiteBaslik = "";
            try
            {
                if (!String.IsNullOrEmpty(metaContent))
                { p.Title = metaContent; }
            }
            catch { }
            return SiteBaslik;
        }
        //---------------------------------------------------------

        #region Admin Panel

        private static string LinkSeperator { get { return ""; } }
        //---------------------------------------------------------

        public static string[] PanelDashboard
        {
            get
            {
                IncomingData[0] = "<i class='fas fa-home'></i>";
                IncomingData[1] = "/raven/dashboard/";
                IncomingData[2] = "/raven/dashboard/";
                return IncomingData;
            }
        }
        //---------------------------------------------------------

        public static void RegisterTree(Literal ltrlTree)
        {
            try
            {
                ltrlTree.Text = Link(PanelDashboard);
                for (int i = 0; i < allTree.Count; i++)
                {
                    ListItem li = (ListItem)allTree[i];
                    if (i == (allTree.Count - 1))
                    {
                        ltrlTree.Text += LinkSeperator;
                        ltrlTree.Text += LinkCurrent(li.Text);
                    }
                    else
                    {
                        ltrlTree.Text += LinkSeperator;
                        ltrlTree.Text += Link(li.Text, li.Value);
                    }
                }
                allTree.Clear();
            }
            catch { }
        }
        //---------------------------------------------------------

        public static string Link(string[] page)
        {
            string geridonenveri = null;
            geridonenveri = "<li class=\"breadcrumb-item\"><a href=\"" + page[2] + "\" class=\"text-muted\">" + page[0] + "</a></li>";
            return geridonenveri;
        }
        //---------------------------------------------------------

        public static string Link(string title, string url)
        {
            string geridonenveri = null;
            geridonenveri = "<li class=\"breadcrumb-item\"><a href=\"" + url + "\" class=\"text-muted\">" + title + "</a></li>";
            return geridonenveri;
        }
        //---------------------------------------------------------

        public static string LinkCurrent(string title)
        {
            string geridonenveri = null;
            geridonenveri = "<li class=\"breadcrumb-item\"><a href='javascript:;' class=\"text-muted\">" + title + "</a></li>";
            return geridonenveri;
        }
        //---------------------------------------------------------

        public static void SetTree(string title, Literal ltrlAgac, Page sayfa)
        {
            Add(Helper.FirstLetterUppercase(title), "");
            RegisterTree(ltrlAgac);
            SetTitle(title + " - Sunvalley Sales CRM", sayfa);
        }
        //---------------------------------------------------------

        #endregion

        #region Web Site

        private static string SiteLinkSeperator { get { return ""; } }
        //--------------------------------------------------------- AyracSite

        public static string[] SiteMainPage
        {
            get
            {
                IncomingData[0] = StaticList.Settings.CompanyName;
                IncomingData[1] = "/";
                IncomingData[2] = "/";
                return IncomingData;
            }
        }
        //--------------------------------------------------------- PanelAnasayfaSite

        public static void SiteRegisterTree(Literal ltrlTree)
        {
            try
            {
                ltrlTree.Text = SiteLink(SiteMainPage, "", SiteMainPage.ToString(), 1);
                int _lnkCont = allTree.Count;
                int j = 2;
                for (int i = 0; i < _lnkCont; i++)
                {
                    ListItem li = (ListItem)allTree[i];
                    if (i == (_lnkCont - 1))
                    {
                        ltrlTree.Text += SiteLinkSeperator;
                        ltrlTree.Text += SiteCurrentLink(li.Text, li.Text, j);
                    }
                    else
                    {
                        ltrlTree.Text += SiteLinkSeperator;
                        ltrlTree.Text += SiteLink(li.Text, li.Value, "", li.Text, j);
                    }
                    j++;
                }
                allTree.Clear();
            }
            catch { }
        }
        //--------------------------------------------------------- RegisterAgacSite

        public static string SiteLink(string linkAd, string url, string cssClass, string linkAdTitle, int liCount)
        {
            return @"<li itemprop='itemListElement' itemscope itemtype='http://schema.org/ListItem'>
                        <a href='" + url + "' title='" + linkAdTitle + "' itemprop='item'>" +
                           "<span itemprop='name'>" + linkAdTitle + @"</span>
                        </a>
                        <meta itemprop='position' content='" + liCount + @"'>
                    </li>";
        }
        //--------------------------------------------------------- LinkSite

        public static string SiteLink(string[] sayfaAd, string cssClass, string linkAdTitle, int liCount)
        {
            return @"<li itemprop='itemListElement' itemscope itemtype='http://schema.org/ListItem'>
                        <a href='" + sayfaAd[2] + "' title='" + sayfaAd[0] + "' itemprop='item'>" +
                            "<span itemprop='name'>" + sayfaAd[0] + @"</span>
                        </a>
                        <meta itemprop='position' content='" + liCount + @"'>
                    </li>";
        }
        //--------------------------------------------------------- LinkSite

        public static string SiteCurrentLink(string linkAd, string linkAdTitle, int liCount)
        {
            return @"<li itemprop='itemListElement' itemscope itemtype='http://schema.org/ListItem'>
                        <a href='javascript:;' title='" + linkAdTitle + "' itemprop='item'>" +
                            "<span itemprop='name'>" + linkAd + @"</span>
                        </a>
                        <meta itemprop='position' content='" + liCount + @"'>
                    </li>";
        }
        //--------------------------------------------------------- LinkCurrentSite

        #endregion

        #region Site Ağaç İşlemleri

        public static void SingleTreeWhereAmI(string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            Add(Title, "javascript:;");
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- TekliAgacNerdeyim

        public static void MultipleTreeWhereAmI(int CatID, string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            string UrlLink = "";
            var _idList = Select.MultipleCategoryCatID(CatID).Split(',').Select(int.Parse).ToList();
            List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => _idList.Contains(x.id) && (x.Approved == 1)).ToList();
            //---------------------------------------------------------
            foreach (var item in dataList)
            {
                if (!String.IsNullOrEmpty(item.Link))
                    UrlLink = item.Link;
                else if (Convert.ToBoolean(item.DontAppearSiteMap))
                    UrlLink = "javascript:;";
                else
                    UrlLink = Handler.SetMetaURL(item.PageTypeID, item.id, false);
                //---------------------------------------------------------
                Add(Handler.SetText(item.MetaTitle, item._MetaTitle), UrlLink);
            }
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- CokluAgacNerdeyim

        public static void MultipleTreeDetailWhereAmI(int CatID, string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            string UrlLink = "";
            var _idList = Select.MultipleCategoryCatID(CatID).Split(',').Select(int.Parse).ToList();
            List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => _idList.Contains(x.id) && (x.Approved == 1)).ToList();
            //---------------------------------------------------------
            foreach (var item in dataList)
            {
                if (!String.IsNullOrEmpty(item.Link))
                    UrlLink = item.Link;
                else if (Convert.ToBoolean(item.DontAppearSiteMap))
                    UrlLink = "javascript:;";
                else
                    UrlLink = Handler.SetMetaURL(item.PageTypeID, item.id, false);
                //---------------------------------------------------------
                if (Handler.SetText(item.MetaTitle, item._MetaTitle) != Title)
                    Add(Handler.SetText(item.MetaTitle, item._MetaTitle), UrlLink);
            }
            Add(Title, "");
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- CokluAgacDetayNerdeyim

        public static string AgacHrefGlobalRequestSiz(string url)
        {
            try
            {
                return url.Replace("/", "").Substring(0, url.Substring(1).IndexOf("/"));
            }
            catch { return ""; }
        }
        //--------------------------------------------------------- AgacHrefGlobalRequestSiz

        #endregion

        #region Site Diller Ağaç İşlemleri

        public static void _SingleTreeWhereAmI(string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            Add(Title, "javascript:;");
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- TekliAgacNerdeyim

        public static void _MultipleTreeWhereAmI(int CatID, string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            string UrlLink = "";
            var _idList = Select.MultipleCategoryCatID(CatID).Split(',').Select(int.Parse).ToList();
            List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => _idList.Contains(x.id) && (x.Approved == 1)).ToList();
            //---------------------------------------------------------
            foreach (var item in dataList)
            {
                if (!String.IsNullOrEmpty(item.Link))
                    UrlLink = item.Link;
                else if (Convert.ToBoolean(item.DontAppearSiteMap))
                    UrlLink = "javascript:;";
                else
                    UrlLink = Select._GlobalSiteLink(item.PageTypeID, item.id);
                //---------------------------------------------------------
                Add(item._MetaTitle, UrlLink);
            }
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- CokluAgacNerdeyim

        public static void _MultipleTreeDetailWhereAmI(int CatID, string Title, string MetaTitle, Literal ltrlTree, Page PageName)
        {
            string UrlLink = "";
            var _idList = Select.MultipleCategoryCatID(CatID).Split(',').Select(int.Parse).ToList();
            List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => _idList.Contains(x.id) && (x.Approved == 1)).ToList();
            //---------------------------------------------------------
            foreach (var item in dataList)
            {
                if (!String.IsNullOrEmpty(item.Link))
                    UrlLink = item.Link;
                else if (Convert.ToBoolean(item.DontAppearSiteMap))
                    UrlLink = "javascript:;";
                else
                    UrlLink = Select._GlobalSiteLink(item.PageTypeID, item.id);
                //---------------------------------------------------------
                if (item._MetaTitle != Title)
                    Add(item._MetaTitle, UrlLink);
            }
            Add(Title, "");
            SiteRegisterTree(ltrlTree);
            SetTitle(MetaTitle, PageName);
        }
        //--------------------------------------------------------- CokluAgacDetayNerdeyim

        #endregion

    }
}