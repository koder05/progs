using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RF.LinqExt.Serialization
{
    public class ModelSerializationInfo
    {
        private Dictionary<Type, List<string>> _propToExclude = new Dictionary<Type, List<string>>();
        public Dictionary<Type, List<string>> PropToExclude
        {
            get
            {
                return _propToExclude;
            }
        }

        public void AddPropToExclude(Type modelBaseType, string propName)
        {
            if (!this._propToExclude.ContainsKey(modelBaseType))
            {
                this._propToExclude.Add(modelBaseType, new List<string>());
            }

            this._propToExclude[modelBaseType].Add(propName);
        }

        public bool PropIsExcluded(Type modelType, string propName)
        {
            foreach (var list in this._propToExclude.Where(kvp => modelType == kvp.Key || kvp.Key.IsAssignableFrom(modelType)).Select(kvp => kvp.Value)) 
            {
                if (list.Contains(propName))
                        return true;
            }

            return false;
        }
    }
}
