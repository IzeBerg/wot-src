package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class DialogsManagerMeta extends BaseDAAPIModule
   {
       
      
      public var showSimpleI18nDialog:Function;
      
      public function DialogsManagerMeta()
      {
         super();
      }
      
      public function showSimpleI18nDialogS(param1:String, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.showSimpleI18nDialog,"showSimpleI18nDialog" + Errors.CANT_NULL);
         this.showSimpleI18nDialog(param1,param2);
      }
   }
}
