package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.BaseCategoryView;
   
   public class StorageCarouselEnvironmentMeta extends BaseCategoryView
   {
       
      
      public var resetFilter:Function;
      
      public var showItemInfo:Function;
      
      public var changeSearchNameVehicle:Function;
      
      public function StorageCarouselEnvironmentMeta()
      {
         super();
      }
      
      public function resetFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilter,"resetFilter" + Errors.CANT_NULL);
         this.resetFilter();
      }
      
      public function showItemInfoS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.showItemInfo,"showItemInfo" + Errors.CANT_NULL);
         this.showItemInfo(param1);
      }
      
      public function changeSearchNameVehicleS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.changeSearchNameVehicle,"changeSearchNameVehicle" + Errors.CANT_NULL);
         this.changeSearchNameVehicle(param1);
      }
   }
}
