package net.wg.utils
{
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import org.idmedia.as3commons.util.Map;
   
   public interface IDataUtils
   {
       
      
      function cleanupDynamicObject(param1:Object) : Object;
      
      function cleanupDynamicObjectsCouple(param1:Object, param2:Object) : Object;
      
      function cloneObject(param1:Object) : *;
      
      function convertVOArrayToVector(param1:String, param2:Object, param3:Class) : Vector.<IDAAPIDataClass>;
      
      function convertNumberArrayToVector(param1:String, param2:Object) : Vector.<Number>;
      
      function createMap(param1:Array) : Map;
      
      function createMappedArray(param1:Array) : Array;
      
      function vectorToArray(param1:Object) : Array;
   }
}
