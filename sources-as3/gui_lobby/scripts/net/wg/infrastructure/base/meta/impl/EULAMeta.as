package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class EULAMeta extends AbstractWindowView
   {
       
      
      public var requestEULAText:Function;
      
      public var onLinkClick:Function;
      
      public var onApply:Function;
      
      public function EULAMeta()
      {
         super();
      }
      
      public function requestEULATextS() : void
      {
         App.utils.asserter.assertNotNull(this.requestEULAText,"requestEULAText" + Errors.CANT_NULL);
         this.requestEULAText();
      }
      
      public function onLinkClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onLinkClick,"onLinkClick" + Errors.CANT_NULL);
         this.onLinkClick(param1);
      }
      
      public function onApplyS() : void
      {
         App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
         this.onApply();
      }
   }
}
