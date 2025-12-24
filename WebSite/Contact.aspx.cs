using Tools;
using System;
using Entities;
using System.Linq;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace WebSite
{
    public partial class Contact : System.Web.UI.Page
    {
        public List<Entities.GeneralCategories> dataList;
        public List<Entities.GeneralContacts> contactList;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    PageInformation();
            }
            catch { }
        }
        //--------------------------------------------- pageLoad İşlemleri

        protected void PageInformation()
        {
            string pageurl = "";
            //---------------------------------------------------------
            if (RouteData.Values["katlink"] == null)
                pageurl = Handler.WithoutGlobalRequest();
            else
                pageurl = RouteData.Values["katlink"].ToString();
            //---------------------------------------------------------
            dataList = StaticList.Categories.Where(x => (x.MetaUrl == pageurl || x._MetaUrl == pageurl) && (x.Approved == 1)).ToList();
            if (dataList.Count > 0)
            {
                foreach (var item in dataList)
                {
                    contactList = Bll.GeneralContacts.Select(0, " AND CatID=" + item.id + " AND Approved=1", sorting: " Sorting ASC, id ASC");
                    PageProperties(item.id,
                        Handler.SetText(item.Title, item._Title),
                        Handler.SetText(item.MetaTitle, item._MetaTitle),
                        Handler.SetText(item.AdditionalTitle, item._AdditionalTitle),
                        Handler.SetText(item.Description, item._Description),
                        Handler.SetText(item.Keywords, item._Keywords));
                }
            }
            else { Response.Redirect("/" + pageurl); }
        }
        //--------------------------------------------- kateogori bilgileri

        protected void PageProperties(int CatID, string Title, string MetaTitle, string H1Title, string Description, string Keywords)
        {
            #region language
            HiddenField hdnID = (HiddenField)this.Master.FindControl("hdnID");
            HiddenField hdnCatID = (HiddenField)this.Master.FindControl("hdnCatID");
            hdnID.Value = "0";
            hdnCatID.Value = CatID.ToString();
            #endregion

            #region meta tags
            Literal lblOgTitle = this.Master.FindControl("lblOgTitle") as Literal;
            Literal lblOgDescription = this.Master.FindControl("lblOgDescription") as Literal;
            Literal lblDescription = this.Master.FindControl("lblDescription") as Literal;
            Literal lblKeywords = this.Master.FindControl("lblKeywords") as Literal;
            //---------------------------------------------
            Handler.SetMetaTags(Title, Description, Keywords, lblDescription, lblKeywords, lblOgTitle, lblOgDescription);
            #endregion

            #region page header
            Literal lblTitle = (Literal)PageHeader.FindControl("lblTitle");
            Literal lblBreadcrumb = (Literal)PageHeader.FindControl("lblBreadcrumb");
            //---------------------------------------------
            lblTitle.Text = H1Title;
            Breadcrumb.SingleTreeWhereAmI(Title, MetaTitle, lblBreadcrumb, this.Page);
            #endregion
        }
        //--------------------------------------------------------- description, meta tag vs.
    }
}