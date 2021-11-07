package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.storage.ItemsWithTypeFilterTabView;
   
   public class StorageCategoryCustomizationViewMeta extends ItemsWithTypeFilterTabView
   {
       
      
      public var navigateToCustomization:Function;
      
      public var sellCustomizationItem:Function;
      
      public var previewItem:Function;
      
      public function StorageCategoryCustomizationViewMeta()
      {
         super();
      }
      
      public function navigateToCustomizationS() : void
      {
         App.utils.asserter.assertNotNull(this.navigateToCustomization,"navigateToCustomization" + Errors.CANT_NULL);
         this.navigateToCustomization();
      }
      
      public function sellCustomizationItemS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.sellCustomizationItem,"sellCustomizationItem" + Errors.CANT_NULL);
         this.sellCustomizationItem(param1,param2);
      }
      
      public function previewItemS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.previewItem,"previewItem" + Errors.CANT_NULL);
         this.previewItem(param1,param2);
      }
   }
}
