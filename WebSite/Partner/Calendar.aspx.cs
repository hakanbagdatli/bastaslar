using Tools;
using System;
using Utility;
using System.Linq;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using Entities.Items;
using System.Web.UI.WebControls;
using Entities;
using System.Web;

namespace WebSite.Partner
{
    public partial class Calendar : System.Web.UI.Page
    {
        public int RecordID = 0;
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetPartner("Takvim"));
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title)
        {
            Page.Title = Title;
            //---------------------------------------------------------
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters

        protected string CreateJSON(string id, string title, string start, string description, string className, string room)
        {
            JObject list = new JObject(
                   new JProperty("id", id),
                   new JProperty("title", title),
                   new JProperty("start", start),
                   new JProperty("description", description),
                   new JProperty("className", className),
                   new JProperty("room", room));
            return list.ToString();
        }
        //------------------------------------------------------------------- json for attractions location

        protected string EditJSON(string json)
        {
            return json.Replace("\"id\"", "id").Replace("\"title\"", "title").Replace("\"start\"", "start").Replace("\"description\"", "description").Replace("\"className\"", "className").Replace("\"", "'");
        }
        //------------------------------------------------------------------- jsonı düzenle

        public string GetJSONData
        {
            get
            {
                try
                {

                    string JsonText = "";
                    string whereClause = " AND Approved=1 AND Statu>1 AND AgencyID=" + UserData.CatID;
                    //---------------------------------------------------------
                    if (UserData.CatID == 1)
                        whereClause = " AND Approved=1 AND Statu>1";
                    //---------------------------------------------------------
                    List<Entities.Inspections> dList = Bll.Inspections.Select(0, whereClause);
                    foreach (var item in dList)
                    {
                        string AppointmentDate = Convert.ToDateTime(item.PresentationDate).ToString("yyyy-MM-dd") + "T" + Convert.ToDateTime(item.PresentationTime).ToString("HH:mm:ss");
                        string Clients = string.Join(", ", Bll.Attendees.Select(0, " AND id in (" + item.Clients + ")").ToList().Select(attend => attend.Fullname));
                        string ProjectName = string.Join(", ", item._Projects.Select(project => project.Title)).Replace("'", "");
                        JsonText += CreateJSON(
                                id: item.id.ToString(),
                                title: item._SaleExecutive + " (" + item.PNRCode + ") - " + (item.TurID == 0 ? "Inspection" : "Property View"),
                                start: AppointmentDate,
                                description: "<b>Room : </b>" + item._MeetingRoom + "<br><b>Agency : </b>" + item._AgencyName + "<br><b>Clients : </b>" + Clients + "<br><b>Projects : </b>" + ProjectName,
                                className: "fc-event-" + item._StatuColor,
                                room: item.MeetingRoomID.ToString()
                            ) + ",";
                    }
                    //-------------------------------------------------------------------
                    List<Entities.Assignments> assignList = Bll.Assignments.Select(0, " AND UserID='" + UserData.id + "' AND Approved=1");
                    foreach (var item in assignList)
                    {
                        string AppointmentDate = Convert.ToDateTime(item.TaskDate).ToString("yyyy-MM-dd") + "T" + Convert.ToDateTime(item.TaskTime).ToString("HH:mm:ss");
                        string UserNames = string.Join(", ", item._Users.Select(user => user.Name + " " + user.Surname));
                        JsonText += CreateJSON(
                                item.id.ToString(),
                                Language.GetPartner("IsAtama") + " - " + item.Title,
                                AppointmentDate,
                                UserNames,
                                "fc-event-warning", "0") + ",";
                    }
                    //-------------------------------------------------------------------
                    if (!String.IsNullOrEmpty(JsonText))
                        JsonText = EditJSON(Helper.DeleteLastChar(JsonText));
                    //-------------------------------------------------------------------
                    return JsonText;
                }
                catch
                {
                    return "";
                }
            }
        }
        //------------------------------------------------------------------- randevuları json olarak dön


        public string SelectedLocale
        {
            get
            {
                try
                {
                    string Language = "en";
                    HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
                    if (RavenCookies != null)
                    {
                        Language = StaticList.LanguageCodes.
                            Where(x => x.id == Convert.ToInt32(RavenCookies.Values["RavenLang"])).
                            FirstOrDefault().Code.ToLower();
                    }
                    //---------------------------------------------------------
                    return Language;
                }
                catch
                {
                    return "en";
                }
            }
        }
        //------------------------------------------------------------------- randevuları json olarak dön
    }
}