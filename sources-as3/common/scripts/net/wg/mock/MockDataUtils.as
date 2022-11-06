package net.wg.mock
{
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IDataUtils;
   import org.idmedia.as3commons.util.Map;
   
   public class MockDataUtils implements IDataUtils
   {
       
      
      public function MockDataUtils()
      {
         super();
      }
      
      [Deprecated(message="Due to #WOTD-57029, use inline for each loop.")]
      public function cleanVectorOfDisposables(param1:Vector.<IDisposable>) : void
      {
      }
      
      public function cleanupDynamicObject(param1:Object) : Object
      {
         return null;
      }
      
      public function cleanupDynamicObjectsCouple(param1:Object, param2:Object) : Object
      {
         return null;
      }
      
      public function cloneObject(param1:Object) : *
      {
         return null;
      }
      
      public function convertVOArrayToVector(param1:String, param2:Object, param3:Class) : Vector.<IDAAPIDataClass>
      {
         return null;
      }
      
      public function convertNumberArrayToVector(param1:String, param2:Object) : Vector.<Number>
      {
         return null;
      }
      
      public function createMap(param1:Array) : Map
      {
         return null;
      }
      
      public function createMappedArray(param1:Array) : Array
      {
         return null;
      }
      
      public function vectorToArray(param1:Object) : Array
      {
         return null;
      }
   }
}
