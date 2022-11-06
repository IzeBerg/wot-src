package net.wg.gui.notification
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.notification.constants.ButtonType;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.ButtonVO;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IBaseLayout;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ServiceMessageContent extends UIComponentEx
   {
      
      private static const BUTTONS_GROUP_OFFSET_Y:int = 10;
      
      private static const MESSAGE_TYPE_ACTION:String = "action";
      
      private static const BMP_FILL_SOURCE_LABEL:String = "BackgroundFill";
      
      private static const BMP_FILL_WIDTH:uint = 100;
      
      private static const BMP_FILL_HEIGHT:uint = 50;
      
      private static const WIDTH:int = 288;
       
      
      public var icon:Image;
      
      public var bgIcon:Image;
      
      public var bmpFill:BitmapFill;
      
      public var textField:TextField;
      
      public var background:MovieClip;
      
      private var _buttonsGroup:Group = null;
      
      private var _data:NotificationInfoVO = null;
      
      private var _isTFClickedByMBR:Boolean = false;
      
      private var _timeComponent:NotificationTimeComponent = null;
      
      private var _classFactory:IClassFactory;
      
      private var _buttonPadding:int = 10;
      
      public function ServiceMessageContent()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.bgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         App.utils.styleSheetManager.setLinkStyle(this.textField);
         this.textField.addEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
         this.textField.addEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.textField.removeEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
         this.textField.removeEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
         this.bgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.icon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.cleanButtonsGroup();
         this.cleanTimeComponent();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this.textField = null;
         this.bmpFill.dispose();
         this.bmpFill = null;
         this.bgIcon.dispose();
         this.bgIcon = null;
         this.icon.dispose();
         this.icon = null;
         this._classFactory = null;
         this._data = null;
         super.onDispose();
      }
      
      public function get data() : NotificationInfoVO
      {
         return this._data;
      }
      
      public function set data(param1:NotificationInfoVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return this.background.height;
      }
      
      protected function updateData() : void
      {
         if(!this._data)
         {
            return;
         }
         this.icon.source = this.messageInfo.icon;
         this.icon.sourceAlt = this.messageInfo.defaultIcon;
         this.bgIcon.source = this.messageInfo.bgIcon;
         this.textField.htmlText = this.messageInfo.message;
         this.setTimeComponent();
         this.setButtonsGroup();
         if(this.messageInfo.type == MESSAGE_TYPE_ACTION)
         {
            this.bmpFill.visible = true;
            this.bmpFill.repeat = BitmapFill.REPEAT_ALL;
            this.bmpFill.startPos = BitmapFill.START_POS_TOP_LEFT;
            this.bmpFill.source = MESSAGE_TYPE_ACTION + BMP_FILL_SOURCE_LABEL;
            this.bmpFill.setSize(BMP_FILL_WIDTH,BMP_FILL_HEIGHT);
         }
         else
         {
            this.bmpFill.visible = false;
         }
         invalidateLayout();
      }
      
      protected function updateLayout() : void
      {
         var _loc7_:int = 0;
         if(this._timeComponent)
         {
            this._timeComponent.y = MessageMetrics.TIME_PADDING_Y;
            this._timeComponent.x = this.width - (this._timeComponent.width + MessageMetrics.TIME_PADDING_X) ^ 0;
         }
         App.utils.commons.updateTextFieldSize(this.textField,false,true);
         var _loc1_:int = this.textField.height;
         var _loc2_:int = this._buttonsGroup != null ? int(this._buttonsGroup.height + BUTTONS_GROUP_OFFSET_Y) : int(0);
         var _loc3_:int = MessageMetrics.SIDES_TOP_PADDING + _loc1_ + _loc2_ + MessageMetrics.SIDES_BOTTOM_PADDING;
         var _loc4_:int = 0;
         if(this.bgIcon.source && this._data.messageVO)
         {
            _loc4_ = !!this._data.messageVO.bgIconSizeAuto ? int(this.bgIcon.height) : int(this._data.messageVO.bgIconHeight);
         }
         var _loc5_:int = Math.max(_loc3_,_loc4_);
         if(_loc5_ != this.background.height)
         {
            this.background.height = _loc5_;
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._buttonsGroup != null)
         {
            this._buttonsGroup.x = this.textField.x;
            this._buttonsGroup.y = _loc1_ + this.textField.y + BUTTONS_GROUP_OFFSET_Y ^ 0;
         }
         if(this.bmpFill.visible)
         {
            _loc7_ = this.bmpFill.y << 1;
            this.bmpFill.setSize(this.background.width - _loc7_ ^ 0,_loc5_ - _loc7_);
         }
         var _loc6_:int = MessageMetrics.ICON_DEFAULT_PADDING_X;
         this.icon.x = _loc6_ + (this.textField.x - _loc6_ - this.icon.width >> 1);
         if(this.textField.textHeight < this.icon.height)
         {
            this.icon.y = this.textField.y + (this.textField.textHeight - this.icon.height >> 1) + MessageMetrics.ICON_DEFAULT_PADDING_Y ^ 0;
         }
      }
      
      protected function get messageInfo() : MessageInfoVO
      {
         return Boolean(this._data) ? this._data.messageVO : null;
      }
      
      protected function get timeComponent() : NotificationTimeComponent
      {
         return this._timeComponent;
      }
      
      protected function get buttonsGroupLayout() : IBaseLayout
      {
         var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc1_.gap = MessageMetrics.BUTTONS_PADDING;
         return _loc1_;
      }
      
      protected function get buttonsGroup() : Group
      {
         return this._buttonsGroup;
      }
      
      private function setButtonsGroup() : void
      {
         var _loc2_:ButtonVO = null;
         this.cleanButtonsGroup();
         if(!this.messageInfo.areButtonsVisible)
         {
            return;
         }
         var _loc1_:Vector.<ButtonVO> = this.messageInfo.buttonsLayout;
         if(_loc1_.length == 0)
         {
            return;
         }
         this._buttonsGroup = new Group();
         this._buttonsGroup.layout = this.buttonsGroupLayout;
         addChild(this._buttonsGroup);
         for each(_loc2_ in _loc1_)
         {
            this.addButton(_loc2_);
         }
         this._buttonsGroup.validateNow();
      }
      
      private function cleanButtonsGroup() : void
      {
         if(this._buttonsGroup == null)
         {
            return;
         }
         var _loc1_:DisplayObject = null;
         var _loc2_:uint = this._buttonsGroup.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._buttonsGroup.getChildAt(_loc3_);
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
            _loc3_++;
         }
         this.removeChild(this._buttonsGroup);
         this._buttonsGroup.dispose();
         this._buttonsGroup = null;
      }
      
      private function addButton(param1:ButtonVO) : void
      {
         var _loc2_:String = ButtonType.getLinkageByType(param1.type);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:SoundButtonEx = this._classFactory.getComponent(_loc2_,SoundButtonEx);
         this._buttonsGroup.addChild(_loc3_);
         _loc3_.name = param1.type;
         _loc3_.data = param1.action;
         _loc3_.width = param1.width;
         _loc3_.label = param1.label;
         _loc3_.tooltip = param1.tooltip;
         _loc3_.dynamicSizeByText = param1.dynamicSizeByText;
         _loc3_.visible = this.messageInfo.isButtonVisible(param1.type);
         _loc3_.enabled = this.messageInfo.isButtonEnabled(param1.type);
         _loc3_.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler,false,0,true);
         _loc3_.mouseEnabledOnDisabled = true;
         _loc3_.focusable = false;
         _loc3_.useHtmlText = true;
         _loc3_.validateNow();
      }
      
      private function setTimeComponent() : void
      {
         this.cleanTimeComponent();
         if(!this.messageInfo.timestampStr)
         {
            return;
         }
         this._timeComponent = this._classFactory.getComponent(Linkages.NOTIFICATION_TIME_COMPONENT,NotificationTimeComponent);
         this._timeComponent.textField.text = this.messageInfo.timestampStr;
         this.addChildAt(this._timeComponent,this.getChildIndex(this.textField) + 1);
      }
      
      private function cleanTimeComponent() : void
      {
         if(this._timeComponent == null)
         {
            return;
         }
         this.removeChild(this._timeComponent);
         this._timeComponent.dispose();
         this._timeComponent = null;
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:SoundButtonEx = param1.target as SoundButtonEx;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ServiceMessageEvent = new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this._data.typeID,this._data.entityID,true);
         _loc3_.action = _loc2_.data as String;
         dispatchEvent(_loc3_);
      }
      
      private function onTextFieldLinkHandler(param1:TextEvent) : void
      {
         if(this._isTFClickedByMBR)
         {
            return;
         }
         var _loc2_:ServiceMessageEvent = new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this._data.typeID,this._data.entityID,true,false,param1.text);
         dispatchEvent(_loc2_);
      }
      
      private function onTextFieldClickHandler(param1:MouseEvent) : void
      {
         this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
