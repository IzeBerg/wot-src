package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   
   public class AllVehiclesTabViewMeta extends StorageCarouselEnvironmentMeta
   {
       
      
      public var navigateToStore:Function;
      
      public var sellItem:Function;
      
      public function AllVehiclesTabViewMeta()
      {
         super();
      }
      
      public function navigateToStoreS() : void
      {
         App.utils.asserter.assertNotNull(this.navigateToStore,"navigateToStore" + Errors.CANT_NULL);
         this.navigateToStore();
      }
      
      public function sellItemS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.sellItem,"sellItem" + Errors.CANT_NULL);
         this.sellItem(param1);
      }
   }
}
