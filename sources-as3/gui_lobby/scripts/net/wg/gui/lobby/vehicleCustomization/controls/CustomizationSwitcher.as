package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.common.counters.CounterView;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationSwitcherRibbon;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSwitcherVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationTabEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationSwitcher extends UIComponentEx
   {
      
      private static const BUTTON_GROUP_NAME:String = "customization_switcher_button_group";
      
      private static const BUTTON_POSITION_SHIFT:int = 24;
      
      private static const COUNTER_POSITION_SHIFT:int = 64;
       
      
      public var customStyleBtn:CustomizationSwitcherButton = null;
      
      public var completeStyleBtn:CustomizationSwitcherButton = null;
      
      public var returnToCompleteStyleBtn:CustomizationSwitcherButton = null;
      
      public var glow:Sprite = null;
      
      public var counter:CounterView = null;
      
      public var ribbon:CustomizationSwitcherRibbon = null;
      
      public var ribbonMask:Sprite = null;
      
      private var _data:CustomizationSwitcherVO = null;
      
      private var _btnGroup:ButtonGroup = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _glowOffset:int = 0;
      
      public function CustomizationSwitcher()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this._btnGroup = ButtonGroup.getGroup(BUTTON_GROUP_NAME,this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._glowOffset = this.glow.width - this.completeStyleBtn.width | 0;
         this.customStyleBtn.groupName = BUTTON_GROUP_NAME;
         this.completeStyleBtn.groupName = BUTTON_GROUP_NAME;
         this.completeStyleBtn.mouseEnabledOnDisabled = true;
         this.completeStyleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCompleteMouseOverHandler);
         this.completeStyleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onCompleteMouseOutHandler);
         this.returnToCompleteStyleBtn.selected = true;
         this.returnToCompleteStyleBtn.focusable = false;
         this.returnToCompleteStyleBtn.addEventListener(ButtonEvent.CLICK,this.onReturnClickHandler);
         this.ribbon.initialize();
         this._btnGroup.addEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         this.glow.mouseEnabled = this.glow.mouseChildren = false;
         this.counter.mouseEnabled = this.counter.mouseChildren = false;
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         this.glow.hitArea = _loc1_;
      }
      
      override protected function onDispose() : void
      {
         this._btnGroup.removeEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         this._btnGroup.dispose();
         this._btnGroup = null;
         this.customStyleBtn.dispose();
         this.customStyleBtn = null;
         this.completeStyleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCompleteMouseOverHandler);
         this.completeStyleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onCompleteMouseOutHandler);
         this.completeStyleBtn.dispose();
         this.completeStyleBtn = null;
         this.returnToCompleteStyleBtn.removeEventListener(ButtonEvent.CLICK,this.onReturnClickHandler);
         this.returnToCompleteStyleBtn.dispose();
         this.returnToCompleteStyleBtn = null;
         this.ribbon.dispose();
         this.ribbon = null;
         this.counter.dispose();
         this.counter = null;
         this.glow = null;
         this.ribbonMask = null;
         this._tooltipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.customStyleBtn.label = this._data.leftLabel;
               this.customStyleBtn.validateNow();
               this.completeStyleBtn.label = this._data.rightLabel;
               this.completeStyleBtn.enabled = this._data.rightEnabled;
               this.completeStyleBtn.validateNow();
               this.returnToCompleteStyleBtn.label = this.completeStyleBtn.label;
               this.returnToCompleteStyleBtn.validateNow();
               this.ribbon.tooltip = this._data.editableTooltip;
               this.ribbon.tooltipEnabled = this._data.isEditable;
               this.layoutButtons();
               this.updateButtons();
               this.updateRibbon();
               this._btnGroup.setSelectedButtonByIndex(this._data.selectedIndex);
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.highlightButton();
               this.layoutCounter();
            }
         }
      }
      
      private function layoutButtons() : void
      {
         this.customStyleBtn.x = -(this.customStyleBtn.width + this.completeStyleBtn.width - BUTTON_POSITION_SHIFT >> 1);
         this.completeStyleBtn.x = this.customStyleBtn.x + this.customStyleBtn.width - BUTTON_POSITION_SHIFT;
         this.returnToCompleteStyleBtn.x = this.completeStyleBtn.x;
         this.ribbonMask.x = this.returnToCompleteStyleBtn.x + this.returnToCompleteStyleBtn.width;
         this.ribbon.x = this.ribbonMask.x;
      }
      
      private function layoutCounter() : void
      {
         var _loc1_:Button = null;
         if(this._data != null)
         {
            _loc1_ = this._btnGroup.selectedIndex == 0 ? this.completeStyleBtn : this.customStyleBtn;
            this.counter.x = _loc1_.x + _loc1_.width - COUNTER_POSITION_SHIFT;
         }
      }
      
      private function highlightButton() : void
      {
         var _loc1_:Button = this._btnGroup.selectedButton;
         if(_loc1_ != null)
         {
            this.glow.width = _loc1_.width + this._glowOffset;
            this.glow.x = _loc1_.x - (this._glowOffset >> 1);
         }
      }
      
      private function updateButtons() : void
      {
         this.returnToCompleteStyleBtn.visible = this._data.isEditable;
         this.completeStyleBtn.visible = !this.returnToCompleteStyleBtn.visible;
      }
      
      private function updateRibbon() : void
      {
         if(this._data.isEditable)
         {
            this.ribbon.fadeIn();
         }
         else
         {
            this.ribbon.fadeOut();
         }
      }
      
      private function dispatch(param1:String, param2:int = -1) : void
      {
         dispatchEvent(new CustomizationTabEvent(param1,param2,true));
      }
      
      private function onButtonGroupChangeHandler(param1:Event) : void
      {
         invalidateLayout();
         this.dispatch(CustomizationTabEvent.TAB_CHANGED,this._btnGroup.selectedIndex);
      }
      
      private function onCompleteMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.completeStyleBtn.enabled)
         {
            this._tooltipMgr.show(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CUSTOMIZATIONTRIGGER_TOOLTIP_NOSTYLE);
         }
      }
      
      private function onCompleteMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onReturnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatch(CustomizationTabEvent.RETURN_TO_COMPLETE_STYLE);
      }
      
      public function setData(param1:CustomizationSwitcherVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setNotificationCounters(param1:int) : void
      {
         this.counter.visible = param1 > 0;
         if(this.counter.visible)
         {
            this.counter.setCount(param1.toString());
         }
      }
      
      public function get isEditableStyles() : Boolean
      {
         return this._data.isEditable;
      }
   }
}
