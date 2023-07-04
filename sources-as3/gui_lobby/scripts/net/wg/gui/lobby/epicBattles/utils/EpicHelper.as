package net.wg.gui.lobby.epicBattles.utils
{
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.lobby.epicBattles.components.common.AlignedIconTextButton;
   
   public class EpicHelper
   {
      
      public static const TOP_BAR_HEIGHT:int = 54;
      
      public static const MAIN_MENU_BUTTON_BAR_HEIGHT:int = 34;
      
      public static const MESSENGER_BAR_HEIGHT:int = 36;
      
      public static const VISUAL_EPIC_TITLE_TOP_PADDING:int = 22;
      
      public static const VISUAL_EPIC_TITLE_FONT_HEIGHT:int = 54;
      
      public static const EPIC_TITLE_SUBTITLE_DISTANCE:int = 93;
      
      public static const EPIC_TITLE_SUBTITLE_BUTTON_Y_PADDING:int = 100;
      
      public static const VISUAL_HERO_TITLE_TOP_PADDING:int = 17;
      
      public static const VISUAL_HERO_TITLE_FONT_HEIGHT:int = 39;
      
      public static const HERO_TITLE_SUBTITLE_DISTANCE:int = 76;
      
      public static const HERO_TITLE_SUBTITLE_BUTTON_Y_PADDING:int = 83;
      
      public static const BUTTON_TOP_MARGIN:int = 8;
      
      public static const CLOSE_BUTTON_DISTANCE_BETWEEN_ICONCONTAINER_AND_ICON:int = 8;
      
      public static const VISUAL_TOP_PADDING_ABOUT_BUTTON:int = 9;
      
      public static const VISUAL_TOP_PADDING_BACK_BUTTON:int = 11;
      
      public static const BUTTON_TOP_FONT_PADDING:int = 2;
      
      public static const BUTTON_TEXT_FIELD_VERTICAL_OFFSET:int = 7;
      
      public static const BREAKING_POINT_RESOLUTION:int = 900;
       
      
      public function EpicHelper()
      {
         super();
      }
      
      public static function calculateStaticMargin(param1:int) : int
      {
         return (param1 + TOP_BAR_HEIGHT + MESSENGER_BAR_HEIGHT) / 18 >> 0;
      }
      
      public static function positionCloseButton(param1:CloseButtonText, param2:int, param3:int) : void
      {
         var _loc4_:Number = calculateStaticMargin(param2);
         var _loc5_:int = param1.width - param1.iconContainer.x - param1.iconContainer.width + CLOSE_BUTTON_DISTANCE_BETWEEN_ICONCONTAINER_AND_ICON;
         param1.x = param3 - param1.width + _loc5_ - _loc4_;
         param1.y = _loc4_ + MAIN_MENU_BUTTON_BAR_HEIGHT - BUTTON_TEXT_FIELD_VERTICAL_OFFSET - BUTTON_TOP_FONT_PADDING;
      }
      
      public static function positionAboutButton(param1:AlignedIconTextButton, param2:int, param3:int) : void
      {
         var _loc4_:Number = calculateStaticMargin(param2);
         param1.x = _loc4_ - VISUAL_TOP_PADDING_ABOUT_BUTTON;
         param1.y = _loc4_ + MAIN_MENU_BUTTON_BAR_HEIGHT - BUTTON_TEXT_FIELD_VERTICAL_OFFSET - BUTTON_TOP_FONT_PADDING;
      }
      
      public static function positionBackButton(param1:BackButton, param2:int) : void
      {
         var _loc3_:Number = calculateStaticMargin(param2);
         param1.x = _loc3_ - VISUAL_TOP_PADDING_BACK_BUTTON;
         param1.y = _loc3_ + MAIN_MENU_BUTTON_BAR_HEIGHT - BUTTON_TEXT_FIELD_VERTICAL_OFFSET - BUTTON_TOP_FONT_PADDING;
      }
      
      public static function isMinResolution(param1:int) : Boolean
      {
         return param1 < BREAKING_POINT_RESOLUTION;
      }
   }
}
