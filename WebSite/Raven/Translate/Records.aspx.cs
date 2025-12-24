using Tools;
using System;
using System.Web.UI.WebControls;
using Entities;
using System.Linq;

namespace WebSite.Raven.Translate
{
    public partial class Records : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0, PageTypeID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 23);
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
                Entities.GeneralRecords _record = StaticList.Records.Where(x => (x.id == CatID)).FirstOrDefault();
                Breadcrumb.Add(_record.Title.ToString(), Developer.ConstantUrl("content") + "?dhx=edit&id=" + CatID);
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