using Tools;
using System;
using Entities;
using System.Linq;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace WebSite
{
    public partial class Products : System.Web.UI.Page
    {
        public string PageTitle = "";
        public int PageTypeID = 0, PageID = 1;
        public List<Entities.GeneralCategories> categoryList;
        public List<Entities.GeneralCategories> dataList;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                QueryStrings();
                //---------------------------------------------------------
                if (!IsPostBack)
                    PageInformation();
            }
            catch { }
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void QueryStrings()
        {
            if (Request["pi"] != null)
                try { PageID = Convert.ToInt32(Request["pi"].ToString()); } catch { PageID = 1; }
        }
        //--------------------------------------------------------- sayfaya özel parametreler

        protected void PageInformation()
        {
            string pageurl = "";
            //---------------------------------------------------------
            if (RouteData.Values["katlink"] == null)
                pageurl = Handler.WithoutGlobalRequest();
            else
                pageurl = RouteData.Values["katlink"].ToString();
            //---------------------------------------------------------
            categoryList = StaticList.Categories.Where(x => (x.MetaUrl == pageurl || x._MetaUrl == pageurl) && (x.Approved == 1)).ToList();
            if (categoryList.Count > 0)
            {
                foreach (var item in categoryList)
                {
                    PageTypeID = Convert.ToInt32(item.PageTypeID);
                    //---------------------------------------------------------
                    if (PageTypeID == 17)
                    {
                        PageHeader.Visible = false;
                        LeaseFilter.Visible = true;
                    }
                    //---------------------------------------------------------
                    PageProperties(item.id, 
                        Handler.SetText(item.Title, item._Title),
                        Handler.SetText(item.MetaTitle, item._MetaTitle),
                        Handler.SetText(item.AdditionalTitle, item._AdditionalTitle),
                        Handler.SetText(item.Description, item._Description),
                        Handler.SetText(item.Keywords, item._Keywords));
                    //---------------------------------------------------------
                    GeneralList(item.id, item._SortingType, Entities.StaticList.Settings.NumberofListings);
                }
            }
            else
                Response.Redirect("/" + pageurl);
        }
        //--------------------------------------------------------- kategori bilgileri

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

        protected void GeneralList(int CatID, string Sorting, int RowCount)
        {
            int SkippedRecord = (PageID - 1) * RowCount;
            dataList = StaticList.Categories.Where(x => (x.CatID == CatID) && (x.Approved == 1)).ToList();
            int RecordCount = dataList.Count;
            dataList = dataList.Skip(SkippedRecord).Take(RowCount).ToList();
            //---------------------------------------------------------
            if (dataList.Count > 0)
            {
                //---------------------------------------------------------
                //int TotalPageCount = (RecordCount / RowCount);
                //if (RecordCount > (TotalPageCount * RowCount))
                //    TotalPageCount++;
                ////---------------------------------------------------------
                //lblPagination.Text = Handler.MakePagination(TotalPageCount, PageID, Request.Url.ToString());
                //if (!String.IsNullOrEmpty(lblPagination.Text)) { pnlPagination.Visible = true; }
            }

        }
        //--------------------------------------------------------- kategoriye ait kayıtlar
    }
}