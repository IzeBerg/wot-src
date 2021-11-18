package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class BattleRoyaleMetaLevel extends BaseMetaLevel
   {
      
      private static const DEFAULT_OFFSET:int = 0;
      
      private static const IMAGE_SIZES:Object = {};
      
      private static const LEVEL_FONT_SIZES:Object = {};
      
      private static const LEVEL_OFFSETS_Y:Object = {};
      
      private static const SEASON_FONT_SIZES:Object = {};
      
      private static const SEASON_OFFSETS_Y:Object = {};
      
      private static const BACKGROUND_OFFSETS_Y:Object = {};
      
      {
         IMAGE_SIZES[EXTRA_SMALL] = "130x130";
         IMAGE_SIZES[SMALL] = "150x150";
         IMAGE_SIZES[MEDIUM] = "190x190";
         IMAGE_SIZES[LARGE] = "270x270";
         IMAGE_SIZES[EXTRA_LARGE] = "320x320";
         LEVEL_FONT_SIZES[EXTRA_SMALL] = 33;
         LEVEL_FONT_SIZES[SMALL] = 40;
         LEVEL_FONT_SIZES[MEDIUM] = 45;
         LEVEL_FONT_SIZES[LARGE] = 70;
         LEVEL_FONT_SIZES[EXTRA_LARGE] = 75;
         LEVEL_OFFSETS_Y[EXTRA_SMALL] = -19;
         LEVEL_OFFSETS_Y[SMALL] = -24;
         LEVEL_OFFSETS_Y[MEDIUM] = -19;
         LEVEL_OFFSETS_Y[LARGE] = -30;
         LEVEL_OFFSETS_Y[EXTRA_LARGE] = -33;
         SEASON_FONT_SIZES[EXTRA_SMALL] = 12;
         SEASON_FONT_SIZES[SMALL] = 14;
         SEASON_FONT_SIZES[MEDIUM] = 18;
         SEASON_FONT_SIZES[LARGE] = 28;
         SEASON_FONT_SIZES[EXTRA_LARGE] = 32;
         SEASON_OFFSETS_Y[EXTRA_SMALL] = 27;
         SEASON_OFFSETS_Y[SMALL] = 35;
         SEASON_OFFSETS_Y[MEDIUM] = 48;
         SEASON_OFFSETS_Y[LARGE] = 68;
         SEASON_OFFSETS_Y[EXTRA_LARGE] = 74;
         BACKGROUND_OFFSETS_Y[EXTRA_SMALL] = -3;
         BACKGROUND_OFFSETS_Y[SMALL] = -4;
         BACKGROUND_OFFSETS_Y[MEDIUM] = 0;
         BACKGROUND_OFFSETS_Y[LARGE] = 0;
         BACKGROUND_OFFSETS_Y[EXTRA_LARGE] = 0;
      }
      
      public function BattleRoyaleMetaLevel()
      {
         super();
      }
      
      override public function setData(param1:MetaLevelVO) : void
      {
         super.setData(param1);
         BattleRoyaleMetaLevelTextWrapper(prestigeLevelTF).bgId = param1.bgImageId;
      }
      
      override public function setIconSize(param1:String) : void
      {
         super.setIconSize(param1);
         BattleRoyaleMetaLevelTextWrapper(prestigeLevelTF).size = param1;
      }
      
      override protected function getImageSource(param1:String) : String
      {
         return RES_ICONS.getBattleRoyaleLvlIcon(IMAGE_SIZES[size],param1);
      }
      
      override protected function getSeasonFontSize() : int
      {
         return SEASON_FONT_SIZES[size];
      }
      
      override protected function getSeasonOffsetX() : int
      {
         return DEFAULT_OFFSET;
      }
      
      override protected function getSeasonOffsetY() : int
      {
         return SEASON_OFFSETS_Y[size];
      }
      
      override protected function getLevelFontSize() : int
      {
         return LEVEL_FONT_SIZES[size];
      }
      
      override protected function getLevelOffsetX() : int
      {
         return DEFAULT_OFFSET;
      }
      
      override protected function getLevelOffsetY() : int
      {
         return LEVEL_OFFSETS_Y[size];
      }
      
      override protected function getBackgroundOffsetY() : int
      {
         return BACKGROUND_OFFSETS_Y[size];
      }
   }
}
