package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.data.constants.IconsTypes;
   import net.wg.utils.IIcons;
   
   public class Icons implements IIcons
   {
       
      
      public function Icons()
      {
         super();
      }
      
      public function getIcon16StrPath(param1:String) : String
      {
         if(IconsTypes.ALLOW_ICONS.indexOf(param1) < 0)
         {
            DebugUtils.LOG_WARNING("Invalid icon ID: " + param1);
            return "";
         }
         var _loc2_:String = "";
         var _loc3_:uint = 16;
         var _loc4_:uint = 16;
         switch(param1)
         {
            case IconsTypes.GOLD:
               _loc2_ = "GoldIcon-2.png";
               break;
            case IconsTypes.CREDITS:
               _loc2_ = "CreditsIcon-2.png";
               break;
            case IconsTypes.ELITE_XP:
               _loc2_ = "EliteXpIcon-2.png";
               break;
            case IconsTypes.FREE_XP:
               _loc2_ = "FreeXpIcon-2.png";
               _loc3_ = _loc4_ = 18;
               break;
            case IconsTypes.XP_PRICE:
               _loc2_ = "UnlockPrice.png";
               break;
            case IconsTypes.CRYSTAL:
               _loc2_ = "icon_proxy_16x16.png";
         }
         if(_loc2_ == "")
         {
            DebugUtils.LOG_WARNING("Can\'t find icon constant name for ID: " + param1);
         }
         else
         {
            _loc2_ = "<IMG SRC=\"img://gui/maps/icons/library/" + _loc2_ + "\" width=\"" + _loc3_ + "\" height=\"" + _loc4_ + "\" vspace=\"-4\"/>";
         }
         return _loc2_;
      }
   }
}
