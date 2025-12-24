using Tools;
using System;
using Utility;
using Entities;
using System.Web;
using Entities.Items;
using Newtonsoft.Json;
using System.Web.Services;
using System.Collections.Generic;

namespace WebSite
{
    [System.Web.Script.Services.ScriptService]
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

    public class AjaxRequest : System.Web.Services.WebService
    {

        public string today = DateTime.Now.ToString("dd.MM.yyyy");
        public string website = "https://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"];
        //public string IPNumber = HttpContext.Current.Request.ServerVariables["remote_addr"];
        public string IPNumber = "24.133.129.223";

        [WebMethod]
        public string SendForms(object value)
        {
            try
            {
                object lastAddedID = 0;
                var dataString = JsonConvert.SerializeObject(value);
                dataString = Helper.DeleteFirstChar(Helper.DeleteLastChar(dataString));
                Entities.Items.RootData data = JsonConvert.DeserializeObject<Entities.Items.RootData>(dataString);
                //---------------------------------------------------------
                string fullname = "", name = "", surname = "", phone = "", email = "", message = "", recordID = "";
                string[] parameters = new string[data.properties.Count + 2];
                string[] paramvalues = new string[data.properties.Count + 2];
                for (int i = 0; i < data.properties.Count; i++)
                {
                    switch (data.properties[i].id)
                    {
                        case "NameSurname":
                            fullname = Helper.FirstLetterUppercase(data.properties[i].value);
                            break;
                        case "FirstName":
                            name = Helper.FirstLetterUppercase(data.properties[i].value);
                            break;
                        case "LastName":
                            surname = Helper.FirstLetterUppercase(data.properties[i].value);
                            break;
                        case "Phone":
                            phone = data.properties[i].value;
                            break;
                        case "Email":
                            email = Helper.AllLetterLowercase(data.properties[i].value);
                            break;
                        case "Message":
                            message = data.properties[i].value;
                            break;
                        case "RecordID":
                            recordID = data.properties[i].value;
                            break;
                    }
                    //---------------------------------------------
                    parameters[i] = data.properties[i].name;
                    paramvalues[i] = data.properties[i].value;
                }
                parameters[data.properties.Count] = "IP Adresi";
                paramvalues[data.properties.Count] = IPNumber;
                parameters[data.properties.Count + 1] = "Kayıt Tarihi";
                paramvalues[data.properties.Count + 1] = today;
                //---------------------------------------------
                string mailtitle = Bll.FormCategories.Select(data.id, filter: "")[0].Title;
                string mailbody = Mailing.CreateTemplate(mailtitle, Mailing.CreateBody(parameters, paramvalues));
                //---------------------------------------------
                List<Entities.FormIncomings> newRecord = new List<Entities.FormIncomings>  {
                        new Entities.FormIncomings  {
                            CatID = data.id,
                            Number = Function.Random(),
                            NameSurname = fullname,
                            Email = email,
                            Phone = phone,
                            AdditionalData1 = message,
                            FullContent = mailbody,
                            IPNumber = IPNumber
                        }
                    };
                //---------------------------------------------
                foreach (var item in newRecord)
                {
                    item.CreatedDate = DateTime.Now;
                    lastAddedID = item.Save();
                }
                //---------------------------------------------
                Mailing.SendbySMTP(StaticList.Settings.Email, StaticList.Settings.CompanyName + " " + mailtitle + " [#" + lastAddedID + "]", mailbody);
                //---------------------------------------------
                return "true";
            }
            catch (Exception ex) { return ex.Message; }
        }
        //---------------------------------------------------------


    }
}
