package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class UILoggerManagerMeta extends BaseDAAPIModule
   {
       
      
      public var onLog:Function;
      
      public function UILoggerManagerMeta()
      {
         super();
      }
      
      public function onLogS(param1:String, param2:String, param3:String, param4:int, param5:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onLog,"onLog" + Errors.CANT_NULL);
         this.onLog(param1,param2,param3,param4,param5);
      }
   }
}
