package net.wg.gui.components.advanced.tutorial
{
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.events.TutorialHintEvent;
   import net.wg.gui.components.advanced.interfaces.ITutorialHintAnimation;
   import net.wg.gui.components.advanced.interfaces.ITutorialHintArrowAnimation;
   import net.wg.gui.components.advanced.interfaces.ITutorialHintTextAnimation;
   import net.wg.gui.components.advanced.vo.TutorialHintVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class TutorialHint extends UIComponentEx
   {
      
      private static const GLOW_OFFSET:int = 13;
      
      private static const ARROW_OFFSET:int = 32;
      
      private static const HINT_BG_H_OFFSET:int = 14;
      
      private static const HINT_BG_V_OFFSET:int = 27;
      
      private static const TEXT_PADDING:int = 20;
      
      private static const HINT_BG_MIN_WIDTH:int = 130;
      
      private static const ROTATE_90:int = 90;
      
      private static const ROTATE_180:int = 180;
      
      private static const TEXT_ALPHA_DECREMENT:Number = 0.05;
      
      private static const SHOW_ALPHA:Number = 1;
      
      private static const HIDE_ALPHA:Number = 0;
      
      private static const ANIMATION_DURATION:int = 200;
       
      
      public var hintArrow:ITutorialHintArrowAnimation = null;
      
      public var hintBox:ITutorialHintAnimation = null;
      
      public var hintBG:ITutorialHintAnimation = null;
      
      public var hintText:ITutorialHintTextAnimation = null;
      
      private var _hintWidth:int = 0;
      
      private var _hintHeight:int = 0;
      
      private var _model:TutorialHintVO = null;
      
      private var _isHidden:Boolean = true;
      
      private var _forcedDirection:String;
      
      private var _textAlpha:Number = 1;
      
      private var _hideTextRuntime:Boolean;
      
      private var _tweens:Vector.<Tween>;
      
      public function TutorialHint()
      {
         this._tweens = new Vector.<Tween>();
         super();
         visible = false;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = param1 + (GLOW_OFFSET << 1);
         var _loc4_:int = param2 + (GLOW_OFFSET << 1);
         if(_loc3_ != this._hintWidth || _loc4_ != this._hintHeight)
         {
            this._hintWidth = _loc3_;
            this._hintHeight = _loc4_;
            invalidateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeTweens();
         this.hintArrow.removeEventListener(TutorialHintEvent.LOOP_ENDED,this.onLoopEndedHandler);
         this.hintArrow.dispose();
         this.hintArrow = null;
         this.hintBox.dispose();
         this.hintBox = null;
         this.hintBG.dispose();
         this.hintBG = null;
         this.hintText.dispose();
         this.hintText = null;
         this._model = null;
         this._tweens = null;
         hitArea = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         hitArea = _loc1_;
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && !this._isHidden)
         {
            if(isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SIZE))
            {
               if(this._model.hasBox)
               {
                  this.hintBox.setSize(this._hintWidth,this._hintHeight);
               }
               if(this._model.hasArrow)
               {
                  this.layoutArrow();
                  this.hintArrow.isLooped = this._model.arrowLoop;
               }
               if(this._model.hintText != Values.EMPTY_STR)
               {
                  this.hintText.setText(this._model.hintText);
                  this.layoutTextAndBg();
               }
            }
            if(isInvalid(InvalidationType.STATE))
            {
               visible = true;
               if(this._model.hasBox)
               {
                  this.hintBox.show();
               }
               if(this._model.hasArrow)
               {
                  this.hintArrow.show();
               }
               if(this._model.hintText != Values.EMPTY_STR)
               {
                  this.hintText.show();
                  this.hintBG.show();
               }
            }
         }
      }
      
      public function fadeIn() : void
      {
         this._tweens.push(new Tween(ANIMATION_DURATION,this,{"alpha":SHOW_ALPHA},{}));
      }
      
      public function fadeOut() : void
      {
         this._tweens.push(new Tween(ANIMATION_DURATION,this,{"alpha":HIDE_ALPHA},{}));
      }
      
      public function hide() : void
      {
         if(this._isHidden)
         {
            return;
         }
         if(this._model.hasArrow)
         {
            if(this.hintArrow.isLooped && !this._model.hideImmediately)
            {
               this.hintArrow.needToHide(true);
               this.hintArrow.addEventListener(TutorialHintEvent.LOOP_ENDED,this.onLoopEndedHandler);
               return;
            }
            this.hintArrow.hide(this._model.hideImmediately);
         }
         if(_baseDisposed)
         {
            return;
         }
         if(this._model.hasBox)
         {
            this.hintBox.hide(this._model.hideImmediately);
         }
         if(this._model.hintText != Values.EMPTY_STR)
         {
            this.hintBG.hide(this._model.hideImmediately);
            this.hintText.hide(this._model.hideImmediately);
         }
         this._isHidden = true;
      }
      
      public function hideTextRuntime(param1:Boolean) : void
      {
         this._hideTextRuntime = param1;
      }
      
      public function show() : void
      {
         this._isHidden = false;
         this._hideTextRuntime = false;
         this.hintBox.alpha = this.hintText.alpha = this.hintBG.alpha = this._textAlpha = 1;
         this.hintArrow.needToHide(false);
         invalidateSize();
         invalidateState();
      }
      
      public function updateRuntime() : void
      {
         var _loc1_:Boolean = false;
         if(this._hideTextRuntime && this._textAlpha > 0)
         {
            this._textAlpha -= TEXT_ALPHA_DECREMENT;
            _loc1_ = true;
         }
         else if(!this._hideTextRuntime && this._textAlpha < 1)
         {
            this._textAlpha += TEXT_ALPHA_DECREMENT;
            _loc1_ = true;
         }
         if(_loc1_)
         {
            this._textAlpha = Math.max(0,Math.min(1,this._textAlpha));
            this.hintBox.alpha = this.hintText.alpha = this.hintBG.alpha = this._textAlpha;
         }
      }
      
      private function removeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function layoutArrow() : void
      {
         var _loc1_:String = Boolean(this._forcedDirection) ? this._forcedDirection : this._model.arrowDir;
         var _loc2_:int = this._hintWidth * this._model.positionValue;
         var _loc3_:int = this._hintHeight * this._model.positionValue;
         switch(_loc1_)
         {
            case Directions.LEFT:
               this.hintArrow.rotation = 0;
               this.hintArrow.x = -this.hintArrow.width + ARROW_OFFSET;
               this.hintArrow.y = _loc3_ - (this.hintArrow.height >> 1);
               break;
            case Directions.RIGHT:
               this.hintArrow.rotation = ROTATE_180;
               this.hintArrow.x = this._hintWidth + this.hintArrow.width - ARROW_OFFSET;
               this.hintArrow.y = _loc3_ + (this.hintArrow.height >> 1);
               break;
            case Directions.TOP:
               this.hintArrow.rotation = ROTATE_90;
               this.hintArrow.x = _loc2_ + (this.hintArrow.width >> 1);
               this.hintArrow.y = -this.hintArrow.height + ARROW_OFFSET;
               break;
            case Directions.BOTTOM:
               this.hintArrow.rotation = -ROTATE_90;
               this.hintArrow.x = _loc2_ - (this.hintArrow.width >> 1);
               this.hintArrow.y = this._hintHeight + this.hintArrow.height - ARROW_OFFSET;
         }
      }
      
      private function layoutTextAndBg() : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:String = TextFormatAlign.LEFT;
         if(!this._model.hasArrow && this._model.hasBox)
         {
            this.hintText.setSize(this.hintBox.width - (TEXT_PADDING << 1));
         }
         var _loc2_:int = this.hintText.width + (TEXT_PADDING << 1) > HINT_BG_MIN_WIDTH ? int(this.hintText.width + (TEXT_PADDING << 1)) : int(HINT_BG_MIN_WIDTH);
         var _loc3_:int = this.hintBG.height;
         this.hintBG.setSize(_loc2_,_loc3_);
         if(!this._model.hasArrow)
         {
            this.hintBG.x = 0;
            this.hintBG.y = -_loc3_ + GLOW_OFFSET;
            this.hintText.x = TEXT_PADDING;
         }
         else
         {
            _loc5_ = Boolean(this._forcedDirection) ? this._forcedDirection : this._model.arrowDir;
            _loc6_ = this._hintWidth * this._model.positionValue;
            _loc7_ = this._hintHeight * this._model.positionValue;
            switch(_loc5_)
            {
               case Directions.LEFT:
                  this.hintBG.x = -_loc2_ - HINT_BG_H_OFFSET - this._model.textPadding;
                  this.hintBG.y = _loc7_ - (_loc3_ >> 1);
                  break;
               case Directions.RIGHT:
                  this.hintBG.x = this._hintWidth + HINT_BG_H_OFFSET + this._model.textPadding;
                  this.hintBG.y = _loc7_ - (_loc3_ >> 1);
                  break;
               case Directions.TOP:
                  this.hintBG.x = _loc6_ - (_loc2_ >> 1);
                  this.hintBG.y = -_loc3_ - HINT_BG_V_OFFSET - this._model.textPadding;
                  break;
               case Directions.BOTTOM:
                  this.hintBG.x = _loc6_ - (_loc2_ >> 1);
                  this.hintBG.y = this._hintHeight + HINT_BG_V_OFFSET + this._model.textPadding;
            }
            _loc1_ = TextFormatAlign.CENTER;
            this.hintText.x = this.hintBG.x + (this.hintBG.width - this.hintText.width >> 1);
         }
         this.hintText.y = this.hintBG.y + (_loc3_ - this.hintText.height >> 1);
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.align = _loc1_;
         this.hintText.setTextAlign(_loc1_);
      }
      
      public function get model() : TutorialHintVO
      {
         return this._model;
      }
      
      public function set model(param1:TutorialHintVO) : void
      {
         this._model = param1;
         invalidateData();
      }
      
      public function set forcedDirection(param1:String) : void
      {
         if(param1 != this._forcedDirection)
         {
            this._forcedDirection = param1;
            invalidateSize();
         }
      }
      
      public function get expectedBorderLeft() : int
      {
         switch(this._model.arrowDir)
         {
            case Directions.LEFT:
               return -this.hintBG.width - HINT_BG_H_OFFSET + (this.hintBG.width - this.hintText.width >> 1);
            case Directions.RIGHT:
               return 0;
            default:
               return -this.hintText.width >> 1;
         }
      }
      
      public function get expectedBorderRight() : int
      {
         switch(this._model.arrowDir)
         {
            case Directions.LEFT:
               return 0;
            case Directions.RIGHT:
               return this._hintWidth + HINT_BG_H_OFFSET + (this.hintBG.width - this.hintText.width >> 1) + this.hintText.width;
            default:
               return this.hintText.width >> 1;
         }
      }
      
      private function get needUpdate() : Boolean
      {
         return 0 < this._textAlpha < 1;
      }
      
      private function onLoopEndedHandler(param1:TutorialHintEvent) : void
      {
         this.hide();
      }
   }
}
