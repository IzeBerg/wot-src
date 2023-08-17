package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class FAQWindowMeta extends AbstractWindowView
   {
       
      
      public var onLinkClicked:Function;
      
      public function FAQWindowMeta()
      {
         super();
      }
      
      public function onLinkClickedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onLinkClicked,"onLinkClicked" + Errors.CANT_NULL);
         this.onLinkClicked(param1);
      }
   }
}
