package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.TextFieldNoSound;
   import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsHeaderVO;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.gui.lobby.missions.components.MissionPackHeaderBase;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class MissionsEventBoardsHeader extends MissionPackHeaderBase
   {
      
      private static const PARTICIPATE_CLICK:String = "participateClick";
      
      private static const REGISTRATION_CLICK:String = "registrationClick";
      
      private static const HEIGHT_OFFSET:int = 125;
      
      private static const HEIGHT_OFFSET_REGISTRATION:int = 183;
      
      private static const HEIGHT_OFFSET_TITLE:int = 211;
      
      private static const TEXT_OFFSET:int = 18;
      
      private static const BUTTON_OFFSET:int = 18;
      
      private static const TEXT_Y1:int = 8;
      
      private static const TEXT_Y2:int = 23;
      
      private static const BUTTON_OFFSET_REGISTRATION_Y1:int = 162;
      
      private static const BUTTON_OFFSET_REGISTRATION_Y2:int = 134;
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
       
      
      public var timer:TextFieldNoSound = null;
      
      public var participateTf:TextField = null;
      
      public var btnParticipate:ISoundButtonEx = null;
      
      public var title:TextField = null;
      
      public var informationIcon:Sprite = null;
      
      public var btnRegistration:ISoundButtonEx = null;
      
      private var _participateTooltip:String = "";
      
      private var _titleTooltip:String = "";
      
      private var _buttonTooltip:String = "";
      
      private var _buttonRegistrationTooltip:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _eventID:String = "";
      
      private var _heightHeader:int = 0;
      
      private var _isCollapsed:Boolean = false;
      
      private var _isTitleVisible:Boolean = false;
      
      private var _isInformationIconVisible:Boolean = false;
      
      private var _isBtnRegistrationVisible:Boolean = false;
      
      public function MissionsEventBoardsHeader()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnParticipate.label = EVENT_BOARDS.TABLE_SELECTPARTICIPATEBTN;
         this.btnParticipate.visible = false;
         this.btnParticipate.addEventListener(ButtonEvent.CLICK,this.onBtnParticipateClickHandler);
         this.btnParticipate.mouseEnabledOnDisabled = true;
         this.btnParticipate.usePreventUpdateTextScale = true;
         this.participateTf.mouseEnabled = false;
         this.informationIcon.visible = false;
         this.btnRegistration.label = EVENT_BOARDS.TABLE_SELECTREGISTRATIONBTN;
         this.btnRegistration.visible = false;
         this.btnRegistration.addEventListener(ButtonEvent.CLICK,this.onBtnRegistrationClickHandler);
         this.btnRegistration.usePreventUpdateTextScale = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this._heightHeader = HEIGHT_OFFSET;
         this.timer.textField.mouseEnabled = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.timer.dispose();
         this.timer = null;
         this.participateTf = null;
         this.btnParticipate.removeEventListener(ButtonEvent.CLICK,this.onBtnParticipateClickHandler);
         this.btnParticipate.dispose();
         this.btnParticipate = null;
         this.title = null;
         this.informationIcon = null;
         this.btnRegistration.removeEventListener(ButtonEvent.CLICK,this.onBtnRegistrationClickHandler);
         this.btnRegistration.dispose();
         this.btnRegistration = null;
         this._participateTooltip = null;
         this._buttonTooltip = null;
         this._titleTooltip = null;
         this._buttonRegistrationTooltip = null;
         this._toolTipMgr = null;
         this._eventID = null;
         super.onDispose();
      }
      
      private function setHeightHeader(param1:Boolean) : void
      {
         this.title.visible = !!param1 ? Boolean(this._isTitleVisible) : Boolean(false);
         this.informationIcon.visible = !!param1 ? Boolean(this._isInformationIconVisible) : Boolean(false);
         this.btnRegistration.visible = !!param1 ? Boolean(this._isBtnRegistrationVisible) : Boolean(false);
         var _loc2_:int = !!this.title.visible ? int(HEIGHT_OFFSET_TITLE) : int(HEIGHT_OFFSET_REGISTRATION);
         this._heightHeader = param1 && this.btnRegistration.visible ? int(_loc2_) : int(HEIGHT_OFFSET);
      }
      
      private function updateContentWidth() : void
      {
         this.timer.x = width - this.timer.width >> 1;
         if(this.participateTf.visible)
         {
            this.participateTf.x = width - this.participateTf.width - TEXT_OFFSET;
            this.participateTf.y = !!this.btnParticipate.visible ? Number(TEXT_Y1) : Number(TEXT_Y2);
         }
         if(this.btnParticipate.visible)
         {
            this.btnParticipate.x = width - this.btnParticipate.width - BUTTON_OFFSET;
         }
         if(this.title.visible)
         {
            this.title.x = width - this.title.width >> 1;
            this.informationIcon.x = this.title.x + (this.title.textWidth + this.title.width >> 1) + INFORMATION_ICON_OFFSET;
         }
         if(this.btnRegistration.visible)
         {
            this.btnRegistration.x = width - this.btnRegistration.width >> 1;
            this.btnRegistration.y = !!this.title.visible ? Number(BUTTON_OFFSET_REGISTRATION_Y1) : Number(BUTTON_OFFSET_REGISTRATION_Y2);
         }
      }
      
      override public function setCollapsed(param1:Boolean, param2:Boolean) : void
      {
         this._isCollapsed = param1;
         this.setHeightHeader(param1);
         this.updateContentWidth();
         super.setCollapsed(param1,param2);
      }
      
      override protected function draw() : void
      {
         var _loc1_:MissionEventBoardsHeaderVO = null;
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = MissionEventBoardsHeaderVO(data);
            this.timer.textField.htmlText = _loc1_.timer;
            this.participateTf.visible = StringUtils.isNotEmpty(_loc1_.participate);
            if(this.participateTf.visible)
            {
               this.participateTf.mouseEnabled = true;
               this.participateTf.htmlText = _loc1_.participate;
            }
            this.btnParticipate.label = _loc1_.buttonLabel;
            this.btnParticipate.visible = _loc1_.isButton;
            this.btnParticipate.enabled = _loc1_.isButtonEnabled;
            this.title.visible = this._isTitleVisible = StringUtils.isNotEmpty(_loc1_.title);
            if(this.title.visible)
            {
               this.title.htmlText = _loc1_.title;
            }
            this.informationIcon.visible = this._isInformationIconVisible = StringUtils.isNotEmpty(_loc1_.titleTooltip);
            this.btnRegistration.visible = this._isBtnRegistrationVisible = _loc1_.isButtonRegistration;
            this.btnRegistration.enabled = _loc1_.isButtonRegistrationEnabled;
            this.btnRegistration.label = _loc1_.buttonRegistrationLabel;
            this._participateTooltip = _loc1_.participateTooltip;
            this._buttonTooltip = _loc1_.buttonTooltip;
            this._titleTooltip = _loc1_.titleTooltip;
            this._buttonRegistrationTooltip = _loc1_.buttonRegistrationTooltip;
            this._eventID = _loc1_.eventID;
            this.setHeightHeader(this._isCollapsed);
            this.updateContentWidth();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateContentWidth();
         }
      }
      
      private function onBtnParticipateClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(PARTICIPATE_CLICK,this._eventID,true));
         }
      }
      
      private function onBtnRegistrationClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(REGISTRATION_CLICK,this._eventID,true));
         }
      }
      
      override public function get height() : Number
      {
         return this._heightHeader;
      }
      
      override protected function get dataClass() : Class
      {
         return MissionEventBoardsHeaderVO;
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.btnParticipate:
               _loc2_ = this._buttonTooltip;
               break;
            case this.participateTf:
               _loc2_ = this._participateTooltip;
               break;
            case this.informationIcon:
               _loc2_ = this._titleTooltip;
               break;
            case this.btnRegistration:
               _loc2_ = this._buttonRegistrationTooltip;
               break;
            default:
               return;
         }
         this._toolTipMgr.showComplex(_loc2_);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
