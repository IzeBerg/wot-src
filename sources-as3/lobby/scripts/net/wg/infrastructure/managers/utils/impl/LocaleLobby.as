package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   
   public class LocaleLobby extends LocaleBase
   {
      
      private static const ICON_DEF_PATH:String = "img://gui/maps/icons/library/";
       
      
      public function LocaleLobby()
      {
         super();
      }
      
      override public function htmlTextWithIcon(param1:String, param2:String) : String
      {
         var _loc3_:uint = 0;
         if(param2 == CURRENCIES_CONSTANTS.CREDITS)
         {
            _loc3_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
            param2 = "Credits";
         }
         else if(param2 == CURRENCIES_CONSTANTS.GOLD)
         {
            _loc3_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
            param2 = "Gold";
         }
         return "<font color=\"#" + _loc3_.toString(16) + "\" >" + param1 + "</font>  <img src=\"" + ICON_DEF_PATH + param2 + "Icon-2.png\" width=\"16\" height=\"16\" vspace=\"-4\" hspace=\"0\"/>";
      }
   }
}
