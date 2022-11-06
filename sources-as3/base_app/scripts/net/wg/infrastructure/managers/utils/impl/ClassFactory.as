package net.wg.infrastructure.managers.utils.impl
{
   import avmplus.getQualifiedClassName;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.system.ApplicationDomain;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.exceptions.InvalidComponentCastException;
   import net.wg.utils.IClassFactory;
   
   public class ClassFactory implements IClassFactory
   {
       
      
      private var _createComponentCallback:Function;
      
      private var _disposed:Boolean = false;
      
      public function ClassFactory()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._createComponentCallback = null;
      }
      
      public function getClass(param1:String, param2:LoaderInfo = null) : Class
      {
         var domain:ApplicationDomain = null;
         var classpath:String = param1;
         var loaderInfo:LoaderInfo = param2;
         var outcomeClass:Class = null;
         try
         {
            domain = loaderInfo != null && loaderInfo.applicationDomain != null ? loaderInfo.applicationDomain : ApplicationDomain.currentDomain;
            outcomeClass = domain.getDefinition(classpath) as Class;
         }
         catch(e:ReferenceError)
         {
            DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + classpath);
         }
         return outcomeClass;
      }
      
      public function getClassName(param1:*) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public function getComponent(param1:String, param2:Class, param3:Object = null, param4:LoaderInfo = null) : *
      {
         var _loc5_:Object = this.getObject(param1,param3,param4);
         if(!(_loc5_ is DisplayObject))
         {
            App.utils.asserter.assert(false,this.getAssertLinkageMessage(param1) + "is not a component from library!",InvalidComponentCastException);
         }
         if(!(_loc5_ is param2))
         {
            App.utils.asserter.assert(false,this.getAssertLinkageMessage(param1) + "can`t cast to " + param2,InvalidComponentCastException);
         }
         if(this._createComponentCallback != null)
         {
            this._createComponentCallback(_loc5_,param1);
         }
         return _loc5_;
      }
      
      public function getObject(param1:String, param2:Object = null, param3:LoaderInfo = null) : Object
      {
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Class = this.getClass(param1,param3);
         if(_loc5_ != null)
         {
            _loc4_ = new _loc5_();
            if(param2 != null)
            {
               for(_loc6_ in param2)
               {
                  if(!_loc4_.hasOwnProperty(_loc6_))
                  {
                     _loc7_ = "object with linkage \'" + param1 + "\' doesn`t contain property " + "with name \'" + _loc6_ + "\'. Initialization error.";
                  }
                  continue;
                  _loc4_[_loc6_] = param2[_loc6_];
                  throw new ArgumentException(_loc7_);
               }
            }
         }
         return _loc4_;
      }
      
      private function getAssertLinkageMessage(param1:String) : String
      {
         return "object with \"" + param1 + "\" linkage ";
      }
      
      public function get createComponentCallback() : Function
      {
         return this._createComponentCallback;
      }
      
      public function set createComponentCallback(param1:Function) : void
      {
         this._createComponentCallback = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
