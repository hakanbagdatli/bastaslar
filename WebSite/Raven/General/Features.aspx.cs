using System;
using Tools;
using System.Web.UI.WebControls;
using Entities;
using System.Linq;

namespace WebSite.Raven.General
{
    public partial class Features : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0, PageTypeID = 0, LangID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 23);
            PageProperties(Language.GetFixed("Ozellikler"), 4);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {

            #region parameters
            if (Request["lang"] != null)
                LangID = Convert.ToInt32(Request["lang"].ToString());
            //---------------------------------------------------------
            if (Request["ptype"] != null)
                PageTypeID = Convert.ToInt32(Request["ptype"].ToString());
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID=" + CatID;
                Entities.GeneralRecords _record = StaticList.Records.Where(x => (x.id == CatID)).FirstOrDefault();
                Breadcrumb.Add(_record.Title, Developer.ConstantUrl("content") + "?dhx=edit&id=" + CatID + "&catid="  + _record.CatID.ToString() + "&ptype=" + PageTypeID);
            }
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("features") + "?catid=" + CatID + "&ptype=" + PageTypeID);
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("features") + "?catid=" + CatID + "&ptype=" + PageTypeID);
                    Breadcrumb.SetTree(Language.GetFixed("YeniKayit"), ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion

            if (PageTypeID == 15)
                MenuID = 2;
            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = MenuID.ToString();
            
        }
        //--------------------------------------------------------- breadcrumb and parameters

    }
}