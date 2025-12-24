using Tools;
using System;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using Entities;
using System.Linq;

namespace WebSite.Raven.General
{
    public partial class Categories : System.Web.UI.Page
    {
        public int CatID = 0, RecordID = 0, SubPageTypeID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 22);
            PageProperties(Language.GetFixed("KategoriYonetimi"), 4);
            Paramaters();
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int CatID)
        {
            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = CatID.ToString();
            //---------------------------------------------------------
            Breadcrumb.SetTree(Title, ltrTree, this.Page);
        }
        //--------------------------------------------------------- breadcrumb

        protected void Paramaters()
        {
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
            }
            else
                DataList();
            //---------------------------------------------------------
            if (Request["catid"] != null)
                CatID = Convert.ToInt32(Request["catid"].ToString());
            //---------------------------------------------------------
            if (Request["sptype"] != null)
                SubPageTypeID = Convert.ToInt32(Request["sptype"].ToString());

        }
        //--------------------------------------------------------- paramaters

        #region Data List

        protected void DataList()
        {
            System.Text.StringBuilder shtml = new System.Text.StringBuilder();
            List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => (x.CatID == 0)).ToList();
            //---------------------------------------------------------
            if (dataList.Count > 0)
            {
                foreach (var item in dataList)
                {
                    shtml.Append(GeneralList(item));
                    //---------------------------------------------------------
                    if (Developer.HasSubMenu(item.id))
                        shtml.Append(ListSubCategory(item.id));

                }
            }
            ltrlList.Text = shtml.ToString();
        }
        //--------------------------------------------------------- ana menüleri listele

        protected string ListSubCategory(int CatID)
        {
            System.Text.StringBuilder shtml = new System.Text.StringBuilder();
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.CatID == CatID)).ToList();
            //---------------------------------------------------------
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    shtml.Append(GeneralList(item));
                    shtml.Append(ListSubCategory(item.id));
                }
            }
            return shtml.ToString();
        }
        //--------------------------------------------------------- alt menüleri listele

        protected string GeneralList(Entities.GeneralCategories item)
        {
            string list = "", approv = "";
            System.Text.StringBuilder shtml = new System.Text.StringBuilder();

            #region alt kategori mi?

            if (Convert.ToInt32(item.CatID) == 0)
            {
                if (Developer.HasSubMenu(item.id))
                    shtml.Append("<tr class='list-data mainmenu' data-id='" + item.id + "'>");
                else
                    shtml.Append("<tr class='list-data' data-id='" + item.id + "'>");
            }
            //--------------------------------------------------------- ana kategori ise
            else
            {
                if (Developer.HasSubMenu(item.id))
                    shtml.Append("<tr class='list-data submenu hidden accordion" + item.CatID + "' data-id='" + item.id + "' style='background-color:#f7f7f7'>");
                else
                    shtml.Append("<tr class='list-data hidden accordion" + item.CatID + "' data-id='" + item.id + "' style='background-color:#eef0f8'>");
            }
            //--------------------------------------------------------- alt kategori ise

            #endregion

            shtml.Append("<td><a href='" + Select.GlobalSiteLink(item.PageTypeID, item.id) + "' target='_blank'><i class='la la-external-link'></i>&nbsp;" + item.id + "</a></td>");
            //--------------------------------------------------------- id

            #region title column

            if (Convert.ToInt32(item.CatID) == 0)
                list = "<td>";
            else
                list = "<td><img src='/raven/assets/media/more.gif' />&emsp;";
            //--------------------------------------------------------- alt kategori mi

            shtml.Append(list + "<a href='javascript:;' data-toggle='tooltip' data-theme='dark' title='" + Select.MultipleCategoryName(item.id) + "' style='color:#3F4254;'>" + item.Title + "</a></td>");
            //--------------------------------------------------------- column

            #endregion

            shtml.Append("<td><input id='txtSort" + item.id + "' name='Sorting' type='text' class='form-control list-form-data center' autocomplete='off' value='" + item.Sorting + "' /></td>");
            //--------------------------------------------------------- sorting

            #region approved
            if (Convert.ToBoolean(item.Approved) == true)
                approv = " checked";

            shtml.Append("<td><div class='checkbox-list'><label class='checkbox'><input id='ckApp" + item.id + "' name='Approved' type='checkbox' class='list-form-data'" + approv + "/><span></span></label></div></td>");
            //--------------------------------------------------------- approved
            #endregion

            shtml.Append("<td><div class='checkbox-list'><label class='checkbox'><input id='ckDel" + item.id + "' name='isDeleted' type='checkbox' class='list-form-data' /><span></span></label></div></td>");
            //--------------------------------------------------------- isDeleted


            shtml.Append("<td>");
            shtml.Append("<a href='?dhx=edit&catid=" + item.CatID + "&id=" + item.id + "' data-toggle='tooltip' data-theme='dark' title='Kategori Düzenle' class='label label-xl label-outline-primary mr-1'><i class='la la-edit'></i></a>");
            //--------------------------------------------------------- Düzenle

            #region add sub category
            if (Convert.ToBoolean(item.canAddSubCategory))
                shtml.Append("<a href='?dhx=add&catid=" + item.id + "&sptype=" + item.SubPageTypeID + "' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("AltKategoriEkle") + "' class='label label-xl label-outline-warning mr-1'><i class='la la-plus'></i></a>");
            else
                shtml.Append("<a href='javascript:;' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("AltKategoriEklenemez") + "' class='label label-xl mr-1'><i class='la la-warning'></i></a>");
            #endregion


            shtml.Append("<a href='/raven/category-languages?catid=" + item.id + "' data-toggle='tooltip' data-theme='dark' title='Dil Seçenekleri' class='label label-xl label-outline-warning mr-1'><i class='la la-language'></i></a>");
            //--------------------------------------------------------- Dil Seçenekleri

            #region add content
            if (Convert.ToBoolean(item.canAddContent))
                shtml.Append("<a href='/raven" + StaticList.PageTypes.Where(x => (x.id == item.PageTypeID)).FirstOrDefault().AdminUrl + "?catid=" + item.id + "&ptype=" + item.PageTypeID + "' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("IcerikEkle") + "' class='label label-xl label-outline-success mr-1'><i class='la la-mail-forward'></i></a>");
            else
                shtml.Append("<a href='javascript:;' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("IcerikEklenemez") + "' class='label label-xl mr-1'><i class='la la-warning'></i></a>");
            #endregion

            #region can delete
            if (Convert.ToBoolean(item.canDelete))
                shtml.Append("<a href='javascript:;' onclick='Delete(" + item.id + ")' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("Sil") + "' class='label label-xl label-outline-danger mr-1'><i class='la la-trash'></i></a>");
            else
                shtml.Append("<a href='javascript:;' data-toggle='tooltip' data-theme='dark' title='" + Language.GetFixed("Silinemez") + "' class='label label-xl mr-1'><i class='la la-warning'></i></a>");
            #endregion

            shtml.Append("</td>");

            shtml.Append("</tr>");
            return shtml.ToString();
        }
        //--------------------------------------------------------- verileri datatable aktar

        #endregion

    }
}