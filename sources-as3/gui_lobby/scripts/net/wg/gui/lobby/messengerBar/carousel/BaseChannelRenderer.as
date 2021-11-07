package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   public class BaseChannelRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const PROGRESS_INDICATOR_PADDING:uint = 13;
       
      
      public var openButton:ChannelButton = null;
      
      public var progressIndicator:MovieClip = null;
      
      private var _data:ChannelListItemVO = null;
      
      private var _index:uint = 0;
      
      private var _selectable:Boolean = true;
      
      private var _owner:UIComponent = null;
      
      public function BaseChannelRenderer()
      {
         super();
      }
      
      protected static function get DEFAULT_TF_PADDING() : Padding
      {
         return new Padding(3,5,3,5);
      }
      
      override protected function preInitialize() : void
      {
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.progressIndicator.x = _width - PROGRESS_INDICATOR_PADDING;
         }
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.applyData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressIndicator.mouseChildren = false;
         this.progressIndicator.mouseEnabled = false;
         this.progressIndicator.visible = false;
         addEventListener(MouseEvent.CLICK,this.handleMouseRelease);
         this.openButton.addEventListener(ButtonEvent.CLICK,this.onItemOpen);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.handleMouseRelease);
         this.openButton.removeEventListener(ButtonEvent.CLICK,this.onItemOpen);
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
         this.openButton.dispose();
         this.openButton = null;
         this.progressIndicator = null;
         this._owner = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1)
         {
            this._data = new ChannelListItemVO(param1);
            invalidateData();
         }
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
         this.openButton.label = param1.label || "";
      }
      
      protected function applyData() : void
      {
         this.openButton.label = this._data.label;
         this.openButton.blinking = this._data.isNotified;
         this.openButton.selected = this._data.isWindowOpened;
         this.openButton.selectedFocused = this._data.isWindowFocused;
         this.openButton.setTooltipData(this._data.tooltipDataVO);
         this.progressIndicator.visible = this._data.isInProgress;
         visible = true;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function get selected() : Boolean
      {
         return this.openButton.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.openButton.selected = param1;
      }
      
      protected function get channelListData() : ChannelListItemVO
      {
         return this._data;
      }
      
      protected function handleMouseRelease(param1:MouseEvent) : void
      {
      }
      
      protected function onItemCloseClickHandler(param1:ButtonEvent = null) : void
      {
         dispatchEvent(new ChannelListEvent(ChannelListEvent.CLOSE_CHANNEL,this._data.clientID,true));
      }
      
      private function onItemOpen(param1:ButtonEvent = null) : void
      {
         dispatchEvent(new ChannelListEvent(ChannelListEvent.OPEN_CHANNEL,this._data.clientID,true));
      }
   }
}
