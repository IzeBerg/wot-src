package net.wg.gui.battle.components.poi.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BaseProgressCircle;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   
   public class PoiProgressCircle extends BaseProgressCircle
   {
      
      private static const EMPTY_LAST_FRAME:int = 181;
       
      
      public var icon:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      private var _iconType:uint = 0;
      
      private var _isPlayerTeam:Boolean = false;
      
      public function PoiProgressCircle()
      {
         super();
         currentProgressFrame = this.defaultEmptyFrame;
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.highlight = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = !!this._isPlayerTeam ? ALLY_STATE : getCorrectState(ENEMY_STATE);
            if(state != _loc1_)
            {
               state = _loc1_;
               gotoAndStop(state);
               progressCircle.gotoAndStop(curFrame);
            }
         }
      }
      
      public function setColorBlindMode(param1:Boolean) : void
      {
         colorblindMode = param1;
         this.setOwner(this._isPlayerTeam);
      }
      
      public function setOwner(param1:Boolean) : void
      {
         if(this._isPlayerTeam != param1)
         {
            this._isPlayerTeam = param1;
            invalidateState();
         }
      }
      
      public function get iconType() : uint
      {
         return this._iconType;
      }
      
      public function set iconType(param1:uint) : void
      {
         this._iconType = param1;
         this.icon.gotoAndStop(this._iconType);
      }
      
      protected function get defaultEmptyFrame() : int
      {
         return EMPTY_LAST_FRAME;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
         invalidateState();
      }
   }
}
