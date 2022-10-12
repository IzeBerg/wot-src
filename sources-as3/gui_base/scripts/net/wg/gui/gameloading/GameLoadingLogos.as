package net.wg.gui.gameloading
{
   import net.wg.gui.components.common.BaseLogoView;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class GameLoadingLogos extends BaseLogoView
   {
      
      private static const LOCALE_CN:String = "CN";
      
      private static const LOGO_X:int = -197;
      
      private static const LOGO_X_CN:int = -141;
       
      
      public var logo:UILoaderAlt = null;
      
      public function GameLoadingLogos()
      {
         super();
         this.logo.source = RES_ICONS.MAPS_ICONS_LIBRARY_LOGOS_PRODUCER_LOGO;
      }
      
      override public function dispose() : void
      {
         this.logo.dispose();
         this.logo = null;
         super.dispose();
      }
      
      override public function setLocale(param1:String) : void
      {
         super.setLocale(param1);
         this.updateLogoPos(param1);
      }
      
      private function updateLogoPos(param1:String) : void
      {
         this.logo.x = param1 == LOCALE_CN ? Number(LOGO_X_CN) : Number(LOGO_X);
      }
   }
}
