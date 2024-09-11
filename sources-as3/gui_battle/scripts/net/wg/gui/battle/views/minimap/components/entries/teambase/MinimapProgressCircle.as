package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.gfx.Extensions;
   
   public class MinimapProgressCircle extends BattleUIComponent
   {
      
      public static const SEMI_LAST_FRAME:int = 180;
      
      private static const ALLY_COLOR:uint = 8634923;
      
      private static const ENEMY_COLOR:uint = 14098707;
      
      private static const COLORBLIND_COLOR:uint = 7959001;
      
      private static const EMPTY_LAST_FRAME:int = 181;
      
      private static const INV_FRAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const PRECISION:Number = 0.005;
       
      
      public var progressCircle:MovieClip = null;
      
      protected var curFrame:int = 180;
      
      protected var colorblindMode:Boolean = false;
      
      protected var progress:Number = 0;
      
      private var _isAlly:Boolean;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      public function MinimapProgressCircle()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         Extensions.setEdgeAAMode(this.progressCircle,Extensions.EDGEAA_ON);
      }
      
      public function updateProgress(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(Math.abs(this.progress - param1) >= PRECISION)
         {
            this.progress = param1;
            _loc2_ = this.progress * SEMI_LAST_FRAME >> 0;
            this.curFrame = _loc2_;
            this.afterProgressUpdate();
         }
      }
      
      protected function afterProgressUpdate() : void
      {
         invalidate(INV_FRAME);
      }
      
      override protected function initialize() : void
      {
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this.updateColorBlind();
         super.initialize();
         this.setColor();
         this.curFrame = EMPTY_LAST_FRAME;
         invalidate(INV_FRAME);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.setColor();
            invalidate(INV_FRAME);
         }
         if(isInvalid(INV_FRAME))
         {
            this.applyStateAndProgress();
         }
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this.progressCircle = null;
         super.onDispose();
      }
      
      protected function setColor() : void
      {
         var _loc1_:ColorTransform = this.progressCircle.transform.colorTransform;
         _loc1_.color = this.getProgressColor();
         this.progressCircle.transform.colorTransform = _loc1_;
      }
      
      protected function getProgressColor() : uint
      {
         if(this._isAlly)
         {
            return ALLY_COLOR;
         }
         if(this.colorblindMode)
         {
            return COLORBLIND_COLOR;
         }
         return ENEMY_COLOR;
      }
      
      public function setIsAlly(param1:Boolean) : void
      {
         this._isAlly = param1;
         invalidateState();
      }
      
      protected function setColorBlindMode(param1:Boolean) : void
      {
         if(this.colorblindMode != param1)
         {
            this.colorblindMode = param1;
            invalidateState();
         }
      }
      
      protected function applyStateAndProgress() : void
      {
         if(this.progressCircle.currentFrame != this.curFrame)
         {
            this.progressCircle.gotoAndStop(this.curFrame);
         }
      }
      
      protected function updateColorBlind() : void
      {
         this.setColorBlindMode(this._colorSchemeMgr.getIsColorBlindS());
      }
      
      private function onSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColorBlind();
      }
   }
}
