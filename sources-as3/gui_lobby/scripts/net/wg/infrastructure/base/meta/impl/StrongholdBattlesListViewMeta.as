package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.AbstractRallyView;
   
   public class StrongholdBattlesListViewMeta extends AbstractRallyView
   {
       
      
      public var onFocusChange:Function;
      
      public var updateBrowser:Function;
      
      public function StrongholdBattlesListViewMeta()
      {
         super();
      }
      
      public function onFocusChangeS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFocusChange,"onFocusChange" + Errors.CANT_NULL);
         this.onFocusChange(param1);
      }
      
      public function updateBrowserS() : void
      {
         App.utils.asserter.assertNotNull(this.updateBrowser,"updateBrowser" + Errors.CANT_NULL);
         this.updateBrowser();
      }
   }
}
