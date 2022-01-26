package net.wg.gui.notification
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.CounterView;
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.notification.constants.ButtonType;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.ButtonVO;
   import net.wg.gui.notification.vo.LunarNYMessageSettings;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NYMessageSettings;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IUtils;
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
      
      private static const MSG_TYPE_NY_BOXES:String = "nyBoxes";
      
      private static const MSG_TYPE_WINTER_OFFER:String = "winterOffer";
      
      private static const CANT_CREATE_BUTTON:String = "Can\'t create button";
      
      private static const MSG_TYPE_LUNAR_NY_BOXES:String = "lunarNY";
      
      private static const LUNAR_NY_COUNTER_NAME:String = "lunarNYCounter";
      
      private static const NY_COUNTER_NAME:String = "nyCounter";
      
      private static const BTN_GROUP_NAME:String = "btnGroup";
      
      private static const CUSTOM_BG_NAME:String = "customBg";
       
      
      public var background:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var bgIcon:UILoaderAlt;
      
      public var bmpFill:BitmapFill;
      
      public var textField:TextField;
      
      protected var _lunarNYSettings:LunarNYMessageSettings;
      
      protected var _utils:IUtils;
      
      protected var _lunarNYBg:MovieClip = null;
      
      protected var _classFactory:IClassFactory;
      
      protected var _isLunarNYMessage:Boolean = false;
      
      private var _lunarNYCounter:CounterView = null;
      
      private var _alertIcon:Image = null;
      
      private var _nyCounter:CounterView = null;
      
      private var _customBg:MovieClip = null;
      
      private var _isTFClickedByMBR:Boolean = false;
      
      private var _timeComponent:NotificationTimeComponent;
      
      private var _messageTopOffset:int = 17;
      
      private var _messageBottomOffset:int = 18;
      
      private var _buttonPadding:int = 10;
      
      private var _data:NotificationInfoVO;
      
      private var _buttonsGroup:Group;
      
      private var _timeStamp:String = "";
      
      private var _textDefaultX:int = -1;
      
      private var _textDefaultY:int = -1;
      
      private var _textDefaultW:int = -1;
      
      private var _iconDefaultY:int = -1;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isNYMessage:Boolean = false;
      
      private var _customMessageSettings:NYMessageSettings = null;
      
      public function ServiceMessage()
      {
         this._utils = App.utils;
         this._classFactory = this._utils.classFactory;
         this._tooltipMgr = App.toolTipMgr;
         super();
         _deferredDispose = true;
      }
      
      private static function updateButton(param1:SoundButtonEx, param2:ButtonVO, param3:MessageInfoVO) : void
      {
         var _loc4_:String = null;
         _loc4_ = param2.type;
         param1.name = _loc4_;
         param1.dynamicSizeByText = param2.dynamicSizeByText;
         param1.width = param2.width;
         param1.label = param2.label;
         param1.data = param2.action;
         param1.enabled = param3.isButtonEnabled(_loc4_);
         param1.visible = param3.isButtonVisible(_loc4_);
         param1.tooltip = param2.tooltip;
         param1.mouseEnabledOnDisabled = true;
         param1.validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._textDefaultX = this.textField.x;
         this._textDefaultY = this.textField.y;
         this._textDefaultW = this.textField.width;
         this._iconDefaultY = this.icon.y;
         _focusable = tabEnabled = false;
         this._utils.styleSheetManager.setLinkStyle(this.textField);
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = true;
         this.textField.wordWrap = true;
         this.textField.selectable = true;
         this.background.tabEnabled = false;
         this.textField.addEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
         this.textField.addEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
         this.icon.mouseChildren = this.icon.mouseEnabled = false;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
         this.bgIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.bgIcon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
         this._lunarNYSettings = new LunarNYMessageSettings(55,-28,180,180,19,141,250,0,170,90,12,-160,-140,Linkages.LUNAR_NY_NO_BORDER_NOTIFICATION_BG_UI,Linkages.LUNAR_NY_COUNTER_VIEW_UI,Linkages.LUNAR_NY_NOTIFICATION_HIT_UI);
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
         if(this._alertIcon)
         {
            this._alertIcon.removeEventListener(Event.CHANGE,this.onAlertIconChangeHandler);
            this._alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler);
            this._alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler);
            this._alertIcon.dispose();
            this._alertIcon = null;
         }
         if(this._customMessageSettings)
         {
            this._customMessageSettings = null;
         }
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
         this._utils = null;
         this._tooltipMgr = null;
         this._classFactory = null;
         if(this._nyCounter)
         {
            this._nyCounter.dispose();
            this._nyCounter = null;
         }
         if(this._customBg)
         {
            this._customBg = null;
         }
         this._lunarNYSettings = null;
         if(this._lunarNYCounter)
         {
            this._lunarNYCounter.dispose();
            this._lunarNYCounter = null;
         }
         if(this._lunarNYBg)
         {
            this._lunarNYBg = null;
         }
         super.onDispose();
      }
      
      protected function updateLayout() : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:MessageInfoVO = this._data.messageVO;
         this.background.visible = !(this._isLunarNYMessage || this._customMessageSettings);
         if(this._isLunarNYMessage)
         {
            if(!this._lunarNYBg)
            {
               this._lunarNYBg = this._classFactory.getComponent(this.lunarNYSettings.bgLinkage,MovieClip);
               this._lunarNYBg.y = this.bgIcon.y - this.lunarNYSettings.bgIconOffset;
               addChildAt(this._lunarNYBg,getChildIndex(this.bgIcon));
            }
            this.textField.x = this.lunarNYSettings.textX;
            this.textField.y = this.lunarNYSettings.textY - this.lunarNYSettings.bgIconOffset;
            this.textField.width = this.lunarNYSettings.textW;
         }
         else if(this._lunarNYBg)
         {
            removeChild(this._lunarNYBg);
            this._lunarNYBg = null;
         }
         if(this._customBg && (!this._customMessageSettings || this._customMessageSettings && this._classFactory.getClassName(this._customBg) != this._customMessageSettings.bgLinkage))
         {
            removeChild(this._customBg);
            this._customBg = null;
         }
         if(this._customMessageSettings && this._customMessageSettings.bgLinkage != "")
         {
            if(!this._customBg)
            {
               this._customBg = this._classFactory.getComponent(this._customMessageSettings.bgLinkage,MovieClip);
               this._customBg.y = this.bgIcon.y - this._customMessageSettings.bgIconOffset;
               addChildAt(this._customBg,getChildIndex(this.bgIcon));
               this._customBg.name = CUSTOM_BG_NAME;
            }
         }
         if(this._customMessageSettings)
         {
            this.textField.x = this._customMessageSettings.textX;
            this.textField.y = this._customMessageSettings.textY - this._customMessageSettings.bgIconOffset;
            this.textField.width = this._customMessageSettings.textW;
         }
         if(!(this._customMessageSettings || this._isLunarNYMessage))
         {
            this.textField.x = this._textDefaultX;
            this.textField.y = this._textDefaultY;
            this.textField.width = this._textDefaultW;
         }
         if(this._timeComponent)
         {
            this._timeComponent.y = MessageMetrics.TIME_PADDING_Y;
            this._timeComponent.x = this.width - (this._timeComponent.width + MessageMetrics.TIME_PADDING_X) ^ 0;
         }
         var _loc2_:int = 0;
         if(this._buttonsGroup != null)
         {
            _loc2_ = this._buttonsGroup.height + this._buttonPadding;
            if((this._isLunarNYMessage || this._customMessageSettings) && _loc1_.buttonsAlign == TextFormatAlign.CENTER)
            {
               this._buttonsGroup.x = this.textField.x + (this.textField.width - this._buttonsGroup.width >> 1) | 0;
            }
            else
            {
               this._buttonsGroup.x = this.textField.x;
            }
         }
         var _loc3_:int = this.textField.height;
         var _loc4_:int = _loc3_ + this._messageBottomOffset + this._messageTopOffset + _loc2_;
         var _loc5_:int = 0;
         if(StringUtils.isNotEmpty(this.bgIcon.source) && _loc1_)
         {
            _loc5_ = !!_loc1_.bgIconSizeAuto ? int(this.bgIcon.height) : int(_loc1_.bgIconHeight);
         }
         var _loc6_:int = Math.max(_loc4_,_loc5_);
         if(_loc6_ != this.background.height)
         {
            this.background.height = _loc6_;
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._buttonsGroup != null)
         {
            this._buttonsGroup.y = _loc3_ + this.textField.y + this._buttonPadding ^ 0;
         }
         if(this.bmpFill.visible)
         {
            _loc7_ = this.bmpFill.y << 1;
            this.bmpFill.setSize(this.background.width - _loc7_ ^ 0,_loc6_ - _loc7_);
         }
         if(this._isLunarNYMessage)
         {
            this.icon.width = this.lunarNYSettings.iconW;
            this.icon.height = this.lunarNYSettings.iconH;
            this.icon.x = this.lunarNYSettings.iconX;
            this.icon.y = this.lunarNYSettings.iconY;
         }
         else if(this._customMessageSettings)
         {
            this.icon.x = this._customMessageSettings.iconX;
            this.icon.y = this._customMessageSettings.iconY;
         }
         else
         {
            _loc8_ = MessageMetrics.ICON_DEFAULT_PADDING_X;
            this.icon.x = _loc8_ + (this.textField.x - _loc8_ - this.icon.width >> 1);
            if(this.textField.textHeight < this.icon.height)
            {
               this.icon.y = this.textField.y + (this.textField.textHeight - this.icon.height >> 1) + MessageMetrics.ICON_DEFAULT_PADDING_Y ^ 0;
            }
            else
            {
               this.icon.y = this._iconDefaultY;
            }
         }
         if(this._isLunarNYMessage && this._lunarNYCounter)
         {
            this._lunarNYCounter.x = this.lunarNYSettings.counterX;
            this._lunarNYCounter.y = this.lunarNYSettings.counterY;
         }
         else if(this._customMessageSettings && this._nyCounter)
         {
            this._nyCounter.x = this._customMessageSettings.counterX;
            this._nyCounter.y = this._customMessageSettings.counterY;
         }
         this.updateAlertIcon();
      }
      
      protected function updateIcon(param1:String) : void
      {
         this.icon.visible = this.icon.source == param1;
         if(StringUtils.isNotEmpty(param1))
         {
            this.icon.source = param1;
         }
      }
      
      protected function getNyBgLinkage(param1:Boolean) : String
      {
         return !!param1 ? Linkages.NY_LB_SPECIAL_NO_BORDER_NOTIFICATION_BG_UI : Linkages.NY_LB_NO_BORDER_NOTIFICATION_BG_UI;
      }
      
      protected function getWinterOfferBgLinkage() : String
      {
         return Linkages.WINTER_OFFER_NO_BORDER_NOTIFICATION_BG_UI;
      }
      
      private function createAlertIcon() : void
      {
         this._alertIcon = new Image();
         addChild(this._alertIcon);
         this._alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON1;
         this._alertIcon.addEventListener(Event.CHANGE,this.onAlertIconChangeHandler);
         this._alertIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler);
         this._alertIcon.addEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler);
      }
      
      private function updateAlertIcon() : void
      {
         if(this._alertIcon && this.buttonsGroup)
         {
            this._alertIcon.x = this.buttonsGroup.x + this.buttonsGroup.width + MessageMetrics.ICON_ALERT_PADDING_X;
            this._alertIcon.y = this.buttonsGroup.y;
         }
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
         this._buttonsGroup.name = BTN_GROUP_NAME;
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
      
      private function getIcon() : String
      {
         var _loc1_:MessageInfoVO = this._data.messageVO;
         if(this._isLunarNYMessage)
         {
            return _loc1_.lunarNYCount > 1 ? RES_ICONS.MAPS_ICONS_LUNAR_NY_NOTIFICATION_ENVELOPES : RES_ICONS.getEnvelopeIcon(_loc1_.envelopeTypes[0]);
         }
         return !!this._isNYMessage ? RES_ICONS.getNYLBcategoryIcon(_loc1_.nyCategory) : _loc1_.icon;
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
            this.updateIcon(this.getIcon());
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
            if(this._isLunarNYMessage && _loc1_.lunarNYCount > 1)
            {
               if(!this._lunarNYCounter)
               {
                  this._lunarNYCounter = this._classFactory.getComponent(this.lunarNYSettings.counterLinkage,CounterView);
                  this._lunarNYCounter.name = LUNAR_NY_COUNTER_NAME;
                  this._lunarNYCounter.mouseChildren = this._lunarNYCounter.mouseEnabled = false;
                  addChild(this._lunarNYCounter);
               }
               if(_loc1_.lunarNYData != null)
               {
                  this._lunarNYCounter.setCount(this._utils.locale.makeString(LUNAR_NY.SYSTEMMESSAGE_ENVELOPESRECEIVED_COUNTER,{"count":_loc1_.lunarNYCount.toString()}));
               }
            }
            else if(this._lunarNYCounter)
            {
               removeChild(this._lunarNYCounter);
               this._lunarNYCounter = null;
            }
            if(this._alertIcon)
            {
               this._alertIcon.visible = false;
            }
            if(_loc1_.hasWarning(ButtonType.SUBMIT))
            {
               if(this._alertIcon)
               {
                  this.updateAlertIcon();
                  this._alertIcon.visible = true;
               }
               else
               {
                  this.createAlertIcon();
               }
            }
            if(this._nyCounter && (!this._customMessageSettings || this._customMessageSettings && this._classFactory.getClassName(this._nyCounter) != this._customMessageSettings.counterLinkage))
            {
               removeChild(this._nyCounter);
               this._nyCounter = null;
            }
            if(this._customMessageSettings && this._customMessageSettings.counterLinkage != "")
            {
               if(!this._nyCounter)
               {
                  this._nyCounter = this._classFactory.getComponent(this._customMessageSettings.counterLinkage,CounterView);
                  this._nyCounter.name = NY_COUNTER_NAME;
                  this._nyCounter.mouseChildren = this._nyCounter.mouseEnabled = false;
                  addChild(this._nyCounter);
               }
               if(_loc1_.nyData != null)
               {
                  this._nyCounter.setCount(_loc1_.nyCount);
               }
            }
            invalidate(LAYOUT_INVALID);
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
         if(this._isLunarNYMessage)
         {
            return this._lunarNYBg.height + this.messageBottomOffset;
         }
         if(this._customMessageSettings)
         {
            return this._customBg.height;
         }
         return this.background.height;
      }
      
      override public function get width() : Number
      {
         return Math.ceil(this._isLunarNYMessage || this._customMessageSettings ? Number(actualWidth + this.messageRightOffset) : Number(actualWidth));
      }
      
      public function get messageRightOffset() : Number
      {
         if(this._isLunarNYMessage)
         {
            return this._lunarNYSettings.rightOffset;
         }
         if(this._customMessageSettings)
         {
            return this._customMessageSettings.rightOffset;
         }
         return 0;
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
         if(this._isLunarNYMessage)
         {
            return this.lunarNYSettings.bottomOffset;
         }
         if(this._customMessageSettings)
         {
            return this._customMessageSettings.bottomOffset;
         }
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
         if(this._isLunarNYMessage)
         {
            return this.lunarNYSettings.btnPadding;
         }
         if(this._customMessageSettings)
         {
            return this._customMessageSettings.btnPadding;
         }
         return this._buttonPadding;
      }
      
      public function set buttonPadding(param1:int) : void
      {
         this._buttonPadding = param1;
         ++this._buttonPadding;
         invalidate(LAYOUT_INVALID);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         this._data = param1 as NotificationInfoVO;
         this._utils.asserter.assertNotNull(this._data,Errors.INVALID_TYPE + "NotificationInfoVO.");
         this._customMessageSettings = null;
         var _loc2_:MessageInfoVO = this._data.messageVO;
         this._isLunarNYMessage = _loc2_ && _loc2_.type == MSG_TYPE_LUNAR_NY_BOXES;
         if(_loc2_)
         {
            if(_loc2_.type == MSG_TYPE_NY_BOXES)
            {
               _loc2_.icon = RES_ICONS.getNYLBcategoryIcon(_loc2_.nyCategory);
               _loc3_ = this._data.messageVO.isSpecialNYCategory();
               _loc4_ = this.getNyBgLinkage(_loc3_);
               if(_loc3_)
               {
                  this._customMessageSettings = new NYMessageSettings(19,24,19,141,250,0,230,97,12,0,-25,_loc4_,Linkages.NY_COUNTER_ORANGE_VIEW_UI);
               }
               else
               {
                  this._customMessageSettings = new NYMessageSettings(20,20,19,141,250,0,230,97,12,10,0,_loc4_,Linkages.NY_COUNTER_VIEW_UI);
               }
            }
            else if(_loc2_.type == MSG_TYPE_WINTER_OFFER)
            {
               this._customMessageSettings = new NYMessageSettings(45,5,19,141,250,0,0,0,12,30,-25,this.getWinterOfferBgLinkage(),"");
            }
         }
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
      
      protected function get lunarNYSettings() : LunarNYMessageSettings
      {
         return this._lunarNYSettings;
      }
      
      private function onAlertIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onAlertIconRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ISoundButtonEx = this._buttonsGroup.getChildByName(ButtonType.SUBMIT) as ISoundButtonEx;
         if(_loc2_ && _loc2_.tooltip)
         {
            this._tooltipMgr.showComplex(_loc2_.tooltip);
         }
      }
      
      private function onAlertIconChangeHandler(param1:Event) : void
      {
         this.updateAlertIcon();
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
         this._isTFClickedByMBR = this._utils.commons.isRightButton(param1);
      }
      
      private function onIconIoerrorHandler(param1:UILoaderEvent) : void
      {
         DisplayObject(param1.currentTarget).visible = false;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.iconComplete(DisplayObject(param1.currentTarget));
      }
      
      protected function iconComplete(param1:DisplayObject) : void
      {
         param1.visible = true;
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
