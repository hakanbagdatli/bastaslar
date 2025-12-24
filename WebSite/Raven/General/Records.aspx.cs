using System;
using Tools;
using System.Web.UI.WebControls;
using Entities;
using System.Linq;

namespace WebSite.Raven.General
{
    public partial class Records : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0, PageTypeID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 23);
            PageProperties(Language.GetFixed("IcerikYonetimi"), 4);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            #region parameters
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID in (" + Select.MultipleCategoryID(CatID) + ")";
                Entities.GeneralCategories _category = StaticList.Categories.Where(x => (x.id == CatID)).FirstOrDefault();
                Breadcrumb.Add(_category.Title.ToString(), Developer.ConstantUrl("category") + "?dhx=edit&catid=0&id=" + CatID);
            }
            //---------------------------------------------------------
            if (Request["ptype"] != null)
                PageTypeID = Convert.ToInt32(Request["ptype"].ToString());
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("content") + "?catid=" + CatID + "&ptype=" + PageTypeID);
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("content") + "?catid=" + CatID + "&ptype=" + PageTypeID);
                    Breadcrumb.SetTree(Language.GetFixed("YeniKayit"), ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion

            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            if (PageTypeID == 15 || PageTypeID == 16)
                hdnMenuID.Value = "1";
            else
                hdnMenuID.Value = MenuID.ToString();

        }
        //--------------------------------------------------------- breadcrumb and parameters

    }
}