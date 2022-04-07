package net.wg.gui.notification
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.notification.constants.ButtonType;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.ButtonVO;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class ServiceMessage extends UIComponentEx
   {
      
      private static const DATA_INVALID:String = "dataInv";
      
      private static const LAYOUT_INVALID:String = "layoutInv";
      
      private static const TIMESTAMP_INVALID:String = "tsInv";
      
      private static const BMP_FILL_WIDTH:uint = 100;
      
      private static const BMP_FILL_HEIGHT:uint = 50;
      
      private static const BMP_FILL_SOURCE_LABEL:String = "BackgroundFill";
      
      private static const BMP_FILL_START_POS:String = "TL";
      
      private static const BMP_FILL_REPEAT:String = "all";
      
      private static const MSG_TYPE_ACTION:String = "action";
      
      private static const CANT_CREATE_BUTTON:String = "Can\'t create button";
       
      
      public var background:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var bgIcon:UILoaderAlt;
      
      public var bmpFill:BitmapFill;
      
      public var textField:TextField;
      
      private var _isTFClickedByMBR:Boolean = false;
      
      private var _timeComponent:NotificationTimeComponent;
      
      private var _messageTopOffset:int = 17;
      
      private var _messageBottomOffset:int = 18;
      
      private var _buttonPadding:int = 10;
      
      private var _data:NotificationInfoVO;
      
      private var _buttonsGroup:Group;
      
      private var _timeStamp:String = "";
      
      private var _classFactory:IClassFactory;
      
      public function ServiceMessage()
      {
         this._classFactory = App.utils.classFactory;
         super();
         _deferredDispose = true;
      }
      
      private static function updateButton(param1:SoundButtonEx, param2:ButtonVO, param3:MessageInfoVO) : void
      {
         var _loc4_:String = param2.type;
         param1.name = _loc4_;
         param1.dynamicSizeByText = param2.dynamicSizeByText;
         param1.width = param2.width;
         param1.label = param2.label;
         param1.data = param2.action;
         param1.tooltip = param2.tooltip;
         param1.mouseEnabledOnDisabled = true;
         param1.enabled = param3.isButtonEnabled(_loc4_);
         param1.visible = param3.isButtonVisible(_loc4_);
         param1.validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _focusable = tabEnabled = false;
         App.utils.styleSheetManager.setLinkStyle(this.textField);
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = true;
         this.textField.wordWrap = true;
         this.textField.selectable = true;
         this.background.tabEnabled = false;
         this.textField.addEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
         this.textField.addEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
         this.bgIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.bgIcon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(DATA_INVALID))
         {
            this.invalidateMessageData();
         }
         if(isInvalid(TIMESTAMP_INVALID))
         {
            this.invalidateTimestamp();
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.updateLayout();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.textField.removeEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
         this.textField.removeEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.removeEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
         this.bgIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.bgIcon.removeEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.bgIcon.dispose();
         this.bgIcon = null;
         this.bmpFill.dispose();
         this.bmpFill = null;
         this.removeButtonsGroup();
         if(this._timeComponent != null)
         {
            removeChild(this._timeComponent);
            this._timeComponent.dispose();
            this._timeComponent = null;
         }
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
         this.textField = null;
         this.background = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      private function createButtonsGroup(param1:MessageInfoVO) : void
      {
         if(!param1.areButtonsVisible())
         {
            return;
         }
         var _loc2_:Vector.<ButtonVO> = param1.buttonsLayout;
         var _loc3_:uint = _loc2_.length;
         if(_loc3_ == 0)
         {
            return;
         }
         this._buttonsGroup = new Group();
         var _loc4_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc4_.gap = MessageMetrics.BUTTONS_PADDING;
         this._buttonsGroup.layout = _loc4_;
         this._buttonsGroup.x = this.textField.x;
         addChild(this._buttonsGroup);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            this.createButton(_loc2_[_loc5_],param1);
            _loc5_++;
         }
         this._buttonsGroup.validateNow();
      }
      
      private function createButton(param1:ButtonVO, param2:MessageInfoVO) : void
      {
         var _loc3_:String = ButtonType.getLinkageByType(param1.type);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:SoundButtonEx = this._classFactory.getComponent(_loc3_,SoundButtonEx);
         if(_loc4_ == null)
         {
            DebugUtils.LOG_ERROR(CANT_CREATE_BUTTON,_loc3_);
            return;
         }
         this._buttonsGroup.addChild(_loc4_);
         _loc4_.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler,false,0,true);
         _loc4_.focusable = false;
         updateButton(_loc4_,param1,param2);
      }
      
      private function invalidateTimestamp() : void
      {
         if(this._timeComponent == null && StringUtils.isNotEmpty(this._timeStamp))
         {
            this._timeComponent = NotificationTimeComponent(this._classFactory.getComponent(Linkages.NOTIFICATION_TIME_COMPONENT,NotificationTimeComponent));
            addChildAt(this._timeComponent,getChildIndex(this.textField) + 1);
         }
         if(this._timeComponent != null)
         {
            this._timeComponent.textField.text = this._timeStamp != null ? this._timeStamp : Values.EMPTY_STR;
            invalidate(LAYOUT_INVALID);
         }
      }
      
      private function invalidateMessageData() : void
      {
         var _loc1_:MessageInfoVO = null;
         var _loc2_:String = null;
         if(this._data != null)
         {
            _loc1_ = this._data.messageVO;
            this.textField.htmlText = _loc1_.message;
            _loc2_ = _loc1_.type;
            this.icon.visible = this.icon.source == _loc1_.icon;
            if(StringUtils.isNotEmpty(_loc1_.icon))
            {
               this.icon.source = _loc1_.icon;
            }
            this.bgIcon.visible = false;
            if(StringUtils.isNotEmpty(_loc1_.bgIcon))
            {
               this.bgIcon.source = _loc1_.bgIcon;
            }
            if(StringUtils.isNotEmpty(_loc1_.defaultIcon))
            {
               this.icon.sourceAlt = _loc1_.defaultIcon;
            }
            if(_loc2_ != null && _loc2_ == MSG_TYPE_ACTION)
            {
               this.bmpFill.visible = true;
               this.bmpFill.repeat = BMP_FILL_REPEAT;
               this.bmpFill.startPos = BMP_FILL_START_POS;
               this.bmpFill.source = _loc2_ + BMP_FILL_SOURCE_LABEL;
               this.bmpFill.setSize(BMP_FILL_WIDTH,BMP_FILL_HEIGHT);
            }
            else
            {
               this.bmpFill.visible = false;
            }
            this.timeStamp = _loc1_.timestampStr;
            if(!this._buttonsGroup)
            {
               this.createButtonsGroup(_loc1_);
            }
            else
            {
               this.updateButtonsGroup(_loc1_);
            }
            invalidate(LAYOUT_INVALID);
         }
      }
      
      private function updateLayout() : void
      {
         var _loc7_:int = 0;
         if(this._timeComponent)
         {
            this._timeComponent.y = MessageMetrics.TIME_PADDING_Y;
            this._timeComponent.x = this.width - (this._timeComponent.width + MessageMetrics.TIME_PADDING_X) ^ 0;
         }
         var _loc1_:int = 0;
         if(this._buttonsGroup != null)
         {
            _loc1_ = this._buttonsGroup.height + this._buttonPadding;
         }
         var _loc2_:int = this.textField.height;
         var _loc3_:int = _loc2_ + this._messageBottomOffset + this._messageTopOffset + _loc1_;
         var _loc4_:int = 0;
         if(StringUtils.isNotEmpty(this.bgIcon.source) && this._data.messageVO)
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
            this._buttonsGroup.y = _loc2_ + this.textField.y + this._buttonPadding ^ 0;
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
      
      private function updateButtonsGroup(param1:MessageInfoVO) : void
      {
         var _loc2_:int = 0;
         var _loc6_:ButtonVO = null;
         var _loc7_:SoundButtonEx = null;
         if(!param1.areButtonsVisible())
         {
            this.removeButtonsGroup();
            return;
         }
         var _loc3_:int = this._buttonsGroup.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this._buttonsGroup.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
         var _loc4_:Vector.<ButtonVO> = param1.buttonsLayout;
         var _loc5_:uint = _loc4_.length;
         if(_loc5_ == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc6_ = _loc4_[_loc2_];
            _loc7_ = SoundButtonEx(this._buttonsGroup.getChildByName(_loc6_.type));
            if(_loc7_ != null)
            {
               updateButton(_loc7_,_loc6_,param1);
            }
            else
            {
               this.createButton(_loc6_,param1);
            }
            _loc2_++;
         }
      }
      
      private function removeButtonsGroup() : void
      {
         var _loc1_:Object = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         if(this._buttonsGroup != null)
         {
            _loc2_ = this._buttonsGroup.numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = this._buttonsGroup.getChildAt(_loc3_);
               _loc1_.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
               _loc3_++;
            }
            this._buttonsGroup.dispose();
            this._buttonsGroup = null;
         }
      }
      
      override public function get height() : Number
      {
         return this.background.height;
      }
      
      override public function get width() : Number
      {
         return Math.ceil(actualWidth);
      }
      
      [Inspectable(defaultValue="3",name="messageTopOffset",type="Number")]
      public function get messageTopOffset() : Number
      {
         return this._messageTopOffset;
      }
      
      public function set messageTopOffset(param1:Number) : void
      {
         this._messageTopOffset = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      [Inspectable(defaultValue="20",name="messageBottomOffset",type="Number")]
      public function get messageBottomOffset() : Number
      {
         return this._messageBottomOffset;
      }
      
      public function set messageBottomOffset(param1:Number) : void
      {
         this._messageBottomOffset = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      [Inspectable(defaultValue="10",name="buttonPadding",type="Number")]
      public function get buttonPadding() : int
      {
         return this._buttonPadding;
      }
      
      public function set buttonPadding(param1:int) : void
      {
         this._buttonPadding = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1 as NotificationInfoVO;
         App.utils.asserter.assertNotNull(this._data,Errors.INVALID_TYPE + "NotificationInfoVO.");
         invalidate(DATA_INVALID);
      }
      
      public function get buttonsGroup() : Group
      {
         return this._buttonsGroup;
      }
      
      public function get timeStamp() : String
      {
         return this._timeStamp;
      }
      
      public function set timeStamp(param1:String) : void
      {
         if(this._timeStamp != param1)
         {
            this._timeStamp = param1;
            invalidate(TIMESTAMP_INVALID);
         }
      }
      
      private function onTextFieldLinkHandler(param1:TextEvent) : void
      {
         if(!this._isTFClickedByMBR)
         {
            dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this._data.typeID,this._data.entityID,true,false,param1.text));
         }
      }
      
      private function onTextFieldClickHandler(param1:MouseEvent) : void
      {
         this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
      }
      
      private function onIconIoerrorHandler(param1:UILoaderEvent) : void
      {
         DisplayObject(param1.currentTarget).visible = false;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         DisplayObject(param1.currentTarget).visible = true;
         invalidate(LAYOUT_INVALID);
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:ServiceMessageEvent = new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this._data.typeID,this._data.entityID,true);
         _loc2_.action = param1.target.data;
         dispatchEvent(_loc2_);
      }
   }
}
