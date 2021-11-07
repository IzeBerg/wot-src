package net.wg.mock.utils
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.exceptions.InvalidComponentCastException;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IClassFactory;
   
   public class MockClassFactory implements IClassFactory
   {
       
      
      public function MockClassFactory()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getClass(param1:String, param2:LoaderInfo = null) : Class
      {
         var classpath:String = param1;
         var loaderInfo:LoaderInfo = param2;
         var outcomeClass:Class = null;
         try
         {
            outcomeClass = getDefinitionByName(classpath) as Class;
         }
         catch(e:ReferenceError)
         {
            DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + classpath);
         }
         return outcomeClass;
      }
      
      public function getClassName(param1:*) : String
      {
         return "";
      }
      
      public function getComponent(param1:String, param2:Class, param3:Object = null, param4:LoaderInfo = null) : *
      {
         var _loc5_:Object = this.getObject(param1,param3);
         var _loc6_:String = "object with \"" + param1 + "\" linkage ";
         var _loc7_:String = _loc6_ + "is not a component from library!";
         var _loc8_:String = _loc6_ + "can`t cast to " + param2;
         var _loc9_:IAssertable = App.utils.asserter;
         _loc9_.assert(_loc5_ is DisplayObject,_loc7_,InvalidComponentCastException);
         _loc9_.assert(_loc5_ is param2,_loc8_,InvalidComponentCastException);
         return _loc5_;
      }
      
      public function getObject(param1:String, param2:Object = null, param3:LoaderInfo = null) : Object
      {
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Class = this.getClass(param1);
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
      
      public function get createComponentCallback() : Function
      {
         return null;
      }
      
      public function set createComponentCallback(param1:Function) : void
      {
      }
   }
}
