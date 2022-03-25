package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ControlPointMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const COLOR_BLIND_FRAME:int = 2;
      
      private static const NORMAL_COLOR_FRAME:int = 1;
       
      
      public var atlasPlaceholder:Sprite = null;
      
      protected var _atlasManager:IAtlasManager;
      
      public function ControlPointMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
         this.checkForColorBlindMode();
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function configUI() : void
      {
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
      }
      
      private function checkForColorBlindMode() : void
      {
         gotoAndStop(!!App.colorSchemeMgr.getIsColorBlindS() ? COLOR_BLIND_FRAME : NORMAL_COLOR_FRAME);
      }
      
      override protected function SetAtlasPlaceholderVisible(param1:Boolean) : void
      {
         if(this.atlasPlaceholder == null)
         {
            return;
         }
         this.atlasPlaceholder.visible = param1;
      }
      
      public function setPointNumber(param1:int) : void
      {
         this.setControlPointIdentifier(param1);
      }
      
      protected function setControlPointIdentifier(param1:int) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.CONTROL_POINT_ATLAS_ITEM_NAME + "_" + param1,this.atlasPlaceholder.graphics,"",true);
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
