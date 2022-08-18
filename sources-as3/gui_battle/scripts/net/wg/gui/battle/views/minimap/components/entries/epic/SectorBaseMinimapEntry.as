package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.EpicProgressCircle;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class SectorBaseMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const BASE_ID_MAX:int = 6;
      
      private static const INDEX_WARNING_TEXT:String = "[SectorBaseMinimapEntry] Base Letter id out of range!";
      
      private static const COLOR_BLIND_FRAME:int = 2;
      
      private static const NORMAL_COLOR_FRAME:int = 1;
       
      
      public var highlightLetter:ObjectiveIdReplyState;
      
      public var atlasPlaceholder:Sprite = null;
      
      public var baseLetter:MovieClip = null;
      
      public var progressAnimation:EpicProgressCircle = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _id:int = -1;
      
      public function SectorBaseMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.checkForColorBlindMode();
      }
      
      override protected function onDispose() : void
      {
         this._atlasManager = null;
         this.atlasPlaceholder = null;
         this.baseLetter.stop();
         this.baseLetter = null;
         this.progressAnimation.stop();
         this.progressAnimation.dispose();
         this.progressAnimation = null;
         this.highlightLetter.stop();
         this.highlightLetter.dispose();
         this.highlightLetter = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
         super.onDispose();
      }
      
      override protected function setAttackState(param1:Boolean) : void
      {
         super.setAttackState(param1);
         this.highlightLetter.setActiveState(ActionMarkerStates.PING_CREATE_STATE,this._id);
         this.baseLetter.visible = false;
      }
      
      override protected function setReplyState(param1:Boolean) : void
      {
         super.setReplyState(param1);
         this.highlightLetter.setActiveState(ActionMarkerStates.REPLIED_ME,this._id);
         this.baseLetter.visible = false;
      }
      
      override protected function setIdleState(param1:Boolean) : void
      {
         super.setIdleState(param1);
         this.highlightLetter.setActiveState(ActionMarkerStates.REPLIED_ALLY,this._id);
         this.baseLetter.visible = false;
      }
      
      override protected function setDefaultState() : void
      {
         super.setDefaultState();
         this.baseLetter.visible = true;
         this.highlightLetter.setActiveState(ActionMarkerStates.NEUTRAL,this._id);
      }
      
      public function setCapturePoints(param1:Number) : void
      {
         this.progressAnimation.updateProgress(param1);
      }
      
      public function setIdentifier(param1:int) : void
      {
         this.setBaseLetter(param1);
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.EPIC_BASE_CAP_MINIMAP_ENTRY_BACKGROUND,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
         this.progressAnimation.setOwner(param1);
      }
      
      private function setBaseLetter(param1:int) : void
      {
         if(param1 < 1 || param1 > BASE_ID_MAX)
         {
            DebugUtils.LOG_WARNING(INDEX_WARNING_TEXT);
         }
         this._id = param1;
         this.baseLetter.gotoAndStop(param1);
      }
      
      private function checkForColorBlindMode() : void
      {
         gotoAndStop(!!App.colorSchemeMgr.getIsColorBlindS() ? COLOR_BLIND_FRAME : NORMAL_COLOR_FRAME);
         this.progressAnimation.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
      }
      
      private function onColorSchemeMgrSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
      }
   }
}
