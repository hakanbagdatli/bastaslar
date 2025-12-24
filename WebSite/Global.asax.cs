using System;
using Utility;
using Entities;
using System.Linq;
using System.Web.Routing;
using System.Configuration;
using System.Collections.Generic;
using Tools;

namespace WebSite
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            #region Database Connection
            Constant.dbName = ConfigurationManager.AppSettings["db_name"];
            Constant.dbNameTwin = ConfigurationManager.AppSettings["db_name_twin"];
            try { Constant.ConnectionString = StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["con"].ConnectionString); }
            catch { Constant.ConnectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString; }
            #endregion

            StaticList.GlobalReWriteLink = "ClearIT";
            //---------------------------------------------------------
            StaticList.Settings = Bll.zSettings.Select(1, filter: "")[0];
            Feature.ActiveLanguage = StaticList.Settings.DefaultLanguage.ToString();
            StaticList.LanguageCodes = Bll.zLangCodes.Select(0, filter: " AND Approved=1");
            StaticList.ActiveSite = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0];
            StaticList.SiteLangConstants = Bll.LangFixed.Select(0, filter: "");
            //---------------------------------------------------------
            StaticList.Contact = Bll.GeneralContacts.Select(1, filter: "");
            StaticList.PageTypes = Bll.zPageTypes.Select(0, filter: "");
            StaticList.Defines = Bll.zDefineDetails.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id DESC");
            StaticList.Categories = Bll.GeneralCategories.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
            StaticList.Records = Bll.GeneralRecords.Select(0, filter: "", sorting: " Sorting ASC, id DESC");
            //---------------------------------------------------------
        }
        //--------------------------------------------------------- Code that runs on application start

        protected void Session_Start(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on application shutdown

        protected void Application_AuthenticateRequest(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on application authenticate

        protected void Application_Error(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs when an unhandled error occurs

        protected void Session_End(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on sessions end

        protected void Application_End(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on application shutdown

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            Handler.SetLanguage();
            if (!String.IsNullOrEmpty(StaticList.GlobalReWriteLink))
            {
                UpdateRouteRegistration();
                StaticList.GlobalReWriteLink = null;
            }
            //---------------------------------------------------------
            if (Convert.ToBoolean(StaticList.Settings.can301Redirect))
            {
                List<Entities.zSearchEngineIndex> dList = Bll.zSearchEngineIndex.Select(0, " AND BeforeLink='" + Request.Url.LocalPath + "' AND Approved=1");
                foreach (var item in dList)
                {
                    if (Request.Url.LocalPath == item.BeforeLink)
                    {
                        Response.Redirect(item.RedirectLink + Request.Url.Query);
                        Response.End();
                    }
                }
            }
        }
        //--------------------------------------------------------- Code that runs on application begin

        #region route registration

        protected void UpdateRouteRegistration()
        {
            List<string> myRoutesList = new List<string>();
            RouteCollection routes = RouteTable.Routes;

            using (routes.GetWriteLock())
            {
                routes.Clear();

                // Admin panel routes
                AddAdminPanelRoutes(routes);

                // Dynamic linking
                AddDynamicRoutes(routes, myRoutesList);

                foreach (var item in StaticList.LanguageCodes.Where(x => x.id != Convert.ToInt32(StaticList.Settings.DefaultLanguage)))
                {
                    AddDynamicRoutesForLanguages(routes, myRoutesList, item.id.ToString(), item.Code.ToLower());
                    routes.Add("default-" + item.Code, new Route(item.Code.ToLower() + "/", new PageRouteHandler("~/Default.aspx")));
                    routes.Add("sitemap-" + item.Code, new Route(item.Code.ToLower() + "/sitemap", new PageRouteHandler("~/Sitemap.aspx")));
                }

                // Static routes
                AddStaticRoutes(routes);
            }

            //foreach (var item in myRoutesList)
            //{
            //    Response.Write(item + " <br>");
            //}
            //Response.End();
        }
        //--------------------------------------------------------- 

        private void AddAdminPanelRoutes(RouteCollection routes)
        {
            #region admin panel
            var adminRoutes = new Dictionary<string, string>
            {
                { "dashboard", "~/Raven/Dashboard.aspx" },
                { "logout", "~/Raven/Logout.aspx" },
                { "users-list", "~/Raven/Users/List.aspx" },
                { "users-profile", "~/Raven/Users/Profile.aspx" },
                { "seo-settings", "~/Raven/Seo/General.aspx" },
                { "seo-redirection", "~/Raven/Seo/Redirection.aspx" },
                { "site-operation", "~/Raven/Common/Operation.aspx" },
                { "site-sliders", "~/Raven/Common/Banners.aspx" },
                { "contacts", "~/Raven/Common/Contacts.aspx" },
                { "inbox", "~/Raven/Common/Inbox.aspx" },
                { "defines", "~/Raven/Common/Defines.aspx" },
                { "define-options", "~/Raven/Common/DefinesOptions.aspx" },
                { "general-settings", "~/Raven/Settings/General.aspx" },
                { "image-sizes", "~/Raven/Settings/PhotoSizes.aspx" },
                { "page-type-settings", "~/Raven/Settings/PageTypes.aspx" },
                { "menu-content-settings", "~/Raven/Settings/MenuContents.aspx" },
                { "lang-management", "~/Raven/Settings/Languages.aspx" },
                { "category-languages", "~/Raven/Translate/Categories.aspx" },
                { "content-languages", "~/Raven/Translate/Records.aspx" },
                { "category-management", "~/Raven/General/Categories.aspx" },
                { "content-management", "~/Raven/General/Records.aspx" },
                { "content-gallery", "~/Raven/General/Gallery.aspx" },
                { "content-files", "~/Raven/General/Files.aspx" },
                { "content-videos", "~/Raven/General/Videos.aspx" },
                { "content-features", "~/Raven/General/Features.aspx" },
                { "content-plans", "~/Raven/General/Plans.aspx" },
                { "summaries", "~/Raven/Reservation/Summaries.aspx"},
                { "sales", "~/Raven/Reservation/List.aspx"},
                { "sale-transactions", "~/Raven/Reservation/Transactions.aspx"},
                { "sale-preview", "~/Raven/Reservation/Preview.aspx"},
                { "reservations", "~/Raven/Reservation/List.aspx"},
                { "reservation-files", "~/Raven/Reservation/Files.aspx"},
                { "reservation-features", "~/Raven/Reservation/Features.aspx"},
                { "reservation-reports", "~/Raven/Reservation/Reports.aspx"},
                { "customer-list", "~/Raven/Exclusive/Customers.aspx"},
                { "customer-files", "~/Raven/Exclusive/CustomerFiles.aspx"},
                { "agency-list", "~/Raven/Exclusive/Agencies.aspx"},
                { "agency-callbacks", "~/Raven/Exclusive/AgencyCallbacks.aspx"},
                { "brokers", "~/Raven/Exclusive/Brokers.aspx"},
                { "task-assignments", "~/Raven/Exclusive/TaskList.aspx"},
                { "daily-reports", "~/Raven/Exclusive/DailyReports.aspx"},
                { "project-status", "~/Raven/Exclusive/Status.aspx"},
                { "preview", "~/Raven/Exclusive/Preview.aspx" },
                { "inspection-list", "~/Raven/Inspection/List.aspx"},
                { "leads", "~/Raven/Inspection/Leads.aspx"},
                { "attendees", "~/Raven/Inspection/Attendees.aspx"},
                { "calendar", "~/Raven/Inspection/Calendar.aspx"},
                { "sales-executive-summary", "~/Raven/Reservation/SalesExecutiveSummary.aspx"}
            };
            //---------------------------------------------------------
            foreach (var route in adminRoutes)
            {
                routes.Add(route.Key, new Route("raven/" + route.Key, new PageRouteHandler(route.Value)));
            }
            #endregion

            #region partner panel
            var partnerRoutes = new Dictionary<string, string>
            {
                { "projects", "~/Partner/Projects.aspx"},
                { "projects-status", "~/Partner/Status.aspx"},
                { "inspections", "~/Partner/Inspections.aspx"},
                { "property-views", "~/Partner/Inspections.aspx"},
                { "customers", "~/Partner/Customers.aspx"},
                { "agencies", "~/Partner/Agency.aspx"},
                { "agency-calendar", "~/Partner/Calendar.aspx"},
                { "agency-reservations", "~/Partner/Reservations.aspx"},
                { "agency-summaries", "~/Partner/Summaries.aspx"},
                { "market-insights", "~/Partner/MarketInsights.aspx"},
                { "assignments", "~/Partner/Tasks.aspx"},
                { "daily", "~/Partner/DailyReports.aspx"},
                { "presentation", "~/Partner/Presentation.aspx"},
                { "documents", "~/Partner/Documents.aspx"},
                { "my-profile", "~/Partner/Profile.aspx"},
                { "announcements", "~/Partner/Announcements.aspx"},
                { "agency-leads", "~/Partner/Leads.aspx"}
            };
            //---------------------------------------------------------
            foreach (var route in partnerRoutes)
            {
                routes.Add(route.Key, new Route("partner/" + route.Key, new PageRouteHandler(route.Value)));
            }
            #endregion
        }
        //---------------------------------------------------------

        private void AddDynamicRoutes(RouteCollection routes, List<string> myRoutesList)
        {
            foreach (var category in StaticList.Categories.Where(x => (x.Approved == 1)))
            {
                var pageType = StaticList.PageTypes.Where(x => (x.id == category.PageTypeID) && (x.Approved == 1)).FirstOrDefault();
                var subPageQuery = StaticList.PageTypes.Where(x => (x.Approved == 1));
                if (category.SubPageTypeID > 0)
                    subPageQuery = subPageQuery.Where(x => (x.id == category.SubPageTypeID));
                //---------------------------------------------------------
                var subPage = subPageQuery.FirstOrDefault();

                if (pageType == null || subPage == null) continue;

                // Detail Page
                string detailPage = pageType.DetailPage ?? subPage.DetailPage;
                string detailRoute = category.MetaUrl + "/{sayfalink}";

                if (!string.IsNullOrEmpty(detailPage))
                {
                    routes.Add($"Detail{category.MetaUrl}{category.id}",
                        new Route(detailRoute,
                        new PageRouteHandler("~/" + detailPage)));
                    myRoutesList.Add($"Detail-{category.MetaUrl}{category.id}~{detailRoute}~/{detailPage}");
                }

                // Listing Page
                string listingPage = pageType.ListingPage ?? subPage.ListingPage;
                string listRoute = category.MetaUrl + "/{katlink}/";

                if (!string.IsNullOrEmpty(listingPage))
                {
                    routes.Add($"List{category.MetaUrl}{category.id}",
                        new Route(listRoute,
                        new PageRouteHandler("~/" + listingPage)));
                    myRoutesList.Add($"List-{category.MetaUrl}{category.id}~{listRoute}~/{listingPage}");

                    // Fixed content
                    if (Convert.ToBoolean(pageType.isContentFixed))
                    {
                        AddFixedContentRoutes(routes, category, listingPage, myRoutesList);
                    }
                    else
                    {
                        routes.Add($"ListAndDetail{category.MetaUrl}{category.id}",
                            new Route(category.MetaUrl + "/",
                            new PageRouteHandler("~/" + listingPage + "")));
                        myRoutesList.Add($"ListAndDetail-{category.MetaUrl}{category.id}~{category.MetaUrl}~/{listingPage}");
                    }
                }
            }

            var recordsList = StaticList.Records.Where(x => (x.Approved == 1));
            foreach (var item in recordsList)
            {

                int PageTypeID = (item._PageTypeID != null ? Convert.ToInt32(item._PageTypeID) : 0);
                var pageType = StaticList.PageTypes.Where(x => (x.id == PageTypeID) && (x.Approved == 1)).FirstOrDefault();
                RouteTable.Routes.Add("DetailRecords" + item.MetaUrl + item.id,
                    new Route(item.MetaUrl,
                    new PageRouteHandler("~/" + pageType.DetailPage + "")));
                myRoutesList.Add($"DetailRecords-{item.MetaUrl}{item.id}~{item.MetaUrl}~/{pageType.DetailPage}");
            }
        }
        //---------------------------------------------------------

        private void AddDynamicRoutesForLanguages(RouteCollection routes, List<string> myRoutesList, string LanguageID, string LanguageCode)
        {
            var categoriesList = Bll.GeneralCategories.Select(0, " AND Approved=1", lang: LanguageID);
            foreach (var category in categoriesList)
            {
                var pageType = StaticList.PageTypes.Where(x => (x.id == category.PageTypeID) && (x.Approved == 1)).FirstOrDefault();
                var subPageQuery = StaticList.PageTypes.Where(x => (x.Approved == 1));
                if (category.SubPageTypeID > 0)
                    subPageQuery = subPageQuery.Where(x => (x.id == category.SubPageTypeID));
                //---------------------------------------------------------
                var subPage = subPageQuery.FirstOrDefault();

                if (pageType == null || subPage == null) continue;

                // Detail Page
                string detailPage = pageType.DetailPage ?? subPage.DetailPage;
                string detailRoute = "{language}/" + category._MetaUrl + "/{sayfalink}";
                if (!String.IsNullOrEmpty(detailPage) && !String.IsNullOrEmpty(category._MetaUrl))
                {
                    routes.Add($"Detail{LanguageCode}{category._MetaUrl}{category.id}",
                        new Route(detailRoute,
                        new PageRouteHandler("~/" + detailPage)));
                    myRoutesList.Add($"Detail-{LanguageCode}{category._MetaUrl}{category.id}~{detailRoute}~/{detailPage}");
                }

                // Listing Page
                string listingPage = pageType.ListingPage ?? subPage.ListingPage;
                string listRoute = "{language}/" + category._MetaUrl + "/{katlink}/";

                if (!String.IsNullOrEmpty(listingPage) && !String.IsNullOrEmpty(category._MetaUrl))
                {
                    routes.Add($"List{LanguageCode}{category._MetaUrl}{category.id}",
                        new Route(listRoute,
                        new PageRouteHandler("~/" + listingPage)));
                    myRoutesList.Add($"List-{LanguageCode}{category._MetaUrl}{category.id}~{listRoute}~/{listingPage}");

                    // Fixed content
                    if (Convert.ToBoolean(pageType.isContentFixed))
                    {
                        AddFixedContentRoutesLanguage(routes, category, listingPage, myRoutesList, LanguageCode);
                    }
                    else
                    {
                        routes.Add($"ListAndDetail{LanguageCode}{category._MetaUrl}{category.id}",
                            new Route(LanguageCode + "/" + category._MetaUrl + "/",
                            new PageRouteHandler("~/" + listingPage + "")));
                        myRoutesList.Add($"ListAndDetail-{LanguageCode}{category._MetaUrl}{category.id}~{category._MetaUrl}~/{listingPage}");
                    }
                }
            }

            var recordsList = Bll.GeneralRecords.Select(0, " AND Approved=1", lang: LanguageID);
            foreach (var item in recordsList)
            {
                if (!String.IsNullOrEmpty(item._MetaUrl))
                {
                    var pageType = StaticList.PageTypes.Where(x => (x.id == Convert.ToInt32(item._PageTypeID)) && (x.Approved == 1)).FirstOrDefault();
                    RouteTable.Routes.Add("DetailRecords" + LanguageCode + item._MetaUrl + item.id,
                        new Route(LanguageCode + "/" + item._MetaUrl,
                        new PageRouteHandler("~/" + pageType.DetailPage + "")));
                    myRoutesList.Add($"DetailRecords-{item._MetaUrl}{item.id}~{item._MetaUrl}~/{pageType.DetailPage}");
                }
            }
        }
        //---------------------------------------------------------

        private void AddFixedContentRoutes(RouteCollection routes, Entities.GeneralCategories category, string listingPage, List<string> myRoutesList)
        {
            try
            {
                var recordList = StaticList.Records.Where(x => (x.MetaUrl == category.MetaUrl)).ToList();
                string routeKey = recordList.Count > 0 ? recordList[0].MetaUrl : category.MetaUrl;
                routes.Add($"ListAndDetail{category.MetaUrl}{category.id}", new Route(routeKey + "/", new PageRouteHandler("~/" + listingPage)));
                myRoutesList.Add($"ListAndDetail-{category.MetaUrl}{category.id}~{routeKey}/~/{listingPage}");
            }
            catch
            {
                routes.Add($"ListAndDetail{category.MetaUrl}{category.id}", new Route(category.MetaUrl + "/", new PageRouteHandler("~/" + listingPage)));
                myRoutesList.Add($"ListAndDetail-{category.MetaUrl}{category.id}~{category.MetaUrl}/~/{listingPage}");
            }
        }
        //---------------------------------------------------------

        private void AddFixedContentRoutesLanguage(RouteCollection routes, Entities.GeneralCategories category, string listingPage, List<string> myRoutesList, string LanguageCode)
        {
            try
            {
                var recordList = StaticList.Records.Where(x => (x._MetaUrl == category._MetaUrl)).ToList();
                string routeKey = LanguageCode + "/" + (recordList.Count > 0 ? recordList[0]._MetaUrl : category._MetaUrl);
                routes.Add($"ListAndDetail{LanguageCode}{category._MetaUrl}{category.id}", new Route(routeKey + "/", new PageRouteHandler("~/" + listingPage)));
                myRoutesList.Add($"ListAndDetail-{LanguageCode}{category._MetaUrl}{category.id}~{routeKey}/~/{listingPage}");
            }
            catch
            {
                routes.Add($"ListAndDetail{LanguageCode}{category._MetaUrl}{category.id}", new Route(LanguageCode + "/" + category._MetaUrl + "/", new PageRouteHandler("~/" + listingPage)));
                myRoutesList.Add($"ListAndDetail-{LanguageCode}{category._MetaUrl}{category.id}~{category._MetaUrl}/~/{listingPage}");
            }
        }
        //---------------------------------------------------------

        private void AddStaticRoutes(RouteCollection routes)
        {
            routes.Add("sitemap", new Route("sitemap", new PageRouteHandler("~/Sitemap.aspx")));
            routes.Add("404", new Route("{sayfalink}", new PageRouteHandler("~/404.aspx")));
        }
        //---------------------------------------------------------

        #endregion


    }
}