package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   
   public class HeadquarterIcon extends BattleIconHolder
   {
      
      private static const LABEL_LIVE:String = "live";
      
      private static const LABEL_DEAD:String = "death";
      
      private static const LABEL_HIT:String = "hit";
      
      private static const LABEL_HIT_PIERCED:String = "hit_pierced";
      
      private static const ALLY:String = "ally";
      
      private static const ENEMY:String = "enemy";
      
      private static const COLORBLIND:String = "colorblind";
      
      private static const ALLY_BASE_HOVER:String = "allyBaseHover";
      
      private static const ENEMY_BASE_HOVER:String = "enemyBaseHover";
      
      private static const COLORBLIND_BASE_HOVER:String = "enemyColorBlindBaseHover";
       
      
      public var hqId:MovieClip = null;
      
      public var targetHighlight:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var bgAnimation:HeadquarterAnimation = null;
      
      private var _isPlayerTeam:Boolean = false;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _isHudElement:Boolean;
      
      public function HeadquarterIcon()
      {
         super();
         this.hover.visible = false;
         this.targetHighlight.visible = false;
         this.hqId.visible = true;
         this.bgAnimation.visible = true;
         this._vmManager = VehicleMarkersManager.getInstance();
      }
      
      public function setColor() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:Boolean = !!this._isHudElement ? Boolean(App.colorSchemeMgr.getIsColorBlindS()) : Boolean(this._vmManager.isColorBlind);
         if(this._isPlayerTeam)
         {
            _loc2_ = ALLY;
            _loc3_ = ALLY_BASE_HOVER;
         }
         else if(_loc1_)
         {
            _loc2_ = COLORBLIND;
            _loc3_ = COLORBLIND_BASE_HOVER;
         }
         else
         {
            _loc2_ = ENEMY;
            _loc3_ = ENEMY_BASE_HOVER;
         }
         this.bgAnimation.gotoAndStop(_loc2_);
         this.hover.gotoAndStop(_loc3_);
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         showItem(this.bgAnimation);
         this._isPlayerTeam = param1;
         this.setColor();
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this.hover.visible = param1;
      }
      
      public function setDead(param1:Boolean) : void
      {
         if(!param1)
         {
            this.bgAnimation.gotoAndPlayAnimation(LABEL_LIVE);
         }
         else
         {
            this.bgAnimation.gotoAndPlayAnimation(LABEL_DEAD);
         }
      }
      
      public function setHeadquarterId(param1:int) : void
      {
         this.hqId.gotoAndStop(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._isHudElement)
         {
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         }
         this.hqId.stop();
         this.hqId = null;
         this.targetHighlight.stop();
         this.targetHighlight = null;
         this.hover.stop();
         this.hover = null;
         this.bgAnimation.dispose();
         this.bgAnimation = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      public function setHit(param1:Boolean) : void
      {
         this.bgAnimation.gotoAndPlayAnimation(!!param1 ? LABEL_HIT_PIERCED : LABEL_HIT);
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
         this.setColor();
      }
   }
}
