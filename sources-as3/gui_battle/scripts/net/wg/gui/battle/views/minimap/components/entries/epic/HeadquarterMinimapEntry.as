package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class HeadquarterMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const HQ_ID_MAX:int = 5;
      
      private static const IDX_WARNING_TEXT:String = "[HeadquarterMinimapEntry] HQ Letter id out of range!";
      
      private static const EMPTY_SUFFIX:String = "";
      
      private static const DESTROYED_FRAME:int = 2;
      
      private static const DEFAULT_FRAME:int = 1;
       
      
      public var animationColorblind:MovieClip = null;
      
      public var replyColorBlind:MovieClip = null;
      
      public var hqLetter:MovieClip = null;
      
      public var hqId:ObjectiveIdReplyState = null;
      
      public var hqIdColorBlind:ObjectiveIdReplyState = null;
      
      public var hqIconAtlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _statePrefix:String = null;
      
      private var _isColorBlindMode:Boolean = false;
      
      private var _isPlayerTeam:Boolean = false;
      
      private var _stateSuffix:String = "";
      
      private var _id:int = -1;
      
      public function HeadquarterMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.checkForColorBlindMode();
         this._statePrefix = EpicMinimapEntryConst.HEADQUARTER_ATLAS_ITEM_NAME + this.getEnemySuffix();
         this.setHeadquarterIcon(this._statePrefix);
      }
      
      override protected function onDispose() : void
      {
         this.hqIconAtlasPlaceholder = null;
         this.hqId.dispose();
         this.hqId = null;
         this._atlasManager = null;
         if(this.hqIdColorBlind)
         {
            this.hqIdColorBlind.dispose();
            this.hqIdColorBlind = null;
         }
         if(this.animationColorblind)
         {
            this.animationColorblind.stop();
            this.animationColorblind = null;
         }
         if(this.replyColorBlind)
         {
            this.replyColorBlind.stop();
            this.replyColorBlind = null;
         }
         this.hqLetter.stop();
         this.hqLetter = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.onDispose();
      }
      
      override protected function setAttackState(param1:Boolean) : void
      {
         animation.visible = !this._isColorBlindMode;
         animation.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : getCurrentAnimationFrame());
         reply.visible = false;
         this.hqId.setActiveState(ActionMarkerStates.PING_CREATE_STATE,this._id);
         this.hqLetter.visible = false;
         if(this.hasColorBlindMode())
         {
            this.animationColorblind.visible = this._isColorBlindMode;
            this.animationColorblind.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : getCurrentAnimationFrame());
            this.replyColorBlind.visible = false;
            this.hqIdColorBlind.setActiveState(ActionMarkerStates.PING_CREATE_STATE,this._id);
         }
      }
      
      override protected function setReplyState(param1:Boolean) : void
      {
         reply.visible = !this._isColorBlindMode;
         animation.visible = false;
         reply.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : getCurrentReplyFrame());
         this.hqId.setActiveState(ActionMarkerStates.REPLIED_ME,this._id);
         this.hqLetter.visible = false;
         if(this.hasColorBlindMode())
         {
            this.replyColorBlind.visible = this._isColorBlindMode;
            this.animationColorblind.visible = false;
            this.replyColorBlind.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : getCurrentReplyFrame());
            this.hqIdColorBlind.setActiveState(ActionMarkerStates.REPLIED_ME,this._id);
         }
      }
      
      override protected function setIdleState(param1:Boolean) : void
      {
         animation.visible = !this._isColorBlindMode;
         animation.gotoAndPlay(!!param1 ? IDLE_FRAME : getCurrentAnimationFrame());
         reply.visible = false;
         this.hqId.setActiveState(ActionMarkerStates.REPLIED_ALLY,this._id);
         this.hqLetter.visible = false;
         if(this.hasColorBlindMode())
         {
            this.animationColorblind.visible = this._isColorBlindMode;
            this.animationColorblind.gotoAndPlay(!!param1 ? IDLE_FRAME : getCurrentAnimationFrame());
            this.replyColorBlind.visible = false;
            this.hqIdColorBlind.setActiveState(ActionMarkerStates.REPLIED_ALLY,this._id);
         }
      }
      
      override protected function setDefaultState() : void
      {
         animation.visible = false;
         reply.visible = false;
         this.hqId.setActiveState(ActionMarkerStates.NEUTRAL,this._id);
         this.hqLetter.visible = true;
         if(this.hasColorBlindMode())
         {
            this.hqIdColorBlind.setActiveState(ActionMarkerStates.NEUTRAL,this._id);
            this.animationColorblind.visible = false;
            this.replyColorBlind.visible = false;
         }
      }
      
      public function setDead(param1:Boolean) : void
      {
         this._stateSuffix = !!param1 ? EpicMinimapEntryConst.SUFIX_DESTROYED : EMPTY_SUFFIX;
         this.setHeadquarterIcon(this._statePrefix + this._stateSuffix);
         if(param1)
         {
            gotoAndPlay(DESTROYED_FRAME);
         }
         else
         {
            gotoAndStop(DEFAULT_FRAME);
         }
      }
      
      public function setIdentifier(param1:int) : void
      {
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.setHeadquarterLetter(param1);
         this._id = param1;
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         this._isPlayerTeam = param1;
         var _loc2_:String = !!param1 ? EpicMinimapEntryConst.SUFIX_ALLY : this.getEnemySuffix();
         this._statePrefix = EpicMinimapEntryConst.HEADQUARTER_ATLAS_ITEM_NAME + _loc2_;
         this.setHeadquarterIcon(this._statePrefix);
         this.hqId.setActiveState(ActionMarkerStates.REPLIED_ME,this._id);
         if(this.hasColorBlindMode())
         {
            this.hqIdColorBlind.setActiveState(ActionMarkerStates.REPLIED_ME,this._id);
         }
      }
      
      private function hasColorBlindMode() : Boolean
      {
         return this.hqIdColorBlind != null && this.animationColorblind != null && this.replyColorBlind != null;
      }
      
      private function setHeadquarterIcon(param1:String) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.hqIconAtlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
      }
      
      private function setHeadquarterLetter(param1:int) : void
      {
         if(param1 < 1 || param1 > HQ_ID_MAX)
         {
            DebugUtils.LOG_WARNING(IDX_WARNING_TEXT,param1);
            return;
         }
         this.hqLetter.gotoAndStop(param1);
      }
      
      private function checkForColorBlindMode() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.hasColorBlindMode();
         this._isColorBlindMode = App.colorSchemeMgr.getIsColorBlindS() && _loc1_;
         this.hqId.visible = !this._isColorBlindMode;
         animation.visible = !this._isColorBlindMode;
         reply.visible = !this._isColorBlindMode;
         if(_loc1_)
         {
            this.hqIdColorBlind.visible = this._isColorBlindMode;
            this.animationColorblind.visible = this._isColorBlindMode;
            this.replyColorBlind.visible = this._isColorBlindMode;
         }
      }
      
      private function getEnemySuffix() : String
      {
         return !!this._isColorBlindMode ? EpicMinimapEntryConst.SUFIX_COLORBLIND : EpicMinimapEntryConst.SUFIX_ENEMY;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
         var _loc2_:String = !!this._isPlayerTeam ? EpicMinimapEntryConst.SUFIX_ALLY : this.getEnemySuffix();
         this._statePrefix = EpicMinimapEntryConst.HEADQUARTER_ATLAS_ITEM_NAME + _loc2_;
         this.setHeadquarterIcon(this._statePrefix + this._stateSuffix);
      }
   }
}
