package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.base.meta.IUILoggerManagerMeta;
   import net.wg.infrastructure.base.meta.impl.UILoggerManagerMeta;
   import net.wg.infrastructure.managers.IUILoggerManager;
   
   public class UILoggerManager extends UILoggerManagerMeta implements IUILoggerManager, IUILoggerManagerMeta
   {
       
      
      public function UILoggerManager()
      {
         super();
      }
      
      public function log(param1:String, param2:String, param3:String, param4:int, param5:Object) : void
      {
         onLogS(param1,param2,param3,param4,param5);
      }
   }
}
