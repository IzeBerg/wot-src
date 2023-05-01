package net.wg.gui.battle.components.poi.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.gui.battle.components.BaseProgressCircle;
   
   public class PoiWithProgressStateCircle extends BaseProgressCircle
   {
      
      private static const PROGRESS_STATE:String = "progress";
      
      private static const EMPTY_LAST_FRAME:int = 181;
      
      private static const ICON_COOLDOWN_ALPHA:Number = 0.6;
      
      private static const INV_FRAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const PRECISION:Number = 0.005;
       
      
      public var icon:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      protected var iconType:uint = 0;
      
      protected var progress:Number = 0;
      
      protected var statusID:int = 0;
      
      private var _isAlly:Boolean;
      
      public function PoiWithProgressStateCircle()
      {
         super();
      }
      
      override public function updateProgress(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(Math.abs(this.progress - param1) >= PRECISION)
         {
            this.progress = param1;
            _loc2_ = this.progress * SEMI_LAST_FRAME >> 0;
            currentProgressFrame = _loc2_;
            this.afterProgressUpdate();
         }
      }
      
      protected function afterProgressUpdate() : void
      {
         invalidate(INV_FRAME);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         state = PROGRESS_STATE;
         currentProgressFrame = EMPTY_LAST_FRAME;
         invalidate(INV_FRAME);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.drawBackIcon();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = 1;
            if(this.statusID == POI_CONSTS.POI_STATUS_CAPTURING)
            {
               _loc2_ = !!this._isAlly ? ALLY_STATE : this.getCorrectState(ENEMY_STATE);
            }
            else
            {
               _loc2_ = PROGRESS_STATE;
               if(this.statusID == POI_CONSTS.POI_STATUS_ACTIVE)
               {
                  currentProgressFrame = EMPTY_LAST_FRAME;
               }
               else
               {
                  _loc1_ = this.getIconCooldownAlpha();
               }
            }
            if(state != _loc2_)
            {
               state = _loc2_;
            }
            this.icon.alpha = _loc1_;
            invalidate(INV_FRAME);
         }
         if(isInvalid(INV_FRAME))
         {
            this.applyStateAndProgress();
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.highlight = null;
         super.onDispose();
      }
      
      override protected function getCorrectState(param1:String) : String
      {
         if(param1 == ENEMY_STATE || param1 == COLORBLIND_STATE)
         {
            return !!colorblindMode ? COLORBLIND_STATE : ENEMY_STATE;
         }
         if(param1 == ALLY_STATE)
         {
            return ALLY_STATE;
         }
         return PROGRESS_STATE;
      }
      
      public function setIconType(param1:uint) : void
      {
         if(this.iconType != param1)
         {
            this.iconType = param1;
            this.drawIconType();
         }
      }
      
      public function setIsAlly(param1:Boolean) : void
      {
         this._isAlly = param1;
         invalidateState();
      }
      
      public function setStatusID(param1:int) : void
      {
         if(this.statusID != param1)
         {
            this.statusID = param1;
            invalidateState();
         }
      }
      
      protected function getIconCooldownAlpha() : Number
      {
         return ICON_COOLDOWN_ALPHA;
      }
      
      protected function drawIconType() : void
      {
      }
      
      protected function setColorBlindMode(param1:Boolean) : void
      {
         if(colorblindMode != param1)
         {
            colorblindMode = param1;
            invalidateState();
         }
      }
      
      protected function drawBackIcon() : void
      {
      }
      
      protected function updateColorBlind() : void
      {
      }
      
      protected function applyStateAndProgress() : void
      {
         if(currentFrameLabel != state)
         {
            gotoAndStop(state);
         }
         if(progressCircle.currentFrame != curFrame)
         {
            progressCircle.gotoAndStop(curFrame);
         }
      }
   }
}
