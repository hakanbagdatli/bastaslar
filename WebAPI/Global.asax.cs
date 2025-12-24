using System;
using Utility;
using Entities;
using System.Web.Mvc;
using System.Web.Http;
using System.Configuration;
using System.Web.Routing;
using WebAPI.Handlers;
using System.Linq;

namespace WebAPI
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            #region Database Connection
            Constant.dbName = ConfigurationManager.AppSettings["db_name"];
            Constant.dbNameTwin = ConfigurationManager.AppSettings["db_name_twin"];
            try { Constant.ConnectionString = StringCipher.Decrypt(ConfigurationManager.ConnectionStrings["con"].ConnectionString); }
            catch { Constant.ConnectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString; }
            #endregion

            #region Static Lists
            StaticList.Settings = Bll.zSettings.Select(1, filter: "")[0];
            Feature.ActiveLanguage = StaticList.Settings.DefaultLanguage.ToString();
            StaticList.LanguageCodes = Bll.zLangCodes.Select(0, filter: " AND Approved=1");
            StaticList.ActiveSite = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0];
            StaticList.SiteLangConstants = Bll.LangFixed.Select(0, filter: "");
            //---------------------------------------------------------
            StaticList.PageTypes = Bll.zPageTypes.Select(0, filter: "");
            StaticList.Defines = Bll.zDefineDetails.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id DESC");
            StaticList.Categories = Bll.GeneralCategories.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
            StaticList.Records = Bll.GeneralRecords.Select(0, filter: "", sorting: " Sorting ASC, id DESC");
            #endregion

            GlobalConfiguration.Configuration.MessageHandlers.Add(new APIKeyMessageHandler());
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            //BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_End(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on application shutdown

        protected void Application_Error(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs when an unhandled error occurs

        protected void Session_Start(object sender, EventArgs e) { }
        //--------------------------------------------------------- SessionStart

        protected void Session_End(object sender, EventArgs e) { }
        //--------------------------------------------------------- SessionEnd

        protected void Application_AuthenticateRequest(object sender, EventArgs e) { }

        protected void Application_BeginRequest(object sender, EventArgs e) { }
        //--------------------------------------------------------- Code that runs on application start
    }
}
