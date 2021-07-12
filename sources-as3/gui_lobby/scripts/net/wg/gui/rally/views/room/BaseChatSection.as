package net.wg.gui.rally.views.room
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IBaseChatSection;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class BaseChatSection extends UIComponentEx implements IFocusContainer, IBaseChatSection
   {
       
      
      public var lblChatHeader:TextField;
      
      public var chatSubmitButton:IButtonIconLoader;
      
      public var channelComponent:ChannelComponent;
      
      protected var _rallyData:IRallyVO;
      
      protected var _previousComment:String = "";
      
      public function BaseChatSection()
      {
         super();
         this.channelComponent.externalButton = this.chatSubmitButton;
         this.channelComponent.messageArea.bgForm.visible = false;
      }
      
      protected static function hideTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lblChatHeader.text = this.getHeader();
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.channelComponent.messageArea.bgForm.alpha = 0;
         this.channelComponent.messageArea.bgForm.visible = false;
         this.channelComponent.addEventListener(Event.CHANGE,this.onHeaderChangeHandler);
         this.chatSubmitButton.tooltip = this.chatSubmitBtnTooltip;
         this.chatSubmitButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ENTERWHITE;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         this.lblChatHeader = null;
         this.chatSubmitButton.dispose();
         this.chatSubmitButton = null;
         this.channelComponent.removeEventListener(Event.CHANGE,this.onHeaderChangeHandler);
         this.channelComponent = null;
         this._rallyData = null;
         super.onDispose();
      }
      
      public function getChannelComponent() : ChannelComponent
      {
         return this.channelComponent;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setDescription(param1:String) : void
      {
      }
      
      protected function getHeader() : String
      {
         return Values.EMPTY_STR;
      }
      
      protected function updateFocus() : void
      {
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }
      
      public function get rallyData() : IRallyVO
      {
         return this._rallyData;
      }
      
      public function set rallyData(param1:IRallyVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._rallyData = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function get chatSubmitBtnTooltip() : String
      {
         return null;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
         {
            param1.handled = true;
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.SHOW_FAQ_WINDOW));
         }
         super.handleInput(param1);
      }
      
      private function onHeaderChangeHandler(param1:Event) : void
      {
         var _loc2_:String = this.getHeader();
         if(_loc2_ != this.lblChatHeader.htmlText)
         {
            this.lblChatHeader.htmlText = _loc2_;
            this.layoutChatHeader();
            invalidateData();
         }
      }
      
      protected function layoutChatHeader() : void
      {
      }
   }
}
