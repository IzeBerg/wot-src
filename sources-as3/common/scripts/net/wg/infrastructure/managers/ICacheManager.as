package net.wg.infrastructure.managers
{
   import flash.display.Loader;
   import net.wg.infrastructure.base.meta.ICacheManagerMeta;
   
   public interface ICacheManager extends ICacheManagerMeta
   {
       
      
      function get enabled() : Boolean;
      
      function isCached(param1:String) : Boolean;
      
      function add(param1:String, param2:Loader, param3:Class = null) : Boolean;
      
      function getClassDef(param1:String, param2:Boolean = false) : Class;
   }
}
