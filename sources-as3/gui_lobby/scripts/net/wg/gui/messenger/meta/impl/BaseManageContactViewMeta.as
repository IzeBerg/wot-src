package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.views.BaseContactView;
   
   public class BaseManageContactViewMeta extends BaseContactView
   {
       
      
      public var checkText:Function;
      
      public function BaseManageContactViewMeta()
      {
         super();
      }
      
      public function checkTextS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.checkText,"checkText" + Errors.CANT_NULL);
         this.checkText(param1);
      }
   }
}
