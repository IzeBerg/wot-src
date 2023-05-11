package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.AbstractRallyWindow;
   
   public class BaseRallyMainWindowMeta extends AbstractRallyWindow
   {
       
      
      public var onBackClick:Function;
      
      public var getClientID:Function;
      
      public function BaseRallyMainWindowMeta()
      {
         super();
      }
      
      public function onBackClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
      
      public function getClientIDS() : Number
      {
         App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
         return this.getClientID();
      }
   }
}
