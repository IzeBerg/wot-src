package net.wg.gui.lobby.barracks
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.Colors;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.lobby.barracks.data.BarracksTankmanVO;
   import net.wg.gui.lobby.components.SmallSkillsList;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   [Event(name="showRecruitWindow",type="net.wg.gui.events.CrewEvent")]
   public class BarracksItemRenderer extends SoundListItemRenderer
   {
      
      private static const INVALIDATE_PARAMS:String = "params";
      
      private static const INVALIDATE_IN_TANK:String = "inTank";
      
      private static const PATH_TANKMAN_ICONS_BARRACKS:String = "../maps/icons/tankmen/icons/barracks/";
      
      private static const PATH_TANKMAN_ICONS_SMALL:String = "../maps/icons/tankmen/ranks/small/";
      
      private static const SOUND_ID_BTN_DISMISS:String = "btnDissmiss";
      
      private static const SOUND_ID_BTN_UPLOADED:String = "btnUnload";
      
      private static const TO_STRING_TEXT:String = "BarracksItemRenderer: ";
      
      private static const PREFIX_EMPTY:String = "empty_";
      
      private static const PREFIX_BUY:String = "buy_";
      
      private static const PREFIX_SELECTED:String = "selected_";
      
      private static const SELECTION_STATE_BARRACKS:String = "barracks";
      
      private static const SELECTION_STATE_TANK:String = "tank";
      
      private static const SELECTION_STATE_CURRENT_TANK:String = "current_tank";
      
      private static const PLUS:String = "+";
      
      private static const CHAR_LEFT_BRACES:String = "{";
      
      private static const CHAR_RIGHT_BRACES:String = "}";
      
      private static const CHAR_PERCENT:String = "%";
      
      private static const CHAR_COMMA:String = ",";
      
      private static const HTML_FONT_START:String = " <font color=\'";
      
      private static const HTML_FONT_END:String = "\'>";
      
      private static const HTML_FONT_TAG_CLOSE:String = "</font>";
      
      private static const NOT_RECRUITED_DATE_COLOR:uint = 16754521;
      
      private static const RANK_NAME_COLOR:uint = 9144706;
       
      
      public var countField:TextField = null;
      
      public var btnDismiss:SoundButtonEx;
      
      public var icon:UILoaderAlt;
      
      public var iconRole:UILoaderAlt;
      
      public var iconRank:UILoaderAlt;
      
      public var clickArea:Sprite = null;
      
      public var selection:MovieClip = null;
      
      public var emptyPlacesTF:TextField;
      
      public var levelSpecializationMain:TextField = null;
      
      public var tankmanName:TextField = null;
      
      public var rank:TextField = null;
      
      public var role:TextField = null;
      
      public var lockMsg:TextField = null;
      
      public var recoveryPeriodTf:TextField = null;
      
      public var skills:SmallSkillsList = null;
      
      public var vehicleType:TextField = null;
      
      public var price:IconText = null;
      
      public var actionPrice:ActionPrice = null;
      
      public var descrField:TextField = null;
      
      private var _isMouseOver:Boolean = false;
      
      private var _tankmanData:BarracksTankmanVO = null;
      
      private var _inTank:Boolean = false;
      
      private var _inCurrentTank:Boolean = false;
      
      private var _empty:Boolean = false;
      
      private var _buy:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _utils:IUtils = null;
      
      public function BarracksItemRenderer()
      {
         super();
         this.skills.showBuyAnimation = false;
         buttonMode = true;
         soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
         this.btnDismiss.soundType = SoundTypes.NORMAL_BTN;
         this.btnDismiss.mouseEnabledOnDisabled = true;
         this._toolTipMgr = App.toolTipMgr;
         this._utils = App.utils;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(param1 == null)
         {
            return;
         }
         this.btnDismiss.focusTarget = this;
         if(this._tankmanData)
         {
            this._tankmanData.dispose();
         }
         this._tankmanData = BarracksTankmanVO(param1);
         this.empty = this._tankmanData.empty;
         this.buy = this._tankmanData.buy;
         var _loc2_:String = this._tankmanData.iconFile;
         if(StringUtils.isEmpty(_loc2_))
         {
            this.icon.visible = false;
         }
         else
         {
            this.icon.visible = true;
            _loc2_ = PATH_TANKMAN_ICONS_BARRACKS + _loc2_;
            if(this.icon.source != _loc2_)
            {
               this.icon.source = _loc2_;
            }
         }
         var _loc3_:String = this._tankmanData.rankIconFile;
         if(StringUtils.isEmpty(_loc3_))
         {
            this.iconRank.visible = false;
         }
         else
         {
            this.iconRank.visible = true;
            _loc3_ = PATH_TANKMAN_ICONS_SMALL + _loc3_;
            if(this.iconRank.source != _loc3_)
            {
               this.iconRank.source = _loc3_;
            }
         }
         var _loc4_:String = this._tankmanData.roleIconFile;
         if(StringUtils.isEmpty(_loc4_))
         {
            this.iconRole.visible = false;
         }
         else
         {
            this.iconRole.visible = true;
            if(this.iconRole.source != _loc4_)
            {
               this.iconRole.source = _loc4_;
            }
         }
         this.inCurrentTank = this._tankmanData.inCurrentTank;
         if(!this.inCurrentTank)
         {
            this.inTank = this._tankmanData.inTank;
         }
         this.btnDismiss.enabled = this._tankmanData.actionBtnEnabled;
         this.btnDismiss.label = this._tankmanData.actionBtnLabel;
         this.btnDismiss.soundId = this._inTank || this._inCurrentTank ? SOUND_ID_BTN_UPLOADED : SOUND_ID_BTN_DISMISS;
         this.btnDismiss.soundType = SoundTypes.NORMAL_BTN;
         this.btnDismiss.validateNow();
         invalidate(INVALIDATE_PARAMS);
         validateNow();
      }
      
      override public function toString() : String
      {
         return TO_STRING_TEXT + name;
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler,false);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler,false);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.btnDismiss.removeEventListener(ButtonEvent.CLICK,this.onBtnDismissButtonEventClickHandler);
         this.btnDismiss.removeEventListener(MouseEvent.MOUSE_DOWN,this.onBtnDismissMouseDownHandler);
         this.btnDismiss.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnDismissRollOverHandler,false);
         this.btnDismiss.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnDismissRollOutHandler,false);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.btnDismiss.focusTarget = null;
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         if(this.iconRole)
         {
            this.iconRole.dispose();
            this.iconRole = null;
         }
         if(this.iconRank)
         {
            this.iconRank.dispose();
            this.iconRank = null;
         }
         this.btnDismiss.dispose();
         this.btnDismiss = null;
         this.emptyPlacesTF = null;
         _data = null;
         this.countField = null;
         this.clickArea = null;
         this.selection = null;
         this.levelSpecializationMain = null;
         this.tankmanName = null;
         this.rank = null;
         this.role = null;
         this.lockMsg = null;
         this.vehicleType = null;
         if(this.price)
         {
            this.price.dispose();
            this.price = null;
         }
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         this.descrField = null;
         this.recoveryPeriodTf = null;
         if(this.skills != null)
         {
            this.skills.dispose();
            this.skills = null;
         }
         if(this._tankmanData)
         {
            this._tankmanData.dispose();
         }
         this._tankmanData = null;
         this._toolTipMgr = null;
         this._utils = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tabChildren = false;
         this.btnDismiss.focusTarget = this;
         this.btnDismiss.addEventListener(ButtonEvent.CLICK,this.onBtnDismissButtonEventClickHandler);
         this.btnDismiss.addEventListener(MouseEvent.MOUSE_DOWN,this.onBtnDismissMouseDownHandler);
         this.icon.mouseEnabled = this.iconRole.mouseEnabled = this.iconRank.mouseEnabled = false;
         this.icon.mouseChildren = this.iconRole.mouseChildren = this.iconRank.mouseChildren = false;
         addEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.onClickHandler,false);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.btnDismiss.addEventListener(MouseEvent.ROLL_OVER,this.onBtnDismissRollOverHandler,false,0,true);
         this.btnDismiss.addEventListener(MouseEvent.ROLL_OUT,this.onBtnDismissRollOutHandler,false,0,true);
         mouseChildren = true;
         this.clickArea.buttonMode = true;
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._empty)
         {
            return Vector.<String>([PREFIX_EMPTY]);
         }
         if(this._buy)
         {
            return Vector.<String>([PREFIX_BUY]);
         }
         if(_selected)
         {
            return Vector.<String>([PREFIX_SELECTED,Values.EMPTY_STR]);
         }
         return Vector.<String>([Values.EMPTY_STR]);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Point = null;
         var _loc3_:ActionPriceVO = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:TextFormat = null;
         super.draw();
         if(!_baseDisposed)
         {
            if(isInvalid(INVALIDATE_IN_TANK) && this.selection)
            {
               _loc1_ = SELECTION_STATE_BARRACKS;
               if(this._inTank)
               {
                  _loc1_ = SELECTION_STATE_TANK;
               }
               if(this._inCurrentTank)
               {
                  _loc1_ = SELECTION_STATE_CURRENT_TANK;
               }
               this.selection.gotoAndPlay(_loc1_);
            }
            if(isInvalid(INVALIDATE_PARAMS) && data)
            {
               _loc2_ = new Point(mouseX,mouseY);
               _loc2_ = localToGlobal(_loc2_);
               if(hitTestPoint(_loc2_.x,_loc2_.y,true) && this._isMouseOver)
               {
                  if(this.btnDismiss.hitTestPoint(_loc2_.x,_loc2_.y,true) && !(this._buy || this.empty))
                  {
                     this.onBtnDismissRollOverHandler(null);
                  }
                  else
                  {
                     dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
                  }
               }
               this.countField.text = Values.EMPTY_STR;
               if(this._buy)
               {
                  if(this.price)
                  {
                     this.price.textColor = IconText.BASE_COLOR;
                     this.price.text = this._utils.locale.gold(this._tankmanData.price);
                     this.price.visible = true;
                  }
                  if(this.actionPrice)
                  {
                     _loc3_ = this._tankmanData.actionPriceData;
                     if(_loc3_)
                     {
                        _loc3_.forCredits = false;
                        this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                     }
                     this.actionPrice.setData(_loc3_);
                     this.actionPrice.setup(this);
                     if(this.price)
                     {
                        this.price.visible = !this.actionPrice.visible;
                     }
                  }
                  this.countField.text = PLUS + this._tankmanData.count;
                  this.descrField.text = this._utils.locale.makeString(MENU.BARRACKS_BTNBUYBERTHDECS);
                  this.descrField.replaceText(this.descrField.text.indexOf(CHAR_LEFT_BRACES),this.descrField.text.indexOf(CHAR_RIGHT_BRACES) + 1,String(this._tankmanData.count));
               }
               if(this.empty)
               {
                  this.emptyPlacesTF.text = this._utils.locale.makeString(MENU.BARRACKS_BARRACKSRENDERER_PLACESCOUNT) + Values.SPACE_STR + this._tankmanData.freePlaces;
               }
               if(this.role)
               {
                  this.role.htmlText = this._tankmanData.role;
               }
               if(!(this._buy || this.empty))
               {
                  _loc4_ = this._tankmanData.specializationLevel + CHAR_PERCENT;
                  if(!this._tankmanData.notRecruited)
                  {
                     _loc5_ = this._utils.locale.makeString(MENU.tankmen(this._tankmanData.tankType));
                     if(!this._tankmanData.isInSelfVehicleClass)
                     {
                        this.levelSpecializationMain.htmlText = this.formatDebuffHtmlText(_loc4_);
                        this.role.htmlText += CHAR_COMMA + this.formatDebuffHtmlText(_loc5_ + Values.SPACE_STR + this._tankmanData.vehicleType);
                     }
                     else if(!this._tankmanData.isInSelfVehicleType)
                     {
                        this.levelSpecializationMain.htmlText = this.formatDebuffHtmlText(_loc4_);
                        this.role.htmlText += CHAR_COMMA + _loc5_ + this.formatDebuffHtmlText(this._tankmanData.vehicleType);
                     }
                     else
                     {
                        this.levelSpecializationMain.htmlText = _loc4_;
                        this.role.htmlText += CHAR_COMMA + Values.SPACE_STR + _loc5_ + Values.SPACE_STR + this._tankmanData.vehicleType;
                     }
                  }
                  else
                  {
                     this.levelSpecializationMain.htmlText = _loc4_;
                  }
                  if(StringUtils.isNotEmpty(this._tankmanData.lockMessage))
                  {
                     this.tankmanName.width = width - this.tankmanName.x - this.lockMsg.width;
                  }
                  App.utils.commons.truncateTextFieldText(this.tankmanName,this._tankmanData.fullName,true,false);
                  this.rank.visible = this._tankmanData.isRankNameVisible && StringUtils.isNotEmpty(this._tankmanData.rank);
                  if(this.rank.visible)
                  {
                     this.rank.text = this._tankmanData.rank;
                     _loc6_ = !!this._tankmanData.notRecruited ? uint(NOT_RECRUITED_DATE_COLOR) : uint(RANK_NAME_COLOR);
                     _loc7_ = this.rank.getTextFormat();
                     if(_loc7_.color != _loc6_)
                     {
                        _loc7_.color = _loc6_;
                        this.rank.setTextFormat(_loc7_);
                     }
                  }
                  this.skills.visible = this._tankmanData.isSkillsVisible;
                  if(this.skills.visible)
                  {
                     this.skills.updateSkills(this._tankmanData);
                  }
                  this.lockMsg.text = this._tankmanData.lockMessage;
                  this.recoveryPeriodTf.visible = StringUtils.isNotEmpty(this._tankmanData.recoveryPeriodText);
                  if(this.recoveryPeriodTf.visible)
                  {
                     this.recoveryPeriodTf.htmlText = this._tankmanData.recoveryPeriodText;
                  }
               }
            }
         }
      }
      
      private function updateControlsState() : void
      {
         var _loc1_:Boolean = !(this._buy || this._empty);
         this.icon.visible = this.iconRole.visible = this.btnDismiss.visible = _loc1_;
         this.iconRank.visible = _loc1_ && !this._tankmanData.notRecruited;
         if(this.buy)
         {
            soundType = SoundTypes.BARRACKS_BUY_SOUND_TYPE;
         }
         else if(this.empty)
         {
            soundType = SoundTypes.BARRACKS_EMPTY_SOUND_TYPE;
         }
         else
         {
            soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
         }
      }
      
      private function formatDebuffHtmlText(param1:String) : String
      {
         return HTML_FONT_START + Colors.ERROR_COLOR + HTML_FONT_END + param1 + HTML_FONT_TAG_CLOSE;
      }
      
      private function isDismissBtn(param1:Object) : Boolean
      {
         return param1 == this.btnDismiss;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      public function get inTank() : Boolean
      {
         return this._inTank;
      }
      
      public function set inTank(param1:Boolean) : void
      {
         if(this._inTank == param1)
         {
            return;
         }
         this._inTank = param1;
         invalidate(INVALIDATE_IN_TANK);
      }
      
      public function get inCurrentTank() : Boolean
      {
         return this._inCurrentTank;
      }
      
      public function set inCurrentTank(param1:Boolean) : void
      {
         if(this._inCurrentTank == param1)
         {
            return;
         }
         this._inCurrentTank = param1;
         invalidate(INVALIDATE_IN_TANK);
      }
      
      public function get empty() : Boolean
      {
         return this._empty;
      }
      
      public function set empty(param1:Boolean) : void
      {
         this._empty = param1;
         this.updateControlsState();
         setState(ComponentState.UP);
      }
      
      public function get buy() : Boolean
      {
         return this._buy;
      }
      
      public function set buy(param1:Boolean) : void
      {
         this._buy = param1;
         this.updateControlsState();
         setState(ComponentState.UP);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this._isMouseOver = true;
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._isMouseOver = false;
      }
      
      private function onBtnDismissButtonEventClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CrewEvent(CrewEvent.ACT_TANKMAN,data));
         this._toolTipMgr.hide();
      }
      
      private function onBtnDismissMouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function onButtonEventClickHandler(param1:ButtonEvent) : void
      {
         if(this.isDismissBtn(param1.target))
         {
            return;
         }
         if(this._empty)
         {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_RECRUIT_WINDOW,null,true));
         }
         else if(this._buy)
         {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_BERTH_BUY_DIALOG));
         }
      }
      
      private function onBtnDismissRollOverHandler(param1:MouseEvent) : void
      {
         setState(ComponentState.OUT);
         if(StringUtils.isNotEmpty(this._tankmanData.actionBtnTooltip))
         {
            this._toolTipMgr.showComplex(this._tankmanData.actionBtnTooltip);
         }
      }
      
      private function onBtnDismissRollOutHandler(param1:MouseEvent = null) : void
      {
         setState(ComponentState.OVER);
         this._toolTipMgr.hide();
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OUT,true,true,-1,-1,-1,null,data));
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this.isDismissBtn(param1.target))
         {
            return;
         }
         if(this._utils.commons.isRightButton(param1) && (!this._buy && !this._empty))
         {
            dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE,data,false,0));
         }
      }
   }
}
