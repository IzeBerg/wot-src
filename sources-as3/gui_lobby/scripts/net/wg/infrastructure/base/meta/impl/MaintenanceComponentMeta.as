package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class MaintenanceComponentMeta extends BaseDAAPIComponent
   {
       
      
      public var refresh:Function;
      
      public function MaintenanceComponentMeta()
      {
         super();
      }
      
      public function refreshS() : void
      {
         App.utils.asserter.assertNotNull(this.refresh,"refresh" + Errors.CANT_NULL);
         this.refresh();
      }
   }
}
