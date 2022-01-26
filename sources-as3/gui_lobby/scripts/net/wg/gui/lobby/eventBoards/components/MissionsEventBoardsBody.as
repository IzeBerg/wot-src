package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderAwardBlock;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderConditionBlock;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderDescBlock;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderReloginBlock;
   import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderServerBlock;
   import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsBodyVO;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.gui.lobby.missions.components.MissionPackMarathonBody;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class MissionsEventBoardsBody extends MissionPackMarathonBody implements IPopOverCaller
   {
      
      private static const BIG_WIDTH:int = 1584;
      
      private static const BLOCKS_HEIGHT:int = 202;
      
      private static const BLOCKS_MARGIN:int = 30;
      
      private static const BLOCKS_GAP:int = 10;
      
      private static const BLOCKS_NUMBER:int = 3;
      
      private static const ARROWS_HEIGHT:int = 154;
      
      private static const ARROWS_OFFSET_X:int = 20;
      
      private static const ARROWS_OFFSET_Y:int = 10;
      
      private static const DECORATION_WIDTH_MIN:int = 1023;
      
      private static const DECORATION_HEIGHT_MIN:int = 272;
      
      private static const DECORATION_WIDTH_MAX:int = 1318;
      
      private static const DECORATION_HEIGHT_MAX:int = 350;
      
      private static const OFFSET_MIN:int = 20;
      
      private static const OFFSET_MAX:int = 250;
      
      private static const SERVER_BLOCK_OFFSET:int = 90;
      
      private static const RELOGIN_BLOCK_OFFSET:int = 73;
      
      private static const SEPARATOR_OFFSET:int = 155;
      
      private static const REGISTRATION_OFFSET_Y1:int = 276;
      
      private static const REGISTRATION_OFFSET_Y2:int = 310;
      
      private static const TITLE_OFFSET:int = 277;
      
      private static const DESCRIPTION1_OFFSET:int = 22;
      
      private static const DESCRIPTION2_OFFSET:int = 50;
      
      private static const CARD_OFFSET:int = 330;
      
      private static const BUTTON_OFFSET:int = 35;
      
      private static const TEXT1_OFFSET:int = 15;
      
      private static const TEXT2_OFFSET:int = 45;
      
      private static const RATING_OFFSET_X_MIN:int = 489;
      
      private static const RATING_OFFSET_X_MAX:int = 763;
      
      private static const RATING_OFFSET_Y:int = 280;
      
      private static const REGISTRATION_CLICK:String = "registrationClick";
      
      private static const DECORATION_ALPHA:Number = 0.3;
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
       
      
      public var serverBlock:HeaderServerBlock = null;
      
      public var reloginBlock:HeaderReloginBlock = null;
      
      public var descBlock:HeaderDescBlock = null;
      
      public var conditionBlock:HeaderConditionBlock = null;
      
      public var awardBlock:HeaderAwardBlock = null;
      
      public var divider:Sprite = null;
      
      public var arrow1:Sprite = null;
      
      public var arrow2:Sprite = null;
      
      public var separator:MovieClip = null;
      
      public var title:TextField = null;
      
      public var informationIcon:Sprite = null;
      
      public var description1:TextField = null;
      
      public var description2:TextField = null;
      
      public var btnRegistration:ISoundButtonEx = null;
      
      public var btnRating:ISoundButtonEx = null;
      
      public var uiDecoration:UILoaderAlt = null;
      
      private var _isEventBegan:Boolean = true;
      
      private var _isRegistrationTop:Boolean = true;
      
      private var _popoverAlias:String = "";
      
      private var _titleTooltip:String = "";
      
      private var _description1Tooltip:String = "";
      
      private var _description2Tooltip:String = "";
      
      private var _registrationTooltip:String = "";
      
      private var _ratingTooltip:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _eventID:String = "";
      
      public function MissionsEventBoardsBody()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.informationIcon.visible = false;
         this.btnRegistration.label = EVENT_BOARDS.TABLE_SELECTREGISTRATIONBTN;
         this.btnRegistration.addEventListener(ButtonEvent.CLICK,this.onBtnRegistrationClickHandler);
         this.btnRegistration.addEventListener(MouseEvent.ROLL_OVER,this.onRegistrationRollOverHandler);
         this.btnRegistration.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnRegistration.usePreventUpdateTextScale = true;
         this.btnRating.label = EVENT_BOARDS.TABLE_SELECTRATINGBTN;
         this.btnRating.addEventListener(ButtonEvent.CLICK,this.onBtnRatingClickHandler);
         this.btnRating.addEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.btnRating.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnRating.usePreventUpdateTextScale = true;
         this.uiDecoration.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.autoSize = false;
         this.title.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.title.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.description1.addEventListener(MouseEvent.ROLL_OVER,this.onDescription1RollOverHandler);
         this.description1.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.description2.addEventListener(MouseEvent.ROLL_OVER,this.onDescription2RollOverHandler);
         this.description2.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.divider.mouseEnabled = false;
         this.arrow1.mouseEnabled = false;
         this.arrow2.mouseEnabled = false;
         this.separator.mouseEnabled = this.separator.mouseChildren = false;
         this.uiDecoration.mouseEnabled = this.uiDecoration.mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function setItemRenderer() : void
      {
         missionsList.itemRenderer = App.utils.classFactory.getClass(QUESTS_ALIASES.MISSIONS_EVENT_BOARDS_CARD_RENDERER_LINKAGE);
      }
      
      override protected function onDispose() : void
      {
         this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.description1.removeEventListener(MouseEvent.ROLL_OVER,this.onDescription1RollOverHandler);
         this.description1.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.description2.removeEventListener(MouseEvent.ROLL_OVER,this.onDescription2RollOverHandler);
         this.description2.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.title = null;
         this.informationIcon = null;
         this.description1 = null;
         this.description2 = null;
         this.serverBlock.dispose();
         this.serverBlock = null;
         this.reloginBlock.dispose();
         this.reloginBlock = null;
         this.descBlock.dispose();
         this.descBlock = null;
         this.conditionBlock.dispose();
         this.conditionBlock = null;
         this.awardBlock.dispose();
         this.awardBlock = null;
         this.divider = null;
         this.arrow1 = null;
         this.arrow2 = null;
         this.separator = null;
         this.btnRegistration.removeEventListener(ButtonEvent.CLICK,this.onBtnRegistrationClickHandler);
         this.btnRegistration.removeEventListener(MouseEvent.ROLL_OVER,this.onRegistrationRollOverHandler);
         this.btnRegistration.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnRegistration.dispose();
         this.btnRegistration = null;
         this.btnRating.removeEventListener(ButtonEvent.CLICK,this.onBtnRatingClickHandler);
         this.btnRating.removeEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.btnRating.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnRating.dispose();
         this.btnRating = null;
         this.uiDecoration.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this._titleTooltip = null;
         this._description1Tooltip = null;
         this._description2Tooltip = null;
         this._registrationTooltip = null;
         this._ratingTooltip = null;
         this._toolTipMgr = null;
         this._eventID = null;
         super.onDispose();
      }
      
      override protected function getContentHeight() : int
      {
         var _loc1_:int = Boolean(missionsList.height) ? int(missionsList.height + LIST_PADDING_BOTTOM_MIN) : int(0);
         return !!dummy.visible ? int(dummy.height) : int(_loc1_);
      }
      
      override public function get height() : Number
      {
         var _loc1_:int = !!this._isEventBegan ? int(OFFSET_MIN) : int(OFFSET_MAX);
         if(this._isEventBegan)
         {
            if(this.serverBlock.visible)
            {
               _loc1_ += SERVER_BLOCK_OFFSET;
            }
            else if(this.reloginBlock.visible)
            {
               _loc1_ += RELOGIN_BLOCK_OFFSET;
            }
         }
         return maskMc.height + CARD_OFFSET + _loc1_ + this.getBottomOffset();
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:Object = null;
         if(param1 != null)
         {
            _loc2_ = param1;
            this._eventID = _loc2_.eventID;
            this.serverBlock.visible = _loc2_.isUnsuitableServer;
            if(this.serverBlock.visible)
            {
               this.serverBlock.setData(_loc2_.serverBlockVO);
               this.serverBlock.validateNow();
            }
            this.reloginBlock.visible = _loc2_.isRelogin;
            if(this.reloginBlock.visible)
            {
               this.reloginBlock.setData(_loc2_.reloginBlockVO);
               this.reloginBlock.validateNow();
            }
            this.descBlock.setData(_loc2_.taskBlockVO);
            this.descBlock.setEventID(_loc2_.eventID);
            this.descBlock.validateNow();
            this.conditionBlock.setData(_loc2_.conditionBlockVO);
            this.conditionBlock.setEventID(_loc2_.eventID);
            this.conditionBlock.validateNow();
            this.awardBlock.setData(_loc2_.awardBlockVO);
            this.awardBlock.setEventID(_loc2_.eventID);
            this.awardBlock.validateNow();
            this.informationIcon.visible = StringUtils.isNotEmpty(_loc2_.titleTooltip);
            this.btnRegistration.visible = _loc2_.isRegistration;
            this.btnRegistration.enabled = _loc2_.isRegistrationEnabled;
            this.btnRegistration.label = _loc2_.buttonRegistrationLabel;
            this.separator.gotoAndStop(!!this.btnRegistration.visible ? 2 : 1);
            this.btnRating.visible = _loc2_.isRating;
            this.title.visible = StringUtils.isNotEmpty(_loc2_.title);
            if(this.title.visible)
            {
               this.title.htmlText = _loc2_.title;
            }
            this.description1.visible = StringUtils.isNotEmpty(_loc2_.description1);
            if(this.description1.visible)
            {
               this.description1.htmlText = _loc2_.description1;
            }
            this.description2.visible = StringUtils.isNotEmpty(_loc2_.description2);
            if(this.description2.visible)
            {
               this.description2.htmlText = _loc2_.description2;
            }
            this.uiDecoration.visible = StringUtils.isNotEmpty(_loc2_.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = _loc2_.uiDecoration;
            }
            this._isEventBegan = _loc2_.isEventBegan;
            this.uiDecoration.alpha = !!this._isEventBegan ? Number(DECORATION_ALPHA) : Number(1);
            this._isRegistrationTop = _loc2_.isRegistrationTop;
            this._popoverAlias = _loc2_.popoverAlias;
            this._titleTooltip = _loc2_.titleTooltip;
            this._description1Tooltip = _loc2_.description1Tooltip;
            this._description2Tooltip = _loc2_.description2Tooltip;
            this._registrationTooltip = _loc2_.registrationTooltip;
            this._ratingTooltip = _loc2_.ratingTooltip;
         }
         super.update(param1);
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.btnRating);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.btnRating);
      }
      
      override protected function get dataClass() : Class
      {
         return MissionEventBoardsBodyVO;
      }
      
      private function updateBgLoaderSize() : void
      {
         var _loc1_:Boolean = width == BIG_WIDTH;
         this.uiDecoration.width = !!_loc1_ ? Number(DECORATION_WIDTH_MAX) : Number(DECORATION_WIDTH_MIN);
         this.uiDecoration.height = !!_loc1_ ? Number(DECORATION_HEIGHT_MAX) : Number(DECORATION_HEIGHT_MIN);
         this.uiDecoration.x = width - this.uiDecoration.width >> 1;
      }
      
      private function getBottomOffset() : int
      {
         var _loc1_:int = !!this.description1.visible ? int(TEXT1_OFFSET) : int(0);
         var _loc2_:int = this.btnRegistration.visible && !this._isRegistrationTop ? int(BUTTON_OFFSET) : int(_loc1_);
         return !!this.description2.visible ? int(TEXT2_OFFSET) : int(_loc2_);
      }
      
      override protected function updateContentWidth() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         super.updateContentWidth();
         var _loc1_:int = !!this._isEventBegan ? int(OFFSET_MIN) : int(OFFSET_MAX);
         if(this.serverBlock.visible)
         {
            this.serverBlock.x = width >> 1;
            if(this._isEventBegan)
            {
               _loc1_ += SERVER_BLOCK_OFFSET;
            }
         }
         else if(this.reloginBlock.visible)
         {
            this.reloginBlock.x = width >> 1;
            if(this._isEventBegan)
            {
               _loc1_ += RELOGIN_BLOCK_OFFSET;
            }
         }
         this.descBlock.y = this.conditionBlock.y = this.awardBlock.y = _loc1_;
         maskMc.y = dummy.y = missionsList.y = CARD_OFFSET + _loc1_ + this.getBottomOffset();
         var _loc2_:int = Math.round((width - BLOCKS_MARGIN * 2 - BLOCKS_GAP * (BLOCKS_NUMBER - 1)) / BLOCKS_NUMBER);
         var _loc3_:int = Math.round(_loc2_ / 2);
         this.descBlock.x = BLOCKS_MARGIN + _loc3_;
         this.descBlock.updateContentWidth(_loc2_);
         this.conditionBlock.x = this.descBlock.x + _loc2_ + BLOCKS_GAP;
         this.conditionBlock.updateContentWidth(_loc2_);
         this.awardBlock.x = this.conditionBlock.x + _loc2_ + BLOCKS_GAP;
         this.arrow1.x = this.descBlock.x + _loc3_ - ARROWS_OFFSET_X;
         this.arrow2.x = this.conditionBlock.x + _loc3_ - ARROWS_OFFSET_X;
         this.arrow1.y = this.arrow2.y = (BLOCKS_HEIGHT - ARROWS_HEIGHT >> 1) + _loc1_ - ARROWS_OFFSET_Y;
         this.divider.x = width - this.divider.width >> 1;
         this.separator.x = 0;
         this.separator.y = SEPARATOR_OFFSET + _loc1_;
         this.separator.width = width;
         if(this.btnRegistration.visible)
         {
            _loc4_ = !!this._isRegistrationTop ? int(REGISTRATION_OFFSET_Y1) : int(REGISTRATION_OFFSET_Y2);
            this.btnRegistration.x = width - this.btnRegistration.width >> 1;
            this.btnRegistration.y = _loc4_ + _loc1_;
         }
         if(this.title.visible)
         {
            this.title.x = width - this.title.width >> 1;
            this.title.y = TITLE_OFFSET + _loc1_;
            this.informationIcon.x = this.title.x + (this.title.textWidth + this.title.width >> 1) + INFORMATION_ICON_OFFSET;
            this.informationIcon.y = this.title.y + INFORMATION_ICON_OFFSET;
         }
         if(this.description1.visible)
         {
            this.description1.x = width - this.description1.width >> 1;
            this.description1.y = this.title.y + DESCRIPTION1_OFFSET;
         }
         if(this.description2.visible)
         {
            this.description2.x = width - this.description2.width >> 1;
            this.description2.y = this.title.y + DESCRIPTION2_OFFSET;
         }
         if(this.btnRating.visible)
         {
            _loc5_ = width == BIG_WIDTH;
            _loc6_ = !!_loc5_ ? int(RATING_OFFSET_X_MAX) : int(RATING_OFFSET_X_MIN);
            this.btnRating.x = (width + missionsList.horizontalGap >> 1) - this.btnRating.width + _loc6_;
            this.btnRating.y = RATING_OFFSET_Y + _loc1_;
         }
         if(this.uiDecoration.visible)
         {
            this.updateBgLoaderSize();
         }
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         this.updateBgLoaderSize();
      }
      
      private function onBtnRegistrationClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(REGISTRATION_CLICK,this._eventID,true));
         }
      }
      
      private function onBtnRatingClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON && this._popoverAlias != Values.EMPTY_STR)
         {
            _loc2_ = new Object();
            _loc2_.caller = "missions";
            _loc2_.eventID = this._eventID;
            App.popoverMgr.show(this,this._popoverAlias,_loc2_);
         }
      }
      
      private function onTitleRollOverHandler(param1:MouseEvent) : void
      {
         if(!this.informationIcon.visible || this.informationIcon.visible && param1.target == this.informationIcon)
         {
            this._toolTipMgr.showComplex(this._titleTooltip);
         }
      }
      
      private function onDescription1RollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._description1Tooltip);
      }
      
      private function onDescription2RollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._description2Tooltip);
      }
      
      private function onRegistrationRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._registrationTooltip);
      }
      
      private function onRatingRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._ratingTooltip);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
