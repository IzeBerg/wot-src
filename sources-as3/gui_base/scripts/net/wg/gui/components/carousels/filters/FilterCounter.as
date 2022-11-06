package net.wg.gui.components.carousels.filters
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.carousels.interfaces.IFilterCounter;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IMovieLabel;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class FilterCounter extends UIComponentEx implements IFilterCounter
   {
      
      private static const COUNT_TEXT_INVALID:String = "count_text_invalid";
      
      private static const SHOW_HIDE_INVALID:String = "show_hide_invalid";
      
      private static const ATTENTION_INVALID:String = "attention_invalid";
      
      private static const GLOW_BLINK_STATE:String = "blink";
      
      private static const GLOW_IDLE_STATE:String = "idle";
      
      private static const ATTENTION_STATE:String = "attention";
      
      private static const FADE_ANIMATION_DURATION:int = 250;
      
      private static const CLOSE_BUTTON_OFFSET:int = 2;
      
      private static const COUNTER_TF_OFFSET:int = 3;
       
      
      public var arrow:MovieClip = null;
      
      public var hitMc:Sprite = null;
      
      public var blinkMc:MovieClip = null;
      
      public var countTFContainer:IMovieLabel = null;
      
      public var closeButton:ButtonIconTextTransparent = null;
      
      private var _countText:String = "";
      
      private var _isShow:Boolean = false;
      
      private var _isAttention:Boolean = false;
      
      private var _lastShow:Boolean = false;
      
      private var _hasCounter:Boolean = true;
      
      private var _hasButton:Boolean = true;
      
      private var _tweens:Vector.<Tween>;
      
      private var _contentAlign:String = "center";
      
      public function FilterCounter()
      {
         super();
         this._tweens = new Vector.<Tween>(0);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.countTFContainer.alpha = 0;
         this.closeButton.alpha = 0;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         if(this.hitMc != null)
         {
            this.hitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMcMouseOverHandler);
            this.hitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onHitMcMouseOutHandler);
         }
         hitArea = this.hitMc;
         this.blinkMc.mouseEnabled = false;
         this.blinkMc.mouseChildren = false;
         this.arrow.mouseEnabled = false;
         this.arrow.mouseChildren = false;
         this.arrow.alpha = 0;
         this.countTFContainer.mouseEnabled = false;
         this.countTFContainer.mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isShow != this._lastShow && isInvalid(SHOW_HIDE_INVALID))
         {
            this.disposeTweens();
            if(this._isShow)
            {
               this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.closeButton,{"alpha":1},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.arrow,{"alpha":1},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.countTFContainer,{"alpha":1},{"fastTransform":false}));
            }
            else
            {
               this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.closeButton,{"alpha":0},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.arrow,{"alpha":0},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.countTFContainer,{"alpha":0},{"fastTransform":false}));
            }
            this._lastShow = this._isShow;
            invalidateState();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.closeButton.visible = this._hasButton;
            this.countTFContainer.visible = this._hasCounter;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.updateState();
         }
         if(this._hasCounter)
         {
            if(isInvalid(ATTENTION_INVALID))
            {
               if(this._isAttention)
               {
                  this.countTFContainer.gotoAndPlay(ATTENTION_STATE);
               }
               else
               {
                  this.countTFContainer.gotoAndStop(ATTENTION_STATE);
               }
            }
            if(StringUtils.isNotEmpty(this._countText) && isInvalid(COUNT_TEXT_INVALID))
            {
               this.countTFContainer.text = this._countText;
               if(this._contentAlign == AlignType.CENTER)
               {
                  this.countTFContainer.x = this.arrow.x + (this.arrow.width - this.countTFContainer.width >> 1) + COUNTER_TF_OFFSET;
                  this.closeButton.x = this.countTFContainer.x + this.countTFContainer.width + CLOSE_BUTTON_OFFSET;
               }
               else if(this._contentAlign == AlignType.LEFT)
               {
                  this.countTFContainer.x = 0;
                  this.arrow.x = this.countTFContainer.x - (this.arrow.width - this.countTFContainer.width >> 1) - COUNTER_TF_OFFSET;
                  this.closeButton.x = this.countTFContainer.x + this.countTFContainer.width + CLOSE_BUTTON_OFFSET;
               }
               if(this.hitMc)
               {
                  this.hitMc.x = this.countTFContainer.x;
                  this.hitMc.width = this.countTFContainer.width + CLOSE_BUTTON_OFFSET + this.closeButton.width;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeTweens();
         this._tweens = null;
         if(this.hitMc != null)
         {
            this.hitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMcMouseOverHandler);
            this.hitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMcMouseOutHandler);
            this.hitMc = null;
         }
         this.arrow = null;
         this.blinkMc = null;
         this.countTFContainer.dispose();
         this.countTFContainer = null;
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         super.onDispose();
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      public function blink() : void
      {
         if(this._isShow)
         {
            this.blinkMc.gotoAndPlay(GLOW_BLINK_STATE);
         }
      }
      
      public function hide() : void
      {
         this._isShow = false;
         if(this._isShow != this._lastShow)
         {
            this.blinkMc.gotoAndStop(GLOW_IDLE_STATE);
            invalidate(SHOW_HIDE_INVALID);
         }
      }
      
      public function setCloseButtonTooltip(param1:String) : void
      {
         this.closeButton.tooltip = param1;
      }
      
      public function setCount(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         if(this._countText != param1)
         {
            this._countText = param1;
            invalidate(COUNT_TEXT_INVALID);
         }
         if(this._isAttention != param2)
         {
            this._isAttention = param2;
            invalidate(ATTENTION_INVALID);
         }
         this._isShow = param3;
         if(this._isShow != this._lastShow)
         {
            invalidate(SHOW_HIDE_INVALID);
         }
      }
      
      private function updateState() : void
      {
         if(this.hitMc != null)
         {
            this.hitMc.mouseEnabled = this._isShow;
         }
         if(this._hasButton)
         {
            this.closeButton.enabled = this._isShow;
         }
      }
      
      public function get hasCounter() : Boolean
      {
         return this._hasCounter;
      }
      
      public function set hasCounter(param1:Boolean) : void
      {
         if(param1 != this._hasCounter)
         {
            this._hasCounter = param1;
            invalidateData();
         }
      }
      
      public function set contentAlign(param1:String) : void
      {
         if(param1 != this._contentAlign)
         {
            this._contentAlign = param1;
         }
      }
      
      public function get hasButton() : Boolean
      {
         return this._hasButton;
      }
      
      public function set hasButton(param1:Boolean) : void
      {
         if(param1 != this._hasButton)
         {
            this._hasButton = param1;
            invalidateData();
         }
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         this.hide();
         dispatchEvent(new FiltersEvent(FiltersEvent.RESET_ALL_FILTERS,0,true));
      }
      
      private function onHitMcMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._isShow)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_FILTER,null);
         }
      }
      
      private function onHitMcMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
