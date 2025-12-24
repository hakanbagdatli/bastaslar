using Tools;
using System;
using Utility;
using Newtonsoft.Json.Linq;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace WebSite.Raven.Inspection
{
    public partial class Calendar : System.Web.UI.Page
    {
        public int RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 16);
            PageProperties(Language.GetFixed("Takvim"), 2);
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
                string JsonText = "";
                List<Entities.Inspections> inspectList = Bll.Inspections.Select(0, " AND Approved=1");
                foreach (var item in inspectList)
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
                List<Entities.Assignments> assignList = Bll.Assignments.Select(0, " AND Approved=1");
                foreach (var item in assignList)
                {
                    string AppointmentDate = Convert.ToDateTime(item.TaskDate).ToString("yyyy-MM-dd") + "T" + Convert.ToDateTime(item.TaskTime).ToString("HH:mm:ss");
                    string UserNames = string.Join(", ", item._Users.Select(user => user.Name + " " + user.Surname));
                    JsonText += CreateJSON(
                            item.id.ToString(),
                            Language.GetFixed("IsAtama") + " - " + item.Title,
                            AppointmentDate,
                            UserNames,
                            "fc-event-warning", "0") + ",";
                }
                //-------------------------------------------------------------------
                if (!String.IsNullOrEmpty(JsonText))
                    JsonText = EditJSON(Helper.DeleteLastChar(JsonText));
                return JsonText;
            }
        }
        //------------------------------------------------------------------- randevuları json olarak dön
    }
}