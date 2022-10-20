package net.wg.gui.battle.halloween.minimap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class HWSectorBaseMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const BASE_ID_MAX:int = 6;
      
      private static const INDEX_WARNING_TEXT:String = "[SectorBaseMinimapEntry] Base Letter id out of range!";
      
      private static const COLOR_BLIND_FRAME:int = 2;
      
      private static const NORMAL_COLOR_FRAME:int = 1;
      
      private static const NONE:String = "none";
      
      private static const ENEMY:String = "enemy";
      
      private static const ICON_SHIFT_GREEN:int = 7;
      
      private static const ICON_SHIFT_RED:int = 9;
      
      private static const ICON_SHIFT_BLIND:int = 11;
       
      
      public var highlightLetter:ObjectiveIdReplyState;
      
      public var atlasPlaceholder:Sprite = null;
      
      public var baseLetter:MovieClip = null;
      
      public var progressAnimation:HWProgressCircle = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _id:int = -1;
      
      private var _owningTeam:String = "none";
      
      private var _attackingTeam:String = "none";
      
      public function HWSectorBaseMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.checkForColorBlindMode();
      }
      
      public function setTeamStatus(param1:String, param2:String = "none") : void
      {
         this._owningTeam = param1;
         this._attackingTeam = param2;
         this.setOwningTeam(this._owningTeam,this._attackingTeam);
         if(param1 == NONE && param2 == NONE)
         {
            this.progressAnimation.setNeutral();
         }
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
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.onDispose();
      }
      
      public function setCapturePoints(param1:Number) : void
      {
         this.progressAnimation.updateProgress(param1);
      }
      
      public function setIdentifier(param1:int) : void
      {
         this.setBaseLetter(param1);
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      public function setOwningTeam(param1:*, param2:*) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.EPIC_BASE_CAP_MINIMAP_ENTRY_BACKGROUND,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
         this.progressAnimation.setOwningTeam(param1,param2);
         this._owningTeam = param1;
         this.setCorrectBaseColor();
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
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
      }
      
      private function checkForColorBlindMode() : void
      {
         gotoAndStop(!!App.colorSchemeMgr.getIsColorBlindS() ? COLOR_BLIND_FRAME : NORMAL_COLOR_FRAME);
         this.progressAnimation.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
         this.setCorrectBaseColor();
      }
      
      private function setCorrectBaseColor() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = !!App.colorSchemeMgr.getIsColorBlindS() ? int(this._id + ICON_SHIFT_BLIND) : int(this._id + ICON_SHIFT_RED);
         if(this._owningTeam != NONE)
         {
            _loc2_ = this._owningTeam == ENEMY ? int(_loc1_) : int(this._id + ICON_SHIFT_GREEN);
            this.baseLetter.gotoAndStop(_loc2_);
         }
         else
         {
            this.baseLetter.gotoAndStop(this._id);
         }
      }
   }
}
