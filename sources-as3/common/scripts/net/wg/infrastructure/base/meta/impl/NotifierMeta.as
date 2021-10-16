package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class NotifierMeta extends BaseDAAPIModule
   {
       
      
      public var showDialog:Function;
      
      public var showI18nDialog:Function;
      
      public function NotifierMeta()
      {
         super();
      }
      
      public function showDialogS(param1:String, param2:String, param3:String, param4:Array, param5:Object) : void
      {
         App.utils.asserter.assertNotNull(this.showDialog,"showDialog" + Errors.CANT_NULL);
         this.showDialog(param1,param2,param3,param4,param5);
      }
      
      public function showI18nDialogS(param1:String, param2:String, param3:Object) : void
      {
         App.utils.asserter.assertNotNull(this.showI18nDialog,"showI18nDialog" + Errors.CANT_NULL);
         this.showI18nDialog(param1,param2,param3);
      }
   }
}
