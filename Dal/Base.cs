using System;
using System.Data;
using System.Linq;
using Dal.AdoNet;
using System.Reflection;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Dal
{
    public class Base
    {
        public static object Save(object data, string tableName, object con, object tran)
        {
            Type type = data.GetType();
            var props = type.GetProperties();
            Dictionary<string, object> _dic = new Dictionary<string, object>();
            bool updateMi = false;

            PropertyInfo propHasTwin = type.GetProperty("_hasTwin");
            PropertyInfo propHasIdentity = type.GetProperty("_hasIdentity");
            bool hasTwin = true;
            bool hasIdentity = true;
            if (propHasTwin != null)
                hasTwin = Convert.ToBoolean(propHasTwin.GetValue(data, null));

            if (propHasIdentity != null)
                hasIdentity = Convert.ToBoolean(propHasIdentity.GetValue(data, null));

            PropertyInfo prop_id = type.GetProperty("id");
            if (prop_id != null)
            {
                var id = prop_id.GetValue(data, null);
                if (Convert.ToInt32(id) > 0)
                {
                    _dic.Add(prop_id.Name, id);
                    updateMi = true;
                }
            }
            var propValidate = type.GetProperty("_ValidationMessage");
            string lastValForPropValidate = "";
            int startIndx = 0;
            if (hasIdentity)
                startIndx = 1;

            for (int i = startIndx; i < props.Length; i++)
            {
                PropertyInfo prop = props[i];

                var propValue = prop.GetValue(data, null);

                if (prop.Name.StartsWith("_")) // alttan tireli değişkenlerin anlamı select için kullanacağım diğer tablo alanlarıdır.
                    continue;
                else if (prop.PropertyType.Name == "DateTime" && propValue.ToString() == "01.01.0001 00:00:00")
                    propValue = null;

                if (propValidate != null)
                {
                    object[] attrs = prop.GetCustomAttributes(true);


                    foreach (System.Attribute attr in attrs)
                    {
                        if (attr is Entities.ValidateAttribute)
                        {
                            Entities.ValidateAttribute _attr = (Entities.ValidateAttribute)attr;
                            bool isOk = ValidationCheck.CheckValidate(propValue, _attr);
                            if (!isOk)
                            {
                                object valForCheck = propValidate.GetValue(data, null);
                                if (valForCheck != null)
                                    lastValForPropValidate = valForCheck.ToString();

                                lastValForPropValidate += "#" + _attr.WarningMessage;
                                propValidate.SetValue(data, lastValForPropValidate, null);
                            }
                        }
                    }
                }

                if (propValue == null)
                    continue;

                _dic.Add(prop.Name, propValue);

            }
            if (lastValForPropValidate == "")
            {
                string sorgu = "";
                int returnValu = 0;

                if (updateMi)
                    sorgu = Query.Update(tableName, _dic);
                else
                    sorgu = Query.Insert(tableName, _dic, hasIdentity);

                returnValu = Convert.ToInt32(Query.Execute(sorgu, tableName, 0, _dic.Keys.ToArray(), _dic.Values.ToArray(), con, tran, updateMi, false, hasTwin));

                if (!updateMi && hasIdentity)
                    prop_id.SetValue(data, returnValu, null);

                return returnValu;

            }
            else
                return -100; // validation error

        }
        //---------------------------------------------------------

        public static object SaveDirect(string tableName, bool insert, Entities.Items.RootData data, object con, object tran)
        {
            Dictionary<string, object> _dic = new Dictionary<string, object>();
            for (int i = 0; i < data.properties.Count; i++)
            {
                _dic.Add(data.properties[i].name, data.properties[i].value);
            }
            //---------------------------------------------------------
            string sorgu = "";
            int returnValu = 0;
            if (insert)
                sorgu = Query.Insert(tableName, _dic, true);
            else
                sorgu = Query.Update(tableName, _dic);

            if (insert)
                insert = false;
            else
                insert = true;

            returnValu = Convert.ToInt32(Query.Execute(sorgu, tableName, 0, _dic.Keys.ToArray(), _dic.Values.ToArray(), con, tran, insert, false, false));
            return returnValu;
        }
        //---------------------------------------------------------

        public static object Delete(string tableName, int anaId, object con, object tran)
        {
            // delete için kullanılabilir. delete olan herşeyin twini olmak zorunda olduğu için twin true
            return Query.Delete(tableName, anaId, con, tran, true);
        }
        //---------------------------------------------------------

        public static object DeleteByClause(string tableName, string where, object con, object tran)
        {
            // delete için kullanılabilir. delete olan herşeyin twini olmak zorunda olduğu için twin true
            return Query.DeleteByClause(tableName, where, con, tran, true);

        }
        //---------------------------------------------------------

        public static SqlDataReader DataReader(string query, CommandType _commandType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return Select.DataReader(query, _commandType, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static DataTable DataTable(string query, CommandType _commandType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return Select.DataTable(query, _commandType, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static int RowCount(string tabloAdi, string filter, object[] parms, object[] values, object con, object tran)
        {
            return Select.RowCount(tabloAdi, filter, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static int RowCountByClause(string filter, object[] parms, object[] values, object con, object tran)
        {
            return Select.RowCountByClause(filter, parms, values, con, tran);
        }
        //---------------------------------------------------------

        public static List<T> SelectAnonyMous<T>(T className, string query, CommandType _cmdType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            return SelectAnonyMousSql<T>(className, query, _cmdType, parms, values, con, tran);
        }
        //---------------------------------------------------------

        protected static List<T> SelectAnonyMousSql<T>(T className, string query, CommandType _cmdType = CommandType.Text, object[] parms = null, object[] values = null, object con = null, object tran = null)
        {
            using (SqlDataReader dr = Select.DataReader(query, _cmdType, parms, values, con, tran))
            {
                var type = className.GetType();
                var props = type.GetProperties();

                List<T> _list = new List<T>();
                try
                {
                    List<string> _listOfColumns = new List<string>();
                    List<string> _listOfTypes = new List<string>();
                    if (dr.HasRows)
                    {
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            string colAdi = dr.GetName(i);

                            for (int a = 0; a < props.Length; a++)
                            {
                                if (props[a].Name == colAdi)
                                {
                                    _listOfColumns.Add(colAdi);
                                    _listOfTypes.Add(dr.GetDataTypeName(i));
                                    break;
                                }
                            }
                        }
                    }

                    while (dr.Read())
                    {
                        className = Activator.CreateInstance<T>();
                        className = (T)SelectAlt(ref className, dr, _listOfColumns, _listOfTypes);
                        _list.Add(className);
                    }
                    dr.Close();
                }
                catch
                {
                    dr.Close();
                    throw;
                }

                return _list;
            }
        }
        //---------------------------------------------------------

        private static object SelectAlt<T>(ref T className, object dr, List<string> listOfColumns, List<string> _listOfTypes)
        {
            Type type = className.GetType();
            var props = type.GetProperties();

            List<string> arrColNames = new List<string>();
            List<int> arrColInd = new List<int>();


            for (int i = 0; i < listOfColumns.Count; i++)
            {
                string colAdi = listOfColumns[i];
                string val = "";


                val = ((SqlDataReader)dr)[colAdi].ToString();

                string dataType = _listOfTypes[i];
                var prop = type.GetProperty(colAdi);

                Type propType = prop.PropertyType;
                if (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
                {
                    propType = prop.PropertyType.GetGenericArguments()[0];
                }


                string propTypeName = propType.Name;

                if (dataType == "bit" && (val == "True" || val == "False")) // boolean değerler için
                {
                    if (propTypeName == "Boolean")
                        prop.SetValue(className, Convert.ToBoolean(val == "True" ? 1 : 0), null);
                    else
                        prop.SetValue(className, Convert.ToByte(val == "True" ? 1 : 0), null);
                }
                else if ((propTypeName == "Int32" || propTypeName == "Int16") && val != "")
                    prop.SetValue(className, Convert.ToInt32(val), null);
                else if ((propTypeName == "Decimal") && val != "")
                    prop.SetValue(className, Convert.ToDecimal(val), null);
                else if ((propTypeName == "Single") && val != "")
                    prop.SetValue(className, Convert.ToSingle(val), null);
                else if ((propTypeName == "Float") && val != "")
                    prop.SetValue(className, Convert.ToSingle(val), null);
                else if ((propTypeName == "DateTime") && val != "")
                    prop.SetValue(className, Convert.ToDateTime(val), null);
                else if ((propTypeName == "Byte") && val != "")
                    prop.SetValue(className, Convert.ToByte(val), null);
                else if ((propTypeName == "Boolean") && (val == "True" || val == "False"))
                    prop.SetValue(className, Convert.ToBoolean(val), null);
                else if (propTypeName == "String")
                    prop.SetValue(className, val, null);
                else if (propTypeName == "Byte[]")
                {
                    if (((SqlDataReader)dr)[colAdi] != DBNull.Value)
                        prop.SetValue(className, ((SqlDataReader)dr)[colAdi], null);

                }
            }
            return className;

        }
        //---------------------------------------------------------

    }
}
