using Tools;
using System;
using Utility;
using Entities;
using System.Linq;
using System.Web.Http;
using System.Collections.Generic;

namespace WebAPI.Controllers
{
    public class ProjectController : ApiController
    {

        [HttpPost]
        public object List([FromBody] Entities.Service.ProjectSearch value)
        {
            try
            {
                //---------------------------------------------------------
                if (value != null)
                {

                    var _idList = Select.MultipleCategoryID(3).Split(',').Select(int.Parse).ToList();
                    var query = StaticList.Records.Where(x => (_idList.Contains(x.CatID)) && (x.Approved == 1)).ToList();
                    if (value.id > 0)
                        query = query.Where(x => x.id == value.id).ToList();
                    //---------------------------------------------------------
                    if (value.Statu > 0)
                        query = query.Where(x => x.PropertyStatu == value.Statu).ToList();
                    //---------------------------------------------------------
                    if (!String.IsNullOrEmpty(value.Title))
                        query = query.Where(x => x.Title.ToLower().Contains(value.Title)).ToList();
                    //---------------------------------------------------------
                    List<Entities.Service.ProjectList> dataList = new List<Entities.Service.ProjectList>();
                    foreach (var item in query)
                    {
                        List<Entities.GeneralPlans> propertyList = Bll.GeneralPlans.Select(0, filter: " AND CatID=" + item.id + " AND Approved=1", sorting: " Sorting ASC, Title ASC");
                        dataList.Add(
                            new Entities.Service.ProjectList
                            {
                                id = item.id,
                                Project = item._CategoryName,
                                Title = item.Title,
                                Photo = "https://" + StaticList.Settings.SiteLink + Feature.ImageFolder + item.Image,
                                ShortContent = item.ShortContent,
                                MainContent = item.MainContent,
                                PropertyType = item._PropertyType,
                                PropertyStatu = item._PropertyStatu,
                                PropertySize = item.PropertySize,
                                PropertyFlatCount = item.PropertyFlatCount,
                                PropertyStartDate = item.PropertyStartDate,
                                PropertyEndDate = item.PropertyEndDate,
                                PropertyProvince = item._PropertyProvince,
                                Properties = GetProperties(item.id)

                            }
                        );
                    }
                    //---------------------------------------------------------
                    if (dataList.Count > 0)
                        return Json(Function.ApiResultMessage(dataList, query.Count, value.RowCount, value.CurrentPage, true, ""));
                }
                //---------------------------------------------------------
                return Json(Function.ApiResultMessage("", 0, 0, 0, false, "Lütfen arama değerlerini dökümanda belirtildiği şekilde giriniz."));
            }
            catch (Exception ex) { return Json(Function.ApiResultMessage("", 0, 0, 0, false, ex.Message.ToString())); }
        }
        //--------------------------------------------------------- proje listesi

        protected List<Entities.Service.PropertyList> GetProperties(int ProjectID)
        {
            List<Entities.Service.PropertyList> dataList = new List<Entities.Service.PropertyList>();
            List<Entities.GeneralPlans> propertyList = Bll.GeneralPlans.Select(0, filter: " AND CatID=" + ProjectID + " AND Approved=1", sorting: " Sorting ASC, Title ASC");
            foreach (var item in propertyList)
            {
                dataList.Add( new Entities.Service.PropertyList
                {
                    id = item.id,
                    Title = item.Title,
                    ShortContent = item.ShortContent,
                    MainContent = item.MainContent,
                    Photo = !String.IsNullOrEmpty(item.Image) ? "https://" + StaticList.Settings.SiteLink + Feature.ImageFolder + item.Image : "",
                    PropertyID = item.PropertyID,
                    Property3ID = item.Property3ID,
                    PropertyUnitType = item.PropertyUnitType,
                    PropertyPrice = item.PropertyPrice,
                    PropertySize = item.PropertySize,
                    PropertyBath = item.PropertyBath,
                    PropertyBedroom = item.PropertyBedroom,
                    PropertyVirtualTour = item.PropertyVirtualTour,
                    PropertyStatus = item.PropertyStatus
                });
            }
            return dataList;
        }
        //--------------------------------------------------------- property listesi


    }
}