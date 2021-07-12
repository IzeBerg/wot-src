package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.views.BaseContactView;
   
   public class SearchContactViewMeta extends BaseContactView
   {
       
      
      public var search:Function;
      
      public function SearchContactViewMeta()
      {
         super();
      }
      
      public function searchS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.search,"search" + Errors.CANT_NULL);
         this.search(param1);
      }
   }
}
