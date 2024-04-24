package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   
   public class RestoreVehiclesTabViewMeta extends StorageCarouselEnvironmentMeta
   {
       
      
      public var restoreItem:Function;
      
      public function RestoreVehiclesTabViewMeta()
      {
         super();
      }
      
      public function restoreItemS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.restoreItem,"restoreItem" + Errors.CANT_NULL);
         this.restoreItem(param1);
      }
   }
}
