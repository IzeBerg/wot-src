package net.wg.gui.components.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.VerticalAlign;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class UserNameField extends UIComponentEx implements ITextContainer
   {
      
      public static const DEF_USER_NAME_COLOR:uint = 15327935;
      
      public static const TEAM_KILLER_USER_NAME_COLOR:uint = 647935;
      
      private static const SHADOW_COLOR_BLACK:String = "Black";
      
      private static const SHADOW_COLOR_WHITE:String = "White";
      
      private static const SHADOW_ALPHA:uint = 1;
      
      private static const SHADOW_DISTANCE:uint = 1;
      
      private static const SHADOW_BLUR:uint = 0;
       
      
      public var textField:TextField;
      
      protected var _toolTip:String = "";
      
      private var _badge:BadgeComponent = null;
      
      private var _userVO:UserVO;
      
      private var _textFormat:TextFormat;
      
      private var _textFont:String;
      
      private var _textSize:Number = 12;
      
      private var _textAlign:String;
      
      private var _shadowColor:String = "Black";
      
      private var _showToolTip:Boolean = true;
      
      private var _textColor:uint = 15327935;
      
      private var _altToolTip:String = "";
      
      private var _shadowColorList:Dictionary;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _tooltipParams:IToolTipParams;
      
      private var _useFakeName:Boolean = false;
      
      private var _showAnonymizerIcon:Boolean = false;
      
      private var _classFactory:IClassFactory;
      
      private var _initialTFWidth:Number = 0;
      
      private var _badgeVisibility:Boolean = true;
      
      private var _verticalAlign:String = "top";
      
      private var _isFrozen:Boolean = false;
      
      public function UserNameField()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._classFactory = App.utils.classFactory;
         super();
         this._tooltipParams = new ToolTipParams({},{},null);
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function configUI() : void
      {
         this._textFormat = this.textField.getTextFormat();
         constraints.addElement(this.textField.name,this.textField,Constraints.ALL);
         constraints.update(width,height);
         initSize();
         super.configUI();
         this._initialTFWidth = this.textField.width;
         this.textField.addEventListener(Event.CHANGE,this.onTextFieldChangeHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.disposeBadge();
         this.textField.removeEventListener(Event.CHANGE,this.onTextFieldChangeHandler);
         this.textField = null;
         this._toolTipMgr = null;
         this._textFormat = null;
         this._userVO = null;
         App.utils.data.cleanupDynamicObject(this._shadowColorList);
         this._classFactory = null;
         this._shadowColorList = null;
         if(this._tooltipParams != null)
         {
            this._tooltipParams.dispose();
            this._tooltipParams = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:DropShadowFilter = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.updateTFPosition();
            this.updateTFSize();
            invalidateData();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this._textFormat.size = this._textSize;
            this._textFormat.font = this._textFont;
            this._textFormat.align = this._textAlign;
            this.textField.setTextFormat(this._textFormat);
            this.textField.textColor = this._textColor;
            _loc1_ = this.getDropShadowFilter(this._shadowColor);
            this.textField.filters = [_loc1_];
            constraints.update(_width,_height);
         }
         if(isInvalid(InvalidationType.DATA) && !this._isFrozen)
         {
            this.textField.setTextFormat(this._textFormat);
            if(this.userVO)
            {
               this.updateBadge();
               this.updateTFPosition();
               this.updateTFSize();
               this.textField.autoSize = TextFieldAutoSize.NONE;
               _loc2_ = false;
               if(this.userVO.userProps)
               {
                  _loc2_ = App.utils.commons.formatPlayerName(this.textField,this.userVO.userProps,this.useFakeName,this.showAnonymizerIcon);
               }
               this._showToolTip = _loc2_ || this.isAnonymized;
               if(this.isAnonymized)
               {
                  this._tooltipParams.header.name = !!this.useFakeName ? this.userVO.fullName : this.userVO.fakeName;
               }
               else if(_loc2_)
               {
                  this._toolTip = App.utils.commons.getFullPlayerName(this.userVO.userProps,true);
               }
               else
               {
                  this._toolTip = null;
               }
               this.textField.textColor = !!this.userVO.isTeamKiller ? uint(TEAM_KILLER_USER_NAME_COLOR) : uint(this._textColor);
            }
            else
            {
               this.textField.text = Values.SPACE_STR;
            }
            this.updateBadgeVisibility();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      private function updateBadge() : void
      {
         if(this._badge == null && this._userVO.badgeVisualVO != null)
         {
            this._badge = this._classFactory.getComponent(Linkages.BADGE_COMPONENT,BadgeComponent);
            addChild(this._badge);
            this._badge.addEventListener(Event.CHANGE,this.badgeLoaded);
         }
         if(this._badge != null)
         {
            if(this._userVO.badgeVisualVO != null)
            {
               this._badge.setData(this._userVO.badgeVisualVO);
            }
            else
            {
               this.disposeBadge();
            }
         }
         this.updateBadgeVisibility();
      }
      
      private function updateTFSize() : void
      {
         if(this._badge != null && this._badge.visible)
         {
            this.textField.width = this._initialTFWidth - this._badge.width;
            if(this._verticalAlign == VerticalAlign.TOP)
            {
               this._badge.y = 0;
            }
            if(this._verticalAlign == VerticalAlign.MIDDLE)
            {
               this._badge.y = this.textField.height - this._badge.height >> 1;
            }
            if(this._verticalAlign == VerticalAlign.BOTTOM)
            {
               this._badge.y = this.textField.height - this._badge.height;
            }
         }
         else
         {
            this.textField.width = this._initialTFWidth;
         }
      }
      
      private function updateTFPosition() : void
      {
         if(this._badge != null && this._badge.visible)
         {
            this.textField.x = this._badge.width;
         }
         else
         {
            this.textField.x = 0;
         }
      }
      
      private function getDropShadowFilter(param1:String) : DropShadowFilter
      {
         if(!this._shadowColorList)
         {
            this._shadowColorList = new Dictionary();
            this._shadowColorList[SHADOW_COLOR_BLACK] = new UserNameFieldShadowColor(0,1,2,270);
            this._shadowColorList[SHADOW_COLOR_WHITE] = new UserNameFieldShadowColor(16777215,0.4,3,90);
         }
         var _loc2_:DropShadowFilter = new DropShadowFilter();
         var _loc3_:UserNameFieldShadowColor = this._shadowColorList[param1];
         _loc2_.color = _loc3_.color;
         _loc2_.angle = _loc3_.angle;
         _loc2_.alpha = SHADOW_ALPHA;
         _loc2_.blurX = SHADOW_BLUR;
         _loc2_.blurY = SHADOW_BLUR;
         _loc2_.distance = SHADOW_DISTANCE;
         _loc2_.strength = _loc3_.strange;
         _loc2_.inner = false;
         _loc2_.knockout = false;
         _loc2_.quality = _loc3_.quality;
         return _loc2_;
      }
      
      private function disposeBadge() : void
      {
         if(this._badge != null)
         {
            this._badge.removeEventListener(Event.CHANGE,this.badgeLoaded);
            removeChild(this._badge);
            this._badge.dispose();
            this._badge = null;
         }
      }
      
      private function updateBadgeVisibility() : void
      {
         if(this._badge != null)
         {
            this._badge.visible = this._userVO && this._userVO.userName && this._badgeVisibility;
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._initialTFWidth = param1;
      }
      
      public function get showToolTip() : Boolean
      {
         return this._showToolTip;
      }
      
      public function set showToolTip(param1:Boolean) : void
      {
         this._showToolTip = param1;
      }
      
      [Inspectable(defaultValue="$FieldFont",name="textFont",type="list",enumeration="$TextFont,$FieldFont,$TitleFont")]
      public function get textFont() : String
      {
         return this._textFont;
      }
      
      public function set textFont(param1:String) : void
      {
         if(this._textFont == param1)
         {
            return;
         }
         this._textFont = param1;
         invalidateState();
      }
      
      [Inspectable(defaultValue="12",type="Number")]
      public function get textSize() : Number
      {
         return this._textSize;
      }
      
      public function set textSize(param1:Number) : void
      {
         if(this._textSize == param1)
         {
            return;
         }
         this._textSize = param1;
         invalidateState();
      }
      
      [Inspectable(defaultValue="left",name="textAlign",type="list",enumeration="left,right,center")]
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         invalidateState();
      }
      
      [Inspectable(defaultValue="#E9E2BF",name="textColor",type="Color")]
      public function get textColor() : Number
      {
         return this._textColor;
      }
      
      public function set textColor(param1:Number) : void
      {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidateState();
      }
      
      [Inspectable(defaultValue="Black",name="shadowColor",type="list",enumeration="White, Black")]
      public function get shadowColor() : String
      {
         return this._shadowColor;
      }
      
      public function set shadowColor(param1:String) : void
      {
         if(this._shadowColor == param1)
         {
            return;
         }
         this._shadowColor = param1;
         invalidateState();
      }
      
      public function get toolTip() : String
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         if(this._toolTip == param1)
         {
            return;
         }
         this._toolTip = App.utils.locale.makeString(param1);
      }
      
      public function get altToolTip() : String
      {
         return this._altToolTip;
      }
      
      public function set altToolTip(param1:String) : void
      {
         if(this._altToolTip == param1)
         {
            return;
         }
         this._altToolTip = App.utils.locale.makeString(param1);
      }
      
      public function get userVO() : UserVO
      {
         return this._userVO;
      }
      
      public function set userVO(param1:UserVO) : void
      {
         this._userVO = param1;
         this._isFrozen = false;
         invalidateData();
      }
      
      public function get useFakeName() : Boolean
      {
         return this._useFakeName;
      }
      
      public function set useFakeName(param1:Boolean) : void
      {
         this._useFakeName = param1;
         invalidateData();
      }
      
      public function get showAnonymizerIcon() : Boolean
      {
         return this._showAnonymizerIcon;
      }
      
      public function set showAnonymizerIcon(param1:Boolean) : void
      {
         this._showAnonymizerIcon = param1;
         invalidateData();
      }
      
      public function get textWidth() : Number
      {
         if(this._badge != null && this._badge.visible)
         {
            return this._badge.width + this.textField.textWidth;
         }
         return this.textField.textWidth;
      }
      
      public function set badgeVisibility(param1:Boolean) : void
      {
         this._badgeVisibility = param1;
      }
      
      public function get text() : String
      {
         return this.textField.text;
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
      }
      
      public function get verticalAlign() : String
      {
         return this._verticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void
      {
         this._verticalAlign = param1;
         invalidateSize();
      }
      
      public function set isFrozen(param1:Boolean) : void
      {
         this._isFrozen = param1;
      }
      
      private function get isCurrentPlayer() : Boolean
      {
         return this._userVO && this._userVO.userProps && UserTags.isCurrentPlayer(this.userVO.userProps.tags);
      }
      
      private function get isAnonymized() : Boolean
      {
         return this._userVO && this._userVO.isAnonymized;
      }
      
      protected function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._showToolTip)
         {
            if(this.isAnonymized)
            {
               this._toolTipMgr.showComplexWithParams(TOOLTIPS.ANONYMIZER_TEAMSTATS,this._tooltipParams);
            }
            else if(this._altToolTip)
            {
               this._toolTipMgr.show(this._altToolTip);
            }
            else if(this._toolTip)
            {
               this._toolTipMgr.show(this._toolTip);
            }
         }
      }
      
      protected function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function badgeLoaded(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onTextFieldChangeHandler(param1:Event) : void
      {
         this.updateTFPosition();
      }
   }
}
