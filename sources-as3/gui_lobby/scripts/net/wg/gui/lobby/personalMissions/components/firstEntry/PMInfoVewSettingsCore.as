package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PMInfoVewSettingsCore implements IDisposable
   {
      
      public static const HORIZONTAL_BREAK_POINT:int = 1467;
      
      public static const VERTICAL_BREAK_POINT:int = 860;
      
      public static const SMALL_SIZE_ID:String = "smallSize";
      
      public static const BIG_SIZE_ID:String = "bigSize";
       
      
      private var _settingsSmallSize:PMInfoVewSettings = null;
      
      private var _settingsBigSize:PMInfoVewSettings = null;
      
      private var _settingsAdditionalSmallSize:PMInfoAdditionalViewSettings = null;
      
      private var _settingsAdditionalBigSize:PMInfoAdditionalViewSettings = null;
      
      public function PMInfoVewSettingsCore()
      {
         super();
         this._settingsBigSize = new PMInfoVewSettings();
         this._settingsBigSize.titleTopGap = 76;
         this._settingsBigSize.titleFontSize = 56;
         this._settingsBigSize.playVideoBtnTopGap = 24;
         this._settingsBigSize.acceptBtnBottomGap = 80;
         this._settingsBigSize.cardAnimDelta = -30;
         this._settingsBigSize.cardGap = 20;
         this._settingsBigSize.cardWidth = 342;
         this._settingsBigSize.cardHeight = 482;
         this._settingsBigSize.cardIconYPos = 57;
         this._settingsBigSize.cardIconScale = 1;
         this._settingsBigSize.cardTitleTopGap = 23;
         this._settingsBigSize.cardTitleFontSize = 24;
         this._settingsBigSize.carDescriptionTopGap = 18;
         this._settingsBigSize.cardDescriptionFontSize = 16;
         this._settingsBigSize.cardMoreYPos = 425;
         this._settingsBigSize.cardInnerGap = 20;
         this._settingsSmallSize = new PMInfoVewSettings();
         this._settingsSmallSize.titleTopGap = 60;
         this._settingsSmallSize.titleFontSize = 36;
         this._settingsSmallSize.playVideoBtnTopGap = 8;
         this._settingsSmallSize.acceptBtnBottomGap = 60;
         this._settingsSmallSize.cardAnimDelta = -20;
         this._settingsSmallSize.cardGap = 20;
         this._settingsSmallSize.cardWidth = 232;
         this._settingsSmallSize.cardHeight = 332;
         this._settingsSmallSize.cardIconYPos = 27;
         this._settingsSmallSize.cardIconScale = 0.58;
         this._settingsSmallSize.cardTitleTopGap = 19;
         this._settingsSmallSize.cardTitleFontSize = 18;
         this._settingsSmallSize.carDescriptionTopGap = 9;
         this._settingsSmallSize.cardDescriptionFontSize = 14;
         this._settingsSmallSize.cardMoreYPos = 275;
         this._settingsSmallSize.cardInnerGap = 12;
         this._settingsAdditionalBigSize = new PMInfoAdditionalViewSettings();
         this._settingsAdditionalBigSize.titleTopGap = 76;
         this._settingsAdditionalBigSize.titleFontSize = 56;
         this._settingsAdditionalBigSize.titleIconTopGap = 81;
         this._settingsAdditionalBigSize.descrTopGap = 28;
         this._settingsAdditionalBigSize.descrFontSize = 24;
         this._settingsAdditionalBigSize.contentTopGap = 92;
         this._settingsAdditionalBigSize.cardFontSize = 16;
         this._settingsAdditionalBigSize.cardBlockWidth = 468;
         this._settingsAdditionalBigSize.cardBlockHeight = 256;
         this._settingsAdditionalBigSize.betweenCardGap = 80;
         this._settingsAdditionalBigSize.notificationWidth = 960;
         this._settingsAdditionalBigSize.notificationTopGap = 51;
         this._settingsAdditionalBigSize.notificationInnerTopGap = 37;
         this._settingsAdditionalBigSize.notificationInnerBottomGap = 40;
         this._settingsAdditionalBigSize.pageBottomGap = 80;
         this._settingsAdditionalSmallSize = new PMInfoAdditionalViewSettings();
         this._settingsAdditionalSmallSize.titleTopGap = 60;
         this._settingsAdditionalSmallSize.titleFontSize = 36;
         this._settingsAdditionalSmallSize.titleIconTopGap = 52;
         this._settingsAdditionalSmallSize.descrTopGap = 33;
         this._settingsAdditionalSmallSize.descrFontSize = 16;
         this._settingsAdditionalSmallSize.contentTopGap = 53;
         this._settingsAdditionalSmallSize.cardFontSize = 14;
         this._settingsAdditionalSmallSize.cardBlockWidth = 428;
         this._settingsAdditionalSmallSize.cardBlockHeight = 234;
         this._settingsAdditionalSmallSize.betweenCardGap = 40;
         this._settingsAdditionalSmallSize.notificationWidth = 880;
         this._settingsAdditionalSmallSize.notificationTopGap = 30;
         this._settingsAdditionalSmallSize.notificationInnerTopGap = 19;
         this._settingsAdditionalSmallSize.notificationInnerBottomGap = 18;
         this._settingsAdditionalSmallSize.pageBottomGap = 40;
      }
      
      public static function getSizeId(param1:int, param2:int) : String
      {
         return param1 > HORIZONTAL_BREAK_POINT && param2 > VERTICAL_BREAK_POINT ? BIG_SIZE_ID : SMALL_SIZE_ID;
      }
      
      public final function dispose() : void
      {
         this._settingsSmallSize = null;
         this._settingsBigSize = null;
         this._settingsAdditionalSmallSize = null;
         this._settingsAdditionalBigSize = null;
      }
      
      public function getAdditionalSettingsBySizeId(param1:String) : PMInfoAdditionalViewSettings
      {
         switch(param1)
         {
            case SMALL_SIZE_ID:
               return this._settingsAdditionalSmallSize;
            case BIG_SIZE_ID:
               return this._settingsAdditionalBigSize;
            default:
               return this._settingsAdditionalSmallSize;
         }
      }
      
      public function getSettingsBySizeId(param1:String) : PMInfoVewSettings
      {
         switch(param1)
         {
            case SMALL_SIZE_ID:
               return this._settingsSmallSize;
            case BIG_SIZE_ID:
               return this._settingsBigSize;
            default:
               return this._settingsSmallSize;
         }
      }
   }
}
