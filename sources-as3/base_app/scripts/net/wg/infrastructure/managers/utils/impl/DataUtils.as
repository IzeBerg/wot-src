package net.wg.infrastructure.managers.utils.impl
{
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IDataUtils;
   import org.idmedia.as3commons.util.HashMap;
   import org.idmedia.as3commons.util.Map;
   
   public class DataUtils implements IDataUtils
   {
      
      private static const QUALIFIED_VECTOR_PREFIX:String = "__AS3__.vec::Vector";
       
      
      public function DataUtils()
      {
         super();
      }
      
      public function cleanupDynamicObject(param1:Object) : Object
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         for each(_loc3_ in _loc2_)
         {
            delete param1[_loc3_];
         }
         _loc2_.splice(0,_loc2_.length);
         return null;
      }
      
      public function cleanupDynamicObjectsCouple(param1:Object, param2:Object) : Object
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = [];
         for(_loc4_ in param1)
         {
            _loc3_.push(_loc4_);
         }
         for each(_loc4_ in _loc3_)
         {
            delete param1[_loc4_];
            delete param2[_loc4_];
         }
         _loc3_.splice(0,_loc3_.length);
         return null;
      }
      
      public function cloneObject(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public function convertVOArrayToVector(param1:String, param2:Object, param3:Class) : Vector.<IDAAPIDataClass>
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = param2 as Array;
         App.utils.asserter.assertNotNull(_loc4_,param1 + Errors.CANT_NULL);
         _loc5_ = _loc4_.length;
         var _loc7_:Vector.<IDAAPIDataClass> = new Vector.<IDAAPIDataClass>(_loc5_,true);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_[_loc6_] = new param3(_loc4_[_loc6_]);
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function convertNumberArrayToVector(param1:String, param2:Object) : Vector.<Number>
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = param2 as Array;
         App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
         _loc4_ = _loc3_.length;
         var _loc6_:Vector.<Number> = new Vector.<Number>(_loc4_,true);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_[_loc5_] = _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function createMap(param1:Array) : Map
      {
         this.assertEvenArray(param1);
         var _loc2_:Map = new HashMap();
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ % 2 == 1 && _loc3_ > 0)
            {
               _loc2_.put(param1[_loc3_ - 1],param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function createMappedArray(param1:Array) : Array
      {
         var _loc4_:Object = null;
         this.assertEvenArray(param1);
         var _loc2_:Array = [];
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ % 2 == 1 && _loc3_ > 0)
            {
               _loc4_ = {};
               _loc4_[param1[_loc3_ - 1]] = param1[_loc3_];
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function vectorToArray(param1:Object) : Array
      {
         var _loc4_:Object = null;
         App.utils.asserter.assertNotNull(param1,"vector" + Errors.CANT_NULL);
         var _loc2_:Boolean = getQualifiedClassName(param1).indexOf(QUALIFIED_VECTOR_PREFIX) == 0;
         App.utils.asserter.assert(_loc2_,"Object is not Vector");
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
      
      private function assertEvenArray(param1:Array) : void
      {
         var _loc2_:String = "pureHash must be have even quantity of elements";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assertNotNull(param1,"pureHash" + Errors.CANT_NULL,NullPointerException);
         _loc3_.assert(param1.length % 2 == 0,_loc2_,ArgumentException);
         _loc3_.assert(param1.length > 0,"pureHash can`t be empty",ArgumentException);
      }
   }
}
