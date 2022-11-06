package net.wg.data.daapi.base
{
   import avmplus.getQualifiedClassName;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.DAAPIBindException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class DAAPIDataClass extends EventDispatcher implements IDAAPIDataClass
   {
      
      private static const HASH_CANT_NULL_ASSERT_MESSAGE:String = "Hash" + Errors.CANT_NULL;
      
      private static const FIELD_NAME_CANT_FIND_ASSERT_MESSAGE:String = "can\'t find property for DAAPI data binding: ";
      
      private static const OBJECT_TYPE_NAME:String = "object";
       
      
      private var _hash:Object = null;
      
      private var _disposed:Boolean = false;
      
      public function DAAPIDataClass(param1:Object = null)
      {
         super();
         if(param1)
         {
            this.fromHash(param1);
         }
      }
      
      public static function compare(param1:Object, param2:Object) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc3_:String = typeof param1;
         if(_loc3_ == OBJECT_TYPE_NAME)
         {
            if(param1 is Array)
            {
               _loc4_ = param1 as Array;
               if(!(param2 is Array))
               {
                  return false;
               }
               _loc5_ = _loc4_.length;
               if(_loc5_ != param2.length)
               {
                  return false;
               }
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  if(!compare(_loc4_[_loc6_],param2[_loc6_]))
                  {
                     return false;
                  }
                  _loc6_++;
               }
            }
            else
            {
               for(_loc7_ in param1)
               {
                  if(!param2.hasOwnProperty(_loc7_.toString()))
                  {
                     return false;
                  }
                  if(!compare(param1[_loc7_],param2[_loc7_]))
                  {
                     return false;
                  }
               }
            }
         }
         else if(param1 !== param2)
         {
            return false;
         }
         return true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
         this._hash = null;
      }
      
      public function clone() : *
      {
         return App.utils.data.cloneObject(this);
      }
      
      public function fromHash(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this._hash = param1;
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = _loc2_;
            if(this.onDataWrite(_loc4_,_loc3_))
            {
               if(!hasOwnProperty(_loc4_))
               {
                  this.assert(false,FIELD_NAME_CANT_FIND_ASSERT_MESSAGE + _loc4_,DAAPIBindException);
               }
               if(_loc3_ != undefined)
               {
                  _loc5_ = typeof this[_loc2_];
                  _loc6_ = typeof _loc3_;
                  if(_loc5_ != OBJECT_TYPE_NAME)
                  {
                     if(_loc5_ != _loc6_)
                     {
                        this.assert(false,"invalid type on property \'" + getQualifiedClassName(this) + "." + _loc2_ + "\': can`t cast value \'" + _loc3_ + "\' with type \'" + _loc6_ + "\'to \'" + _loc5_ + "\'",DAAPIBindException);
                     }
                  }
                  else if(_loc6_ != OBJECT_TYPE_NAME)
                  {
                     this.assert(false,"incorrect cast value \'" + _loc3_ + "\' to field with type Object." + " Please, change type of \'" + getQualifiedClassName(this) + "." + _loc2_ + "\' field  to \'" + _loc6_ + "\' type or initialize it as Values.EMPTY_STR",DAAPIBindException);
                  }
               }
               this[_loc2_] = _loc3_;
            }
         }
      }
      
      public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         return compare(this._hash,param1.getHash());
      }
      
      public function toHash() : Object
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in this._hash)
         {
            _loc3_ = this._hash[_loc2_];
            _loc4_ = _loc2_.substr(0);
            if(this.onDataRead(_loc2_,_loc1_))
            {
               _loc1_[_loc4_] = _loc3_;
            }
         }
         return _loc1_;
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         return true;
      }
      
      protected function onDataRead(param1:String, param2:Object) : Boolean
      {
         return true;
      }
      
      function getHash() : Object
      {
         return this._hash;
      }
      
      private function assert(param1:Boolean, param2:String, param3:Class = null) : void
      {
         App.utils.asserter.assert(param1,param2,param3);
      }
      
      private function assertNotNull(param1:Object, param2:String, param3:Class = null) : void
      {
         App.utils.asserter.assert(param1,param2,param3);
      }
      
      protected function isHomogenArraysEquals(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1 && !param2)
         {
            return true;
         }
         if(param1 && !param2 || !param1 && param2)
         {
            return false;
         }
         if(param1 && param2 && param1.length == param2.length)
         {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1[_loc4_] != param2[_loc4_])
               {
                  return false;
               }
               _loc4_++;
            }
            return true;
         }
         return false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
