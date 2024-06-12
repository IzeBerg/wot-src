package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import net.wg.gui.rally.interfaces.IManualSearchRenderer;
   import net.wg.gui.rally.vo.RallyCandidateVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   [Event(name="newPageRequest",type="net.wg.gui.cyberSport.controls.events.CSComponentEvent")]
   public class ManualSearchRenderer extends TableRenderer implements IManualSearchRenderer
   {
      
      private static const BADGE_OFFSET_Y:int = -2;
      
      private static const ICONS_GAP:Number = 6;
      
      private static const SLASH:String = "/";
      
      private static const NO_ICONS_OFFSET_X:int = -2;
       
      
      public var commander:TextField = null;
      
      public var commandDescr:TextField = null;
      
      public var commandSize:TextField = null;
      
      public var commandMaxSize:TextField = null;
      
      public var effency:TextField = null;
      
      public var freezeIcon:MovieClip;
      
      public var restrictionIcon:MovieClip;
      
      public var inBattleMC:MovieClip;
      
      private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;
      
      private var _creatorName:String = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _originalDescrWidth:Number;
      
      private var _originalDescrX:Number;
      
      private var _isHovered:Boolean;
      
      private var _commanderLabelY:int = -1;
      
      private var _commanderLabelWithBadgeY:int = -1;
      
      public function ManualSearchRenderer()
      {
         super();
         preventAutosizing = true;
         this._userInfoTextLoadingController = new UserInfoTextLoadingController();
         this._tooltipMgr = App.toolTipMgr;
         this._commanderLabelY = this.commander.y;
         this._commanderLabelWithBadgeY = this._commanderLabelY + BADGE_OFFSET_Y;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._originalDescrWidth = this.commandDescr.width;
         this._originalDescrX = this.commandDescr.x;
         this.commander.mouseEnabled = false;
         this.commandSize.mouseEnabled = false;
         this.commandMaxSize.mouseEnabled = false;
         this.effency.mouseEnabled = false;
         this.inBattleMC.mouseEnabled = false;
         this.freezeIcon.useHandCursor = this.freezeIcon.buttonMode = true;
         this.restrictionIcon.useHandCursor = this.restrictionIcon.buttonMode = true;
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this._userInfoTextLoadingController.setControlledUserNameTextField(this.commander);
         this._userInfoTextLoadingController.setControlledUserRatingTextField(this.effency);
      }
      
      override protected function onDispose() : void
      {
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.commander = null;
         this.commandDescr = null;
         this.commandSize = null;
         this.commandMaxSize = null;
         this.effency = null;
         this.freezeIcon = null;
         this.restrictionIcon = null;
         this.inBattleMC = null;
         this._userInfoTextLoadingController.dispose();
         this._userInfoTextLoadingController = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         mouseEnabled = true;
         mouseChildren = true;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = Boolean(data);
            if(visible)
            {
               this.populateUI(CSCommandVO(data));
               startSimulationDoubleClick();
            }
            else
            {
               stopSimulationDoubleClick();
            }
            if(this._isHovered)
            {
               this.showToolTip();
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      protected function showToolTip() : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_TEAM,null,_data);
      }
      
      protected function populateUI(param1:CSCommandVO) : void
      {
         var _loc2_:String = null;
         var _loc7_:IUserProps = null;
         var _loc3_:RallyCandidateVO = param1.creator;
         if(_loc3_)
         {
            _loc7_ = App.utils.commons.getUserProps(_loc3_.userName,_loc3_.clanAbbrev,_loc3_.region,_loc3_.igrType,null);
            _loc7_.rgb = param1.creator.color;
            this._userInfoTextLoadingController.setUserNameFromProps(_loc7_);
            this.commander.y = _loc3_.badgeVisualVO != null ? Number(this._commanderLabelWithBadgeY) : Number(this._commanderLabelY);
            _loc2_ = this.commander.htmlText;
         }
         else
         {
            _loc2_ = Values.EMPTY_STR;
         }
         if(this._creatorName != _loc2_)
         {
            this._creatorName = _loc2_;
         }
         _loc2_ = param1.rating;
         if(_loc2_ != this.effency.text)
         {
            this._userInfoTextLoadingController.setUserRatingHtmlText(_loc2_);
         }
         _loc2_ = String(param1.playersCount);
         if(_loc2_ != this.commandSize.text)
         {
            this.commandSize.text = _loc2_;
         }
         _loc2_ = SLASH + String(param1.commandSize);
         if(_loc2_ != this.commandMaxSize.text)
         {
            this.commandMaxSize.text = _loc2_;
         }
         var _loc4_:Boolean = false;
         var _loc5_:int = this.freezeIcon.x;
         var _loc6_:Boolean = param1.isFreezed;
         this.freezeIcon.visible = _loc6_;
         if(_loc6_)
         {
            _loc4_ = true;
            _loc5_ += this.freezeIcon.width + ICONS_GAP;
         }
         _loc6_ = param1.isRestricted;
         this.restrictionIcon.visible = _loc6_;
         this.restrictionIcon.x = _loc5_;
         if(_loc6_)
         {
            _loc4_ = true;
            _loc5_ += this.restrictionIcon.width + ICONS_GAP;
         }
         _loc6_ = param1.inBattle;
         this.inBattleMC.visible = _loc6_;
         this.inBattleMC.x = _loc5_;
         if(_loc6_)
         {
            _loc4_ = true;
            _loc5_ += this.inBattleMC.width + ICONS_GAP;
         }
         if(!_loc4_)
         {
            _loc5_ += NO_ICONS_OFFSET_X;
         }
         this.commandDescr.x = _loc5_;
         this.commandDescr.width = this._originalDescrWidth - (_loc5_ - this._originalDescrX);
         _loc7_ = App.utils.commons.getUserProps(param1.description,null,null,0);
         App.utils.commons.formatPlayerName(this.commandDescr,_loc7_);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         this._isHovered = true;
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         this._isHovered = false;
         this._tooltipMgr.hide();
         super.handleMouseRollOut(param1);
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(param1.currentTarget == this.freezeIcon ? TOOLTIPS.SETTINGSICON_FREEZED : TOOLTIPS.SETTINGSICON_CONDITIONS);
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
         if(this._isHovered)
         {
            this.showToolTip();
         }
      }
   }
}
