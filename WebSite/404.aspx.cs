using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class _404 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.StatusCode = 404;
            Response.TrySkipIisCustomErrors = true;
            Response.StatusDescription = "Page Not Found";
            PageProperties(Language.GetSite(30));
        }
        //--------------------------------------------- pageLoad İşlemleri

        protected void PageProperties(string Title)
        {
            #region metaTags
            Literal lblOgTitle = this.Master.FindControl("lblOgTitle") as Literal;
            Literal lblOgDescription = this.Master.FindControl("lblOgDescription") as Literal;
            Literal lblDescription = this.Master.FindControl("lblDescription") as Literal;
            Literal lblKeywords = this.Master.FindControl("lblKeywords") as Literal;
            //---------------------------------------------
            Handler.SetMetaTags(Title, Title, Title, lblDescription, lblKeywords, lblOgTitle, lblOgDescription);
            #endregion

            #region pageheader
            Literal lblTitle = (Literal)PageHeader.FindControl("lblTitle");
            Literal lblBreadcrumb = (Literal)PageHeader.FindControl("lblBreadcrumb");
            //---------------------------------------------
            lblTitle.Text = Title;
            Breadcrumb.SingleTreeWhereAmI(Title, Title, lblBreadcrumb, this.Page);
            #endregion
        }
        //--------------------------------------------------------- description, meta tag vs.
    }
}