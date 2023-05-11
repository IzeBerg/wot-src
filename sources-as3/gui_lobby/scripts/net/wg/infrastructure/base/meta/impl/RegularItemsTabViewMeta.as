package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.BaseCategoryView;
   
   public class RegularItemsTabViewMeta extends BaseCategoryView
   {
       
      
      public var navigateToStore:Function;
      
      public var sellItem:Function;
      
      public var upgradeItem:Function;
      
      public function RegularItemsTabViewMeta()
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
      
      public function upgradeItemS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.upgradeItem,"upgradeItem" + Errors.CANT_NULL);
         this.upgradeItem(param1);
      }
   }
}
