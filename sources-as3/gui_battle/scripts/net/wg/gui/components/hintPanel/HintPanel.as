package net.wg.gui.components.hintPanel
{
   import fl.motion.easing.Quartic;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.BATTLE_SOUND;
   import net.wg.gui.battle.events.BattleSoundEvent;
   import net.wg.infrastructure.base.meta.IBattleHintPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintPanelMeta;
   import scaleform.clik.motion.Tween;
   
   public class HintPanel extends BattleHintPanelMeta implements IBattleHintPanelMeta
   {
      
      private static const TEXTFIELD_PADDING:int = 5;
      
      private static const GAP:int = 18;
      
      private static const BACKGROUND_INNER_PADDING:int = 48;
      
      private static const REDUCED_BACKGROUND_INNER_PADDING:int = 24;
      
      private static const BG_INIT_Y:int = 48;
      
      private static const BG_INIT_SCALE:int = 0;
      
      private static const BG_INIT_ALPHA:int = 0;
      
      private static const BG_FADE_OUT_ALPHA:int = 1;
      
      private static const FADE_IN_FRAME:String = "fadeIn";
      
      private static const FADE_OUT_FRAME:String = "fadeOut";
      
      private static const FADE_IN_BG_DURATION:int = 200;
      
      private static const FADE_IN_BG_DELAY:int = 400;
      
      private static const FADE_IN_BG_SCALE_Y:int = 5;
      
      private static const FADE_IN_BG_ALPHA:int = 1;
      
      private static const FADE_OUT_BG_DURATION:int = 870;
      
      private static const FADE_OUT_BG_Y:int = 148;
      
      private static const FADE_OUT_BG_ALPHA:int = 0;
      
      private static const KEY_EFFECT_OFFSET_X:int = 3;
       
      
      public var appearanceEffectAnim:MovieClip = null;
      
      public var keyEffectAnim:KeyViewerContainerAnim = null;
      
      public var keyAnim:KeyViewerContainerAnim = null;
      
      public var messageLeftAnim:MessageAnim = null;
      
      public var messageRightAnim:MessageAnim = null;
      
      public var bg:Sprite = null;
      
      private var _fadeInBgTween:Tween = null;
      
      private var _fadeOutBgTween:Tween = null;
      
      private var _keyValue:String = "";
      
      private var _messageLeft:String = "";
      
      private var _messageRight:String = "";
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var _reducedPanning:Boolean = false;
      
      private var _keySelected:Boolean = false;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _isShow:Boolean = false;
      
      public function HintPanel()
      {
         super();
         super.visible = false;
         this._height = this.bg.height / this.bg.scaleY * FADE_IN_BG_SCALE_Y;
         this.keyAnim.addFrameScript(this.keyAnim.totalFrames - 1,this.onFadeOutComplete);
         this._fadeInBgTween = new Tween(FADE_IN_BG_DURATION,this.bg,{
            "scaleY":FADE_IN_BG_SCALE_Y,
            "alpha":FADE_IN_BG_ALPHA
         },{
            "paused":true,
            "ease":Quartic.easeIn,
            "delay":FADE_IN_BG_DELAY,
            "onComplete":null
         });
         this._fadeInBgTween.fastTransform = false;
         this._fadeOutBgTween = new Tween(FADE_OUT_BG_DURATION,this.bg,{
            "y":FADE_OUT_BG_Y,
            "alpha":FADE_OUT_BG_ALPHA
         },{
            "paused":true,
            "onComplete":null
         });
         this._fadeOutBgTween.fastTransform = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.keyEffectAnim.addEventListener(BattleSoundEvent.ON_SOUND_PLAY,this.onKeyEffectAnimOnSoundPlayHandler);
         this.messageLeftAnim.x = BACKGROUND_INNER_PADDING;
      }
      
      override protected function onDispose() : void
      {
         this._fadeInBgTween.dispose();
         this._fadeInBgTween = null;
         this._fadeOutBgTween.dispose();
         this._fadeOutBgTween = null;
         this.appearanceEffectAnim.stop();
         this.appearanceEffectAnim = null;
         this.keyEffectAnim.removeEventListener(BattleSoundEvent.ON_SOUND_PLAY,this.onKeyEffectAnimOnSoundPlayHandler);
         this.keyEffectAnim.dispose();
         this.keyEffectAnim = null;
         this.keyAnim.addFrameScript(this.keyAnim.totalFrames - 1,null);
         this.keyAnim.dispose();
         this.keyAnim = null;
         this.messageLeftAnim.dispose();
         this.messageLeftAnim = null;
         this.messageRightAnim.dispose();
         this.messageRightAnim = null;
         this.bg = null;
         super.onDispose();
      }
      
      public function as_setData(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Boolean) : void
      {
         if(param2 != this._keyValue)
         {
            this._keyValue = param2;
            this._keySelected = Boolean(param2);
            if(this._keySelected)
            {
               this.keyAnim.setKey(param1,param2);
               this.keyEffectAnim.setKey(param1,param2);
            }
         }
         if(this._keySelected)
         {
            if(param3 != this._messageLeft)
            {
               this._messageLeft = param3;
               this.messageLeftAnim.setText(param3);
               this.messageLeftAnim.setTextFieldWidth(this.messageLeftAnim.textFieldContainer.textField.textWidth + TEXTFIELD_PADDING);
            }
         }
         if(param4 != this._messageRight)
         {
            this._messageRight = param4;
            this.messageRightAnim.setText(param4);
            this.messageRightAnim.setTextFieldWidth(this.messageRightAnim.textFieldContainer.textField.textWidth + TEXTFIELD_PADDING);
         }
         this._offsetX = param5;
         this._offsetY = param6;
         this._reducedPanning = param7;
         this.update();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      private function update() : void
      {
         var _loc3_:int = 0;
         this.messageLeftAnim.visible = this._keySelected;
         this.keyEffectAnim.visible = this._keySelected;
         this.keyAnim.visible = this._keySelected;
         if(this._keySelected)
         {
            _loc3_ = (this.keyAnim.width >> 1) + this.messageLeftAnim.width + GAP ^ 0;
            if(!this._reducedPanning)
            {
               _loc3_ += BACKGROUND_INNER_PADDING;
            }
            this.keyAnim.x = _loc3_;
            this.keyEffectAnim.x = _loc3_ - KEY_EFFECT_OFFSET_X;
            this.messageRightAnim.x = _loc3_ + this.keyAnim.width;
         }
         else if(!this._reducedPanning)
         {
            this.messageRightAnim.x = BACKGROUND_INNER_PADDING;
         }
         var _loc1_:int = this.messageRightAnim.x + this.messageRightAnim.width;
         if(this._reducedPanning)
         {
            _loc1_ += REDUCED_BACKGROUND_INNER_PADDING ^ 0;
         }
         else
         {
            _loc1_ += BACKGROUND_INNER_PADDING ^ 0;
         }
         if(_loc1_ != this._width)
         {
            this._width = _loc1_;
            dispatchEvent(new Event(Event.RESIZE));
         }
         var _loc2_:int = this._width >> 1;
         this.bg.width = this._width;
         this.bg.x = _loc2_;
         this.appearanceEffectAnim.x = _loc2_;
      }
      
      private function onFadeOutComplete() : void
      {
         onHideCompleteS();
      }
      
      private function playSnd(param1:String) : void
      {
         onPlaySoundS(param1);
      }
      
      public function as_toggle(param1:Boolean) : void
      {
         if(this._isShow != param1)
         {
            this._isShow = param1;
            if(param1)
            {
               this._fadeOutBgTween.paused = true;
               this.bg.y = BG_INIT_Y;
               this.bg.scaleY = BG_INIT_SCALE;
               this.bg.alpha = BG_INIT_ALPHA;
               this.keyEffectAnim.gotoAndPlay(FADE_IN_FRAME);
               this.keyAnim.gotoAndPlay(FADE_IN_FRAME);
               this.keyAnim.blendMode = BlendMode.SCREEN;
               this.messageLeftAnim.gotoAndPlay(FADE_IN_FRAME);
               this.messageRightAnim.gotoAndPlay(FADE_IN_FRAME);
               this.appearanceEffectAnim.gotoAndPlay(FADE_IN_FRAME);
               this._fadeInBgTween.reset();
               this._fadeInBgTween.paused = false;
            }
            else
            {
               this._fadeInBgTween.paused = true;
               this.bg.y = BG_INIT_Y;
               this.bg.scaleY = FADE_IN_BG_SCALE_Y;
               this.bg.alpha = BG_FADE_OUT_ALPHA;
               this.keyEffectAnim.gotoAndStop(1);
               this.keyAnim.gotoAndPlay(FADE_OUT_FRAME);
               this.keyAnim.blendMode = BlendMode.ADD;
               this.messageLeftAnim.gotoAndPlay(FADE_OUT_FRAME);
               this.messageRightAnim.gotoAndPlay(FADE_OUT_FRAME);
               this._fadeOutBgTween.reset();
               this._fadeOutBgTween.paused = false;
            }
            this.playSnd(!!param1 ? BATTLE_SOUND.SOUND_TYPE_HINT_PANNEL_SHOW : BATTLE_SOUND.SOUND_TYPE_HINT_PANNEL_HIDE);
         }
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      public function get offsetX() : int
      {
         return this._offsetX;
      }
      
      public function get offsetY() : int
      {
         return this._offsetY;
      }
      
      private function onKeyEffectAnimOnSoundPlayHandler(param1:BattleSoundEvent) : void
      {
         this.playSnd(param1.soundType);
      }
   }
}
