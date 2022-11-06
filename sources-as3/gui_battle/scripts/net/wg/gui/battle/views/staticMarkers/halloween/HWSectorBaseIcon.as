package net.wg.gui.battle.views.staticMarkers.halloween
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   import net.wg.gui.battle.halloween.minimap.HWProgressCircle;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   
   public class HWSectorBaseIcon extends BattleIconHolder
   {
      
      public static const HOVER_STATE:int = 6;
      
      private static const EPIC_BASE:String = "epicBase";
      
      private static const BG_POSTFIX:String = "Base";
      
      private static const BG_COLORBLIND_POSTFIX:String = "ColorBlindBase";
      
      private static const HOVER_POSTFIX:String = "BaseHover";
      
      private static const HOVER_COLORBLIND_POSTFIX:String = "ColorBlindBaseHover";
      
      private static const ENEMY:String = "enemy";
      
      private static const NONE:String = "none";
      
      private static const ICON_SHIFT_GREEN:int = 7;
      
      private static const ICON_SHIFT_RED:int = 9;
      
      private static const ICON_SHIFT_BLIND:int = 11;
       
      
      public var progressCircle:HWProgressCircle = null;
      
      public var baseId:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      public var targetHighlight:MovieClip = null;
      
      public var sectorBaseHover:MovieClip = null;
      
      private var _owningTeam:String = null;
      
      private var _vmManager:VehicleMarkersManager;
      
      private var _isEpic:Boolean = false;
      
      private var _isHudElement:Boolean;
      
      private var _id:int = -1;
      
      public function HWSectorBaseIcon()
      {
         super();
         this._vmManager = VehicleMarkersManager.getInstance();
         this.bg.visible = true;
         this.progressCircle.visible = false;
         this.sectorBaseHover.visible = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._isHudElement)
         {
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         }
         this.progressCircle.dispose();
         this.progressCircle = null;
         this.baseId = null;
         this.bg = null;
         this.targetHighlight = null;
         this.sectorBaseHover = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      public function setBaseId(param1:int) : void
      {
         this._id = param1;
         this.baseId.gotoAndStop(this._id);
      }
      
      public function setCapturePoints(param1:Number) : void
      {
         this.progressCircle.updateProgress(param1);
      }
      
      public function activateEpicVisibility() : void
      {
         this._isEpic = true;
         this.progressCircle.visible = true;
         this.bg.visible = true;
         this.baseId.visible = true;
      }
      
      public function getOwningTeam() : String
      {
         return this._owningTeam;
      }
      
      public function setOwningTeam(param1:String, param2:String) : void
      {
         this._owningTeam = param1;
         this.progressCircle.setOwningTeam(param1,param2);
         this.setCorrectColor();
      }
      
      public function setCorrectColor() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = !!this._isHudElement ? Boolean(App.colorSchemeMgr.getIsColorBlindS()) : Boolean(this._vmManager.isColorBlind);
         var _loc2_:String = BG_POSTFIX;
         if(this._owningTeam != NONE)
         {
            _loc3_ = this._owningTeam == ENEMY ? int(this._id + ICON_SHIFT_RED) : int(this._id + ICON_SHIFT_GREEN);
            this.baseId.gotoAndStop(_loc3_);
         }
         else
         {
            this.baseId.gotoAndStop(this._id);
         }
         if(this._owningTeam == ENEMY && _loc1_)
         {
            _loc2_ = BG_COLORBLIND_POSTFIX;
            this.baseId.gotoAndStop(this._id + ICON_SHIFT_BLIND);
         }
         if(!this._isEpic)
         {
            this.bg.gotoAndStop(this._owningTeam + _loc2_);
         }
         else
         {
            this.bg.gotoAndStop(EPIC_BASE);
            this.progressCircle.setColorBlindMode(_loc1_);
         }
      }
      
      public function setActiveState(param1:int) : void
      {
         if(param1 == HOVER_STATE)
         {
            this.sectorBaseHover.visible = true;
            this.setHoverColor();
         }
         else
         {
            this.sectorBaseHover.visible = false;
            this.baseId.visible = param1 == ActionMarkerStates.NEUTRAL;
         }
      }
      
      public function setHoverColor() : void
      {
         var _loc1_:String = HOVER_POSTFIX;
         if(this._vmManager.isColorBlind && this._owningTeam == ENEMY)
         {
            _loc1_ = HOVER_COLORBLIND_POSTFIX;
         }
         this.sectorBaseHover.gotoAndStop(this._owningTeam + _loc1_);
      }
      
      public function set isHudElement(param1:Boolean) : void
      {
         this._isHudElement = param1;
         if(this._isHudElement)
         {
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         }
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.setCorrectColor();
      }
   }
}
