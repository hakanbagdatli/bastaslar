using Tools;
using System;
using System.Web.UI.WebControls;
using Entities;
using System.Linq;

namespace WebSite.Raven.Translate
{
    public partial class Categories : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 22);
            PageProperties(Language.GetFixed("DilYonetimi"), 4);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = MenuID.ToString();
            //---------------------------------------------------------


            #region parameters
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID=" + CatID;
                Entities.GeneralCategories _category = StaticList.Categories.Where(x => (x.id == CatID)).FirstOrDefault();
                Breadcrumb.Add(_category.Title.ToString(), Developer.ConstantUrl("category") + "?dhx=edit&catid=0&id=" + CatID);
            }
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("content") + "?catid=" + CatID);
                    Breadcrumb.SetTree("Bilgileri Düzenle", ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("content") + "?catid=" + CatID);
                    Breadcrumb.SetTree("Yeni Kayıt Ekle", ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion
        }
        //--------------------------------------------------------- breadcrumb and parameters
    }
}