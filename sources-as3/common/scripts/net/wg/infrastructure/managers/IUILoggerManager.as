package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IUILoggerManagerMeta;
   
   public interface IUILoggerManager extends IUILoggerManagerMeta
   {
       
      
      function log(param1:String, param2:String, param3:String, param4:int, param5:Object) : void;
   }
}
