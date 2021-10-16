package net.wg.utils
{
   import flash.display.LoaderInfo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IClassFactory extends IDisposable
   {
       
      
      function getClass(param1:String, param2:LoaderInfo = null) : Class;
      
      function getObject(param1:String, param2:Object = null, param3:LoaderInfo = null) : Object;
      
      function getComponent(param1:String, param2:Class, param3:Object = null, param4:LoaderInfo = null) : *;
      
      function getClassName(param1:*) : String;
      
      function get createComponentCallback() : Function;
      
      function set createComponentCallback(param1:Function) : void;
   }
}
