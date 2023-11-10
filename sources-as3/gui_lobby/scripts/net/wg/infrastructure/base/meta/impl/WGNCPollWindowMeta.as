package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class WGNCPollWindowMeta extends AbstractWindowView
   {
       
      
      public var onBtnClick:Function;
      
      public var onLinkClick:Function;
      
      public function WGNCPollWindowMeta()
      {
         super();
      }
      
      public function onBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBtnClick,"onBtnClick" + Errors.CANT_NULL);
         this.onBtnClick();
      }
      
      public function onLinkClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onLinkClick,"onLinkClick" + Errors.CANT_NULL);
         this.onLinkClick(param1);
      }
   }
}
