package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import flash.events.Event;
   
   public class EpicBattleMetaLevel extends BaseMetaLevel
   {
      
      private static const IMAGE_SIZES:Object = {};
      
      private static const LEVEL_FONT_SIZES:Object = {};
      
      private static const LEVEL_OFFSETS_X:Object = {};
      
      private static const LEVEL_OFFSETS_Y:Object = {};
      
      private static const BACKGROUND_OFFSET_Y:int = 0;
      
      {
         IMAGE_SIZES[EXTRA_SMALL] = "130x130";
         IMAGE_SIZES[SMALL] = "150x150";
         IMAGE_SIZES[MEDIUM] = "190x190";
         IMAGE_SIZES[LARGE] = "270x270";
         IMAGE_SIZES[EXTRA_LARGE] = "320x320";
         LEVEL_FONT_SIZES[EXTRA_SMALL] = 22;
         LEVEL_FONT_SIZES[SMALL] = 26;
         LEVEL_FONT_SIZES[MEDIUM] = 35;
         LEVEL_FONT_SIZES[LARGE] = 50;
         LEVEL_FONT_SIZES[EXTRA_LARGE] = 65;
         LEVEL_OFFSETS_X[EXTRA_SMALL] = 1;
         LEVEL_OFFSETS_X[SMALL] = 0;
         LEVEL_OFFSETS_X[MEDIUM] = 0;
         LEVEL_OFFSETS_X[LARGE] = 0;
         LEVEL_OFFSETS_X[EXTRA_LARGE] = 0;
         LEVEL_OFFSETS_Y[EXTRA_SMALL] = -22;
         LEVEL_OFFSETS_Y[SMALL] = -25;
         LEVEL_OFFSETS_Y[MEDIUM] = -31;
         LEVEL_OFFSETS_Y[LARGE] = -45;
         LEVEL_OFFSETS_Y[EXTRA_LARGE] = -58;
      }
      
      public function EpicBattleMetaLevel()
      {
         super();
      }
      
      override protected function validateLevel() : void
      {
      }
      
      override protected function disposeLevel() : void
      {
      }
      
      override protected function addListeners() : void
      {
         prestigeLevelTF.addEventListener(Event.RESIZE,onTextWrapperResizeHandler);
         bgImage.addEventListener(Event.CHANGE,onImageChangeHandler);
      }
      
      override protected function removeListeners() : void
      {
         prestigeLevelTF.removeEventListener(Event.RESIZE,onTextWrapperResizeHandler);
         bgImage.removeEventListener(Event.CHANGE,onImageChangeHandler);
      }
      
      override protected function validateLayout() : void
      {
         prestigeLevelTF.x = (-prestigeLevelTF.width >> 1) + this.getLevelOffsetX();
      }
      
      override protected function getImageSource(param1:String) : String
      {
         return RES_ICONS.getEpicMetaLvlIcon(IMAGE_SIZES[size],param1);
      }
      
      override protected function getLevelFontSize() : int
      {
         return LEVEL_FONT_SIZES[size];
      }
      
      override protected function getLevelOffsetX() : int
      {
         return LEVEL_OFFSETS_X[size];
      }
      
      override protected function getLevelOffsetY() : int
      {
         return LEVEL_OFFSETS_Y[size];
      }
      
      override protected function getBackgroundOffsetY() : int
      {
         return BACKGROUND_OFFSET_Y;
      }
   }
}
