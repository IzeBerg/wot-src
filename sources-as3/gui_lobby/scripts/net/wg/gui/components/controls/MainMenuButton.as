package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.Aliases;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.gfx.TextFieldEx;
   
   public class MainMenuButton extends SoundButtonEx
   {
      
      public static var SUB_SELECTED:String = "sub_selected_";
      
      private static const INVALIDATE_ICON:String = "invalidateIcon";
      
      private static const INVALIDATE_CAPS:String = "invalidateCaps";
      
      private static const INVALIDATE_PADDING:String = "invalidatePadding";
      
      private static const INVALIDATE_TEXT_COLOR:String = "invalidateTextColor";
      
      private static const INVALIDATE_TEXT_SIZE:String = "invalidateTextSize";
      
      private static const INVALIDATE_ACTION_ICON:String = "invalidateActionIcon";
      
      private static const INVALIDATE_ACTION_ICON_POS:String = "invalidateActionIconPos";
      
      private static const ICON_PADDING:int = 1;
      
      private static const TEXTFIELD_NAME:String = "textField";
      
      private static const BLUR_TEXTFIELD_NAME:String = "blurTextField";
      
      private static const TEXTFIELD_PADDING:int = 5;
      
      private static const BROWSER:String = "browser";
      
      private static const CHANGE_EFFECT_TIME:int = 1000;
      
      private static const BLINK_TEXT_COLOR:uint = 16563563;
       
      
      public var fxTextField1:TextField;
      
      public var fxTextField2:TextField;
      
      public var fx:MovieClip;
      
      public var icon:Image;
      
      public var actionIcon:Image;
      
      public var highlight:MainMenuButtonHighlight;
      
      private var _textFormat:TextFormat;
      
      private var _iconType:String;
      
      private var _iconOffset:int = 0;
      
      private var _externalSize:uint = 1;
      
      private var _iconY:int;
      
      private var _caps:Boolean = true;
      
      private var _textColorOver:Number;
      
      private var _textColorBeforeBlink:Number;
      
      private var _externalState:String = "";
      
      private var _isBlinking:Boolean;
      
      private var _actionIconStr:String = "";
      
      private var _commonsUtils:ICommons;
      
      private var _isTooltipSpecial:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function MainMenuButton()
      {
         this._textFormat = new TextFormat();
         this._iconY = MainMenuButtonSize.ICON_Y[MainMenuButtonSize.REGULAR];
         this._commonsUtils = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
         super();
         constraintsDisabled = true;
         soundType = SoundTypes.MAIN_MENU;
         this.fxTextField2 = this.fx.fxTextField2;
         preventAutosizing = true;
      }
      
      private static function updateTextFormat(param1:TextField, param2:TextFormat) : void
      {
         if(param1)
         {
            param1.defaultTextFormat = param2;
            param1.setTextFormat(param2);
            TextFieldEx.setVerticalAlign(param1,TextFieldEx.VALIGN_CENTER);
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.changeEffectState);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.actionIcon.removeEventListener(Event.CHANGE,this.onActionIconChangeHandler);
         this.fxTextField1 = null;
         this.fxTextField2 = null;
         this.fx = null;
         this.icon.dispose();
         this.icon = null;
         this.actionIcon.dispose();
         this.actionIcon = null;
         this.highlight = null;
         this._textFormat = null;
         this._commonsUtils = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.paddingHorizontal = 0;
         this.highlight.mouseChildren = this.highlight.mouseEnabled = false;
         this.highlight.visible = false;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.actionIcon.addEventListener(Event.CHANGE,this.onActionIconChangeHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.checkBrowserEffect();
      }
      
      override protected function updateText() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         if(hitMc)
         {
            hitMc.width = 1;
         }
         if(this.caps)
         {
            if(_label != null)
            {
               _loc1_ = App.utils.locale.makeString(_label,{});
               if(StringUtils.isNotEmpty(_loc1_))
               {
                  _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
               }
               else
               {
                  _loc1_ = Values.EMPTY_STR;
               }
               if(textField != null)
               {
                  textField.text = _loc1_;
               }
               if(textField1 != null)
               {
                  textField1.text = _loc1_;
               }
               if(blurTextField != null)
               {
                  blurTextField.text = _loc1_;
                  this._commonsUtils.updateTextFieldSize(blurTextField,true,false);
               }
               if(this.fxTextField1 != null)
               {
                  this.fxTextField1.text = _loc1_;
                  this._commonsUtils.updateTextFieldSize(this.fxTextField1,true,false);
               }
               if(this.fxTextField2 != null)
               {
                  this.fxTextField2.text = _loc1_;
                  this._commonsUtils.updateTextFieldSize(this.fxTextField2,true,false);
               }
            }
         }
         else
         {
            super.updateText();
            if(blurTextField != null)
            {
               blurTextField.text = _label;
            }
            if(this.fxTextField1 != null)
            {
               this.fxTextField1.text = _label;
            }
            if(this.fxTextField2 != null)
            {
               this.fxTextField2.text = _label;
            }
         }
         if(hitMc)
         {
            _loc2_ = this.fx.width + this.icon.width;
            hitMc.width = _loc2_;
            this.width = _loc2_;
         }
         else
         {
            this.width = this.actualWidth;
         }
      }
      
      override protected function alignForAutoSize() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!initialized || !textField || _autoSize == TextFieldAutoSize.NONE)
         {
            return;
         }
         _loc1_ = _width;
         var _loc2_:int = _width = this.calculateWidth();
         switch(_autoSize)
         {
            case TextFieldAutoSize.RIGHT:
               _loc3_ = x + _loc1_;
               x = _loc3_ - _loc2_;
               break;
            case TextFieldAutoSize.CENTER:
               _loc4_ = x + (_loc1_ >> 1);
               x = _loc4_ - (_loc2_ >> 1);
         }
      }
      
      override protected function calculateWidth() : Number
      {
         var _loc2_:ConstrainedElement = null;
         var _loc3_:TextField = null;
         var _loc1_:Number = actualWidth;
         if(!constraintsDisabled && initialized)
         {
            _loc2_ = constraints.getElement(Boolean(textField) ? TEXTFIELD_NAME : BLUR_TEXTFIELD_NAME);
            _loc3_ = Boolean(textField) ? textField : blurTextField;
            _loc1_ = _loc3_.x + _loc3_.textWidth + _loc2_.left + _loc2_.right + TEXTFIELD_PADDING + (_paddingHorizontal << 1);
         }
         return _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this.fxTextField1 && isInvalid(InvalidationType.STATE,INVALIDATE_CAPS,INVALIDATE_PADDING,INVALIDATE_TEXT_COLOR,INVALIDATE_TEXT_SIZE))
         {
            if(this._textColorOver && !selected && state == ComponentState.OVER)
            {
               this.fxTextField1.textColor = this._textColorOver;
            }
            else if(_textColor && enabled)
            {
               this.fxTextField1.textColor = _textColor;
            }
            if(this._iconType)
            {
               this._iconOffset = this.icon.x + this.icon.width + ICON_PADDING | 0;
               this.fxTextField1.x = this._iconOffset;
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               this.fxTextField1.x = 0;
            }
            updateTextFormat(this.fxTextField1,this._textFormat);
            updateTextFormat(this.fxTextField2,this._textFormat);
            this.updateText();
            this.highlight.x = this.fxTextField1.textWidth >> 1;
            this.icon.y = this._iconY;
         }
         if(isInvalid(INVALIDATE_ICON))
         {
            this.icon.visible = StringUtils.isNotEmpty(this._iconType);
            this.icon.source = this._iconType;
         }
         if(isInvalid(INVALIDATE_ACTION_ICON))
         {
            this.actionIcon.visible = StringUtils.isNotEmpty(this._actionIconStr);
            this.actionIcon.source = this._actionIconStr;
            invalidate(INVALIDATE_ACTION_ICON_POS);
         }
         if(isInvalid(INVALIDATE_ACTION_ICON_POS))
         {
            _loc1_ = Boolean(this._iconType) ? int(this.icon.x) : int(this.fxTextField1.x);
            _loc2_ = Boolean(this._iconType) ? int(_loc1_ + this.icon.width + ICON_PADDING + this.fxTextField1.width) : int(this.fxTextField1.width);
            this.actionIcon.x = _loc1_ + (_loc2_ - this.actionIcon.width >> 1);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         return !!_selected ? statesSelected : (this._externalState != Values.EMPTY_STR ? Vector.<String>([this._externalState]) : statesDefault);
      }
      
      override protected function showTooltip() : void
      {
         if(this._isTooltipSpecial && _tooltip)
         {
            this._tooltipMgr.showSpecial(_tooltip,null);
         }
         else
         {
            super.showTooltip();
         }
      }
      
      public function setExternalSize(param1:uint) : void
      {
         this._externalSize = param1;
         this._textFormat.size = MainMenuButtonSize.TEXT_SIZE[param1];
         this._iconY = MainMenuButtonSize.ICON_Y[param1];
         this.highlight.setSize(param1);
         invalidate(INVALIDATE_TEXT_SIZE);
         invalidate(INVALIDATE_ACTION_ICON_POS);
      }
      
      public function setExternalState(param1:String) : void
      {
         this._externalState = param1;
         setState(state);
      }
      
      private function checkBrowserEffect() : void
      {
         if(data && data.value == BROWSER)
         {
            App.utils.scheduler.scheduleTask(this.changeEffectState,CHANGE_EFFECT_TIME);
            selected = false;
         }
      }
      
      private function changeEffectState() : void
      {
         if(selected || !enabled)
         {
            filters = null;
            this._isBlinking = false;
            return;
         }
         if(this.fxTextField1)
         {
            if(isNaN(this._textColorBeforeBlink))
            {
               this._textColorBeforeBlink = this.fxTextField1.textColor;
            }
            this._isBlinking = !this._isBlinking;
            if(this._isBlinking)
            {
               this.fxTextField1.textColor = BLINK_TEXT_COLOR;
            }
            else
            {
               this.fxTextField1.textColor = this._textColorBeforeBlink;
            }
            App.utils.scheduler.scheduleTask(this.changeEffectState,CHANGE_EFFECT_TIME);
         }
      }
      
      override public function get height() : Number
      {
         if(this.fxTextField1)
         {
            return this.fxTextField1.height + MainMenuButtonSize.HEIGHT_PADDING[this._externalSize];
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         return Boolean(this.fxTextField1) ? Number(this.fxTextField1.x + this.fxTextField1.textWidth + TEXTFIELD_PADDING + (_paddingHorizontal << 1)) : Number(0);
      }
      
      override public function get paddingHorizontal() : Number
      {
         return _paddingHorizontal;
      }
      
      override public function set paddingHorizontal(param1:Number) : void
      {
         _paddingHorizontal = param1;
         invalidate(INVALIDATE_PADDING);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(param1)
         {
            this.checkBrowserEffect();
         }
      }
      
      public function set isHighlighted(param1:Boolean) : void
      {
         this.highlight.visible = param1;
      }
      
      public function set isTooltipSpecial(param1:Boolean) : void
      {
         this._isTooltipSpecial = param1;
      }
      
      [Inspectable(defaultValue="true",name="caps",type="Boolean")]
      public function get caps() : Boolean
      {
         return this._caps;
      }
      
      public function set caps(param1:Boolean) : void
      {
         if(this._caps == param1)
         {
            return;
         }
         this._caps = param1;
         invalidate(INVALIDATE_CAPS);
      }
      
      public function get textColorOver() : Number
      {
         return _textColor;
      }
      
      public function set textColorOver(param1:Number) : void
      {
         if(this._textColorOver == param1)
         {
            return;
         }
         this._textColorOver = param1;
         invalidate(INVALIDATE_TEXT_COLOR);
      }
      
      public function get iconType() : String
      {
         return this._iconType;
      }
      
      public function set iconType(param1:String) : void
      {
         if(this._iconType == param1)
         {
            return;
         }
         this._iconType = param1;
         invalidate(INVALIDATE_ICON);
         if(this.fxTextField1 && StringUtils.isNotEmpty(this._iconType))
         {
            this.fxTextField1.x = this._iconOffset;
         }
         else
         {
            this.fxTextField1.x = 0;
         }
      }
      
      public function set actionIconStr(param1:String) : void
      {
         if(this._actionIconStr == param1)
         {
            return;
         }
         this._actionIconStr = param1;
         invalidate(INVALIDATE_ACTION_ICON);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(data && data.value == Aliases.BROWSER)
         {
            App.utils.scheduler.cancelTask(this.changeEffectState);
            filters = null;
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.checkBrowserEffect();
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateState();
      }
      
      private function onActionIconChangeHandler(param1:Event) : void
      {
         invalidate(INVALIDATE_ACTION_ICON_POS);
      }
   }
}
