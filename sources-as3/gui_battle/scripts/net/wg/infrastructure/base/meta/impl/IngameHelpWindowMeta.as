package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class IngameHelpWindowMeta extends AbstractWindowView
   {
       
      
      public var clickSettingWindow:Function;
      
      public function IngameHelpWindowMeta()
      {
         super();
      }
      
      public function clickSettingWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.clickSettingWindow,"clickSettingWindow" + Errors.CANT_NULL);
         this.clickSettingWindow();
      }
   }
}
