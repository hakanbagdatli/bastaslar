using System;
using Entities;
using System.Linq;
using System.Data.SqlClient;
using System.Linq.Expressions;
using System.Collections.Generic;

namespace WebSite
{
    public static class ExtensionMethods
    {
        public static object Save(this IEntity EntityItems, SqlConnection con = null, SqlTransaction tran = null)
        {
            return Bll.Base.Save(EntityItems, con, tran);
        }
        //---------------------------------------------------------

        public static object Delete(this IEntity EntityItems, int id, SqlConnection con = null, SqlTransaction tran = null)
        {
            return Bll.Base.Delete(id, EntityItems._TableName, con, tran);
        }
        //---------------------------------------------------------

        public static object DeleteByClause(this IEntity EntityItems, string where, SqlConnection con = null, SqlTransaction tran = null)
        {
            return Bll.Base.DeleteByClause(EntityItems._TableName, where, con, tran);
        }
        //---------------------------------------------------------

        public static void SaveMultiple(this List<IEntity> listNames, string tableName, SqlConnection con = null, SqlTransaction tran = null)
        {
            Bll.Base.SaveMultiple(listNames, tableName, con, tran);
        }
        //---------------------------------------------------------

        /// <typeparam name="T"></typeparam>
        /// <param name="item"></param>
        /// <param name="qualifiedName">string qualifiedName = typeof(write here class name).AssemblyQualifiedName;</param>
        /// <returns></returns>

        public static T mFirstOrDefault<T>(this T item, string qualifiedName)
        {
            if (item == null)
            {
                item = (T)Activator.CreateInstance(Type.GetType(qualifiedName));
            }
            return item;
        }
        //---------------------------------------------------------

        public static IEntity mFirstOrDefault(this IEntity item)
        {
            if (item == null)
            {
                string qualifiedName = typeof(IEntity).AssemblyQualifiedName;
                item = (IEntity)Activator.CreateInstance(Type.GetType(qualifiedName));
            }
            return item;
        }
        //---------------------------------------------------------

        public static List<T> Filter<T>(this List<T> source, string columnName, string compValue)
        {
            ParameterExpression parameter = Expression.Parameter(typeof(T), "x");
            Expression property = Expression.Property(parameter, columnName);
            Expression constant = Expression.Constant(compValue);
            Expression equality = Expression.Equal(property, constant);
            Expression<Func<T, bool>> predicate =
                Expression.Lambda<Func<T, bool>>(equality, parameter);

            Func<T, bool> compiled = predicate.Compile();
            return source.Where(compiled).ToList();
        }
        //---------------------------------------------------------
    }
    //---------------------------------------------------------

    public class JSonEqualityComparer<T> : IEqualityComparer<T>
    {
        public bool Equals(T x, T y)
        {
            return String.Equals
                (
                    Newtonsoft.Json.JsonConvert.SerializeObject(x),
                    Newtonsoft.Json.JsonConvert.SerializeObject(y)
                );
        }

        public int GetHashCode(T obj)
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(obj).GetHashCode();
        }
    }
    //---------------------------------------------------------

    public static partial class LinqExtensions
    {
        public static IEnumerable<T> ExceptUsingJSonCompare<T>
            (this IEnumerable<T> first, IEnumerable<T> second)
        {
            return first.Except(second, new JSonEqualityComparer<T>());
        }
    }
    //---------------------------------------------------------
}