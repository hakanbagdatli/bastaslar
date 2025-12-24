using Tools;
using System;
using Utility;
using Entities;
using System.Linq;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace WebSite
{
    public partial class About : System.Web.UI.Page
    {
        public int PageTypeID = 0;
        public List<Entities.GeneralRecords> dataList;
        public List<Entities.GeneralPhotos> photoList;
        public List<Entities.GeneralFiles> fileList;
        public List<Entities.GeneralVideos> videoList;
        public List<Entities.GeneralFeatures> featureList;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    Details();
            }
            catch { }
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void Details()
        {
            string pageurl = "";
            //---------------------------------------------------------
            if (RouteData.Values["sayfalink"] == null)
                pageurl = Handler.WithoutGlobalRequest();
            else
                pageurl = RouteData.Values["sayfalink"].ToString();
            //---------------------------------------------------------
            dataList = StaticList.Records.Where(x => (x.MetaUrl == pageurl || x._MetaUrl == pageurl) && (x.Approved == 1)).ToList();
            //---------------------------------------------------------
            if (dataList.Count > 0)
            {
                foreach (var item in dataList)
                {
                    PageTypeID = Convert.ToInt32(item._PageTypeID);
                    //---------------------------------------------------------
                    PageProperties(item.id, item.CatID,
                        Handler.SetText(item.Title, item._Title),
                        Handler.SetText(item.MetaTitle, item._MetaTitle),
                        Handler.SetText(item.AdditionalTitle, item._AdditionalTitle),
                        Handler.SetText(item.Description, item._Description),
                        Handler.SetText(item.Keywords, item._Keywords));
                    //---------------------------------------------------------
                    //DetailGallery(item.id);
                    //DetailFiles(item.id);
                    DetayVideos(item.id);
                    DetailFeatures(item.id);
                }
            }
            else
                Response.Redirect("/" + pageurl);
        }
        //--------------------------------------------------------- page contents

        protected void PageProperties(int RecordID, int CatID, string Title, string MetaTitle, string H1Title, string Description, string Keywords)
        {
            #region language
            HiddenField hdnID = (HiddenField)this.Master.FindControl("hdnID");
            HiddenField hdnCatID = (HiddenField)this.Master.FindControl("hdnCatID");
            hdnID.Value = RecordID.ToString();
            hdnCatID.Value = CatID.ToString();
            #endregion

            #region metaTags
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
            Breadcrumb.MultipleTreeDetailWhereAmI(CatID, Title, MetaTitle, lblBreadcrumb, this.Page);
            #endregion
        }
        //--------------------------------------------------------- description, meta tag vs.

        protected void DetailGallery(int RecordID)
        {
            photoList = Bll.GeneralPhotos.Select(0, filter: " AND LangID in(0," + Feature.ActiveLanguage + ") AND CatID=" + RecordID + " AND Approved=1 AND Image<>''", sorting: " Sorting ASC, id DESC ");
            //if (photoList.Count > 0)
            //    pnlPhotos.Visible = true;
        }
        //--------------------------------------------------------- photoGallery

        protected void DetailFiles(int RecordID)
        {
            fileList = Bll.GeneralFiles.Select(0, filter: " AND LangID in(0," + Feature.ActiveLanguage + ") AND CatID=" + RecordID + " AND Approved=1 AND Filename<>''", sorting: " Sorting ASC, id DESC");
            //if (fileList.Count > 0)
            //pnlFiles.Visible = true;
        }
        //--------------------------------------------------------- includedFiles

        protected void DetayVideos(int RecordID)
        {
            videoList = Bll.GeneralVideos.Select(0, filter: " AND LangID in(0," + Feature.ActiveLanguage + ") AND CatID=" + RecordID + " AND Approved=1", sorting: " Sorting ASC, id DESC");
            //if (videoList.Count > 0)
            //pnlVideos.Visible = true;
        }
        //--------------------------------------------------------- videoGallery 

        protected void DetailFeatures(int RecordID)
        {
            featureList = Bll.GeneralFeatures.Select(0, filter: " AND LangID in(0," + Feature.ActiveLanguage + ")  AND CatID=" + RecordID + " AND Approved=1", sorting: " Sorting ASC, id DESC");
            //if (featureList.Count > 0)
            //pnlFeatures.Visible = true;
        }
        //--------------------------------------------------------- specialPageFeatures
    }
}