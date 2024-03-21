package net.wg.gui.battle.views.spectatorView
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.infrastructure.base.meta.ISpectatorViewMeta;
   import net.wg.infrastructure.base.meta.impl.SpectatorViewMeta;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class SpectatorView extends SpectatorViewMeta implements ISpectatorViewMeta
   {
      
      private static const LEFT_POSTMORTEM_PANE_OVERLAY_OFFSET:int = 24;
      
      private static const FADE_DURATION:int = 300;
      
      private static const MAX_SMALL_BUTTON_TF_WIDTH:int = 40;
      
      private static const defaultSpeed:int = 2;
      
      private static const BOTTOM_FOLLOW_HINT_OFFSET:int = 150;
      
      private static const HINT_MODE_INIT_ID:int = 0;
      
      private static const HINT_MODE_SPEED_IDLE:int = 1;
      
      private static const HINT_MODE_SPEED_LOADING:int = 2;
      
      private static const HINT_MODE_FINISHED:int = 3;
      
      private static const POSTMORTEM_Y_OFFSET:int = -100;
      
      private static const KEY_TEXTFIELD_WIDTH_PADDING:int = 2;
      
      private static const KEY_TEXTFIELD_HEIGHT_PADDING:int = 2;
      
      private static const KEY_FONT_MIN_SIZE:int = 10;
      
      private static const KEY_FONT_MAX_SIZE:int = 72;
       
      
      public var postmortemPanelOverlay:MovieClip = null;
      
      public var followHint:MovieClip = null;
      
      public var returnHint:MovieClip = null;
      
      public var movementHint:MovieClip = null;
      
      public var speedHeightHint:MovieClip = null;
      
      public var speedHint:MovieClip = null;
      
      private var _hintTween:Tween = null;
      
      private var _isFollowLabelVisible:Boolean = false;
      
      private var _isReplay:Boolean = false;
      
      public function SpectatorView()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.postmortemPanelOverlay.msgTitleTF.text = EPIC_BATTLE.SPECTATOR_MODE_MSG_TEXT;
         this.returnHint.returnTextTF.autoSize = TextFieldAutoSize.LEFT;
         this.returnHint.returnTextTF.text = DEATH_CAM.HINTS_FREE_CAM_RETURN_PREVIOUS;
         TextFieldEx.setVerticalAlign(this.returnHint.returnTextTF,TextFieldEx.VALIGN_CENTER);
         this.followHint.followTextTF.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setVerticalAlign(this.followHint.followTextTF,TextFieldEx.VALIGN_CENTER);
         this.followHint.visible = false;
         this.movementHint.alpha = 0;
         this.speedHeightHint.alpha = 0;
         this.speedHint.alpha = 0;
         this.returnHint.alpha = 0;
         this.speedHeightHint.highlightButtonsMC.gotoAndStop(defaultSpeed);
         this.speedHeightHint.heightTF.autoSize = TextFieldAutoSize.LEFT;
         this.speedHint.highlightButtonsMC.gotoAndStop(defaultSpeed);
         this.postmortemPanelOverlay.visible = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._hintTween != null)
         {
            this._hintTween.paused = true;
            this._hintTween.dispose();
            this._hintTween = null;
         }
         this.postmortemPanelOverlay = null;
         this.followHint = null;
         this.returnHint = null;
         this.movementHint = null;
         this.speedHeightHint = null;
         this.speedHint = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.followHint.visible = this._isFollowLabelVisible;
         }
      }
      
      public function as_changeMode(param1:int) : void
      {
         if(EPIC_CONSTS.SPECTATOR_VIEW_STATES.indexOf(param1) != -1)
         {
            invalidateData();
         }
      }
      
      public function as_focusOnVehicle(param1:Boolean) : void
      {
         this._isFollowLabelVisible = param1;
         invalidateData();
      }
      
      public function as_setFollowInfoText(param1:String) : void
      {
         this.followHint.followTextTF.text = param1;
      }
      
      public function as_setTimer(param1:String) : void
      {
         if(!this.postmortemPanelOverlay.visible)
         {
            this.postmortemPanelOverlay.visible = true;
            this._addPostmortemOverlayOffset();
         }
         this.postmortemPanelOverlay.TimerTF.text = param1;
      }
      
      public function as_setSpeed(param1:int) : void
      {
         this.speedHeightHint.highlightButtonsMC.gotoAndStop(3 - param1);
         this.speedHint.highlightButtonsMC.gotoAndStop(3 - param1);
      }
      
      public function as_setHintStrings(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) : void
      {
         if(this._textNeedsBigLayout(param7) || this._textNeedsBigLayout(param8))
         {
            this.speedHeightHint.gotoAndPlay(2);
         }
         this.speedHeightHint.spectatorHeightUpTF.text = param7;
         this.speedHeightHint.spectatorHeightUpTF.text = param7;
         this.speedHeightHint.spectatorHeightDownTF.text = param8;
         this.movementHint.headlineTF.text = param1;
         this.movementHint.descriptionTF.text = param2;
         this._fitTextInTextField(this.movementHint.descriptionTF);
         this.speedHint.speedHeadlineTF.text = param3;
         this.speedHeightHint.speedHeadlineTF.text = param3;
         this.speedHeightHint.speedTF.text = param4;
         this.speedHeightHint.heightHeadlineTF.text = param5;
         this.speedHeightHint.heightTF.text = param6;
      }
      
      public function as_toggleHint(param1:int) : void
      {
         switch(param1)
         {
            case HINT_MODE_INIT_ID:
               this._animateHint(this.movementHint,true);
               break;
            case HINT_MODE_SPEED_IDLE:
               this._animateHint(this.speedHeightHint,true);
               break;
            case HINT_MODE_SPEED_LOADING:
               this._animateHint(this.speedHeightHint,false);
               if(this.returnHint.alpha == 0 && this.speedHint.alpha == 0)
               {
                  this._animateHint(this.returnHint,true);
                  this._animateHint(this.speedHint,true);
               }
               break;
            case HINT_MODE_FINISHED:
               this._animateHint(this.movementHint,false);
               this._animateHint(this.speedHeightHint,false);
               this._animateHint(this.returnHint,true);
               this._animateHint(this.speedHint,true);
         }
      }
      
      public function as_showMovementHint(param1:Boolean) : void
      {
         this._animateHint(this.movementHint,param1);
      }
      
      public function as_showSpeedHint(param1:Boolean) : void
      {
         this._animateHint(this.speedHint,param1);
      }
      
      public function as_showSpeedHeightHint(param1:Boolean) : void
      {
         this._animateHint(this.speedHeightHint,param1);
      }
      
      public function as_showReturnHint(param1:Boolean) : void
      {
         this._animateHint(this.returnHint,param1);
      }
      
      public function as_handleAsReplay() : void
      {
         this._isReplay = true;
      }
      
      public function as_updateMovementHintControls(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.movementHint.buttonsMC.spectatorMovementUp.text = param1;
         this.movementHint.buttonsMC.spectatorMovementLeft.text = param2;
         this.movementHint.buttonsMC.spectatorMovementDown.text = param3;
         this.movementHint.buttonsMC.spectatorMovementRight.text = param4;
         this._fitTextInTextField(this.movementHint.buttonsMC.spectatorMovementUp);
         this._fitTextInTextField(this.movementHint.buttonsMC.spectatorMovementDown);
         this._fitTextInTextField(this.movementHint.buttonsMC.spectatorMovementLeft);
         this._fitTextInTextField(this.movementHint.buttonsMC.spectatorMovementRight);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.movementHint.x = param1 >> 1;
         this.movementHint.y = param2;
         this.returnHint.x = param1 >> 1;
         this.returnHint.y = param2;
         this.speedHint.x = 0;
         this.speedHint.y = param2;
         this.speedHeightHint.x = (param1 >> 1) - this.speedHeightHint.width * 0.5;
         this.speedHeightHint.y = param2;
         this.postmortemPanelOverlay.x = (param1 >> 1) - LEFT_POSTMORTEM_PANE_OVERLAY_OFFSET;
         this.postmortemPanelOverlay.y = param2;
         this.followHint.x = param1 >> 1;
         this.followHint.y = param2 - BOTTOM_FOLLOW_HINT_OFFSET;
         if(this.postmortemPanelOverlay.visible)
         {
            this._addPostmortemOverlayOffset();
         }
      }
      
      private function _addPostmortemOverlayOffset() : void
      {
         this.movementHint.y += POSTMORTEM_Y_OFFSET;
         this.speedHeightHint.y += POSTMORTEM_Y_OFFSET;
         this.followHint.y += POSTMORTEM_Y_OFFSET;
         this.returnHint.y += POSTMORTEM_Y_OFFSET;
      }
      
      private function _animateHint(param1:MovieClip, param2:Boolean) : void
      {
         param2 = !!this._isReplay ? Boolean(false) : Boolean(param2);
         this._hintTween = new Tween(FADE_DURATION,param1,{"alpha":(!!param2 ? 1 : 0)},{"paused":false});
      }
      
      private function _textNeedsBigLayout(param1:String) : Boolean
      {
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         return _loc2_.textWidth > MAX_SMALL_BUTTON_TF_WIDTH;
      }
      
      private function _fitTextInTextField(param1:TextField) : void
      {
         var _loc5_:int = 0;
         var _loc2_:TextFormat = param1.defaultTextFormat;
         var _loc3_:int = KEY_FONT_MIN_SIZE;
         var _loc4_:int = KEY_FONT_MAX_SIZE;
         while(_loc3_ <= _loc4_)
         {
            _loc5_ = (_loc3_ + _loc4_) / 2;
            _loc2_.size = _loc5_;
            param1.setTextFormat(_loc2_);
            if(this._isTextOverflowing(param1))
            {
               _loc4_ = _loc5_ - 1;
            }
            else
            {
               _loc3_ = _loc5_ + 1;
            }
            _loc2_.size = _loc4_;
            param1.setTextFormat(_loc2_);
         }
      }
      
      private function _isTextOverflowing(param1:TextField) : Boolean
      {
         return param1.textWidth > param1.width - KEY_TEXTFIELD_WIDTH_PADDING || param1.textHeight > param1.height - KEY_TEXTFIELD_HEIGHT_PADDING;
      }
   }
}
