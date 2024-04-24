package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsPlanRegionVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionsPlanRegion extends SoundButtonEx
   {
      
      private static const PREFIX_RED:String = "red_";
      
      private static const PREFIX_GREEN:String = "green_";
      
      private static const PREFIX_YELLOW:String = "yellow_";
      
      private static const PREFIX_EMERALD:String = "emerald_";
      
      private static const UNDERSCORE:String = "_";
      
      private static const SHEET_IMG_X_OFFSET:int = 26;
      
      private static const SHEET_IMG_Y_OFFSET:int = 23;
      
      private static const DOUBLE_CHECK_IMG_X_OFFSET:int = -10;
      
      private static const DOUBLE_CHECK_IMG_Y_OFFSET:int = -11;
      
      private static const OPERATIONS:Array = ["Alliance-USSR","Alliance-Germany","Alliance-USA","Alliance-France"];
      
      private static const SECOND_CAMPAIGN_LABEL:String = "secondCampaign";
       
      
      public var img:Sprite = null;
      
      public var imgDisabled:Sprite = null;
      
      public var digit:PersonalMissionsPlanRegionDigit = null;
      
      public var redBG:Sprite = null;
      
      public var checkImg:PersonalMissionsPlanRegionCheck = null;
      
      public var sheetImg:IImage = null;
      
      private var _image:Sprite = null;
      
      private var _regionState:int = -1;
      
      private var _id:Number = -1;
      
      private var _model:PersonalMissionsPlanRegionVO = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _prevState:String;
      
      private var _isLocked:Boolean = false;
      
      public function PersonalMissionsPlanRegion()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         focusable = false;
      }
      
      private static function getOperationPrefix(param1:String) : String
      {
         if(OPERATIONS.indexOf(param1) >= 0)
         {
            return SECOND_CAMPAIGN_LABEL;
         }
         return param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._image = this.img;
         this.img.buttonMode = this.img.useHandCursor = true;
         if(this.imgDisabled != null)
         {
            this.imgDisabled.buttonMode = this.imgDisabled.useHandCursor = true;
         }
         this.digit.mouseChildren = this.digit.mouseEnabled = false;
         this.redBG.mouseChildren = this.redBG.mouseEnabled = false;
         this.sheetImg.mouseChildren = this.sheetImg.mouseEnabled = false;
         this.checkImg.visible = false;
         this.checkImg.mouseChildren = this.checkImg.mouseEnabled = false;
         this.redBG.x = this.digit.x + (this.digit.width - this.redBG.width >> 1);
         this.redBG.y = this.digit.y + (this.digit.height - this.redBG.height >> 1);
         soundEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this._regionState = this._model.state;
            this._id = this._model.id;
            this._isLocked = this._model.isLocked;
            this.applyRegionState();
            _loc1_ = PersonalMissionsPlanRegionDigit.DIGIT_NORMAL_STATE;
            if(this._isLocked)
            {
               if(this._model.isFinal && this._regionState != PERSONAL_MISSIONS_ALIASES.REGION_DISABLED)
               {
                  _loc1_ = PersonalMissionsPlanRegionDigit.DIGIT_COMBINE_STATE;
               }
               else
               {
                  _loc1_ = PersonalMissionsPlanRegionDigit.DIGIT_LOCK_STATE;
               }
            }
            else if(this._model.isOnPause)
            {
               _loc1_ = PersonalMissionsPlanRegionDigit.DIGIT_ON_PAUSE_STATE;
            }
            this.digit.setDigitState(_loc1_);
            buttonMode = useHandCursor = this.isEnabled();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.setState(_state);
            this.img.visible = true;
            this._image = this.img;
            if(this.imgDisabled != null)
            {
               if(this._isLocked)
               {
                  this.imgDisabled.visible = true;
                  this.img.visible = false;
                  this._image = this.imgDisabled;
               }
               else
               {
                  this.imgDisabled.visible = false;
               }
            }
         }
      }
      
      override protected function setState(param1:String) : void
      {
         if(!this.isEnabled() || StringUtils.isEmpty(param1))
         {
            param1 = ComponentState.UP;
         }
         if((this._prevState == ComponentState.DOWN || this._prevState == ComponentState.RELEASE) && param1 == ComponentState.OUT)
         {
            this._prevState = param1;
            return;
         }
         gotoAndPlay(this.getStatePrefix() + param1);
         var _loc2_:String = this.getComponentStatePrefix() + param1;
         this.digit.gotoAndPlay(_loc2_);
         if(this.checkImg.visible)
         {
            this.checkImg.gotoAndPlay(_loc2_);
         }
         this._prevState = param1;
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.checkImg.stop();
         this.img = null;
         this.imgDisabled = null;
         this.digit.dispose();
         this.digit = null;
         this.redBG = null;
         this.checkImg.dispose();
         this.checkImg = null;
         this.sheetImg.dispose();
         this.sheetImg = null;
         this._model = null;
         this._tooltipMgr = null;
         this._image = null;
         super.onDispose();
      }
      
      override protected function showTooltip() : void
      {
         if(this._model && this._model.tooltipData)
         {
            if(this._model.tooltipData.isSpecial)
            {
               this._tooltipMgr.showSpecial.apply(this,[this._model.tooltipData.specialAlias,null].concat(this._model.tooltipData.specialArgs));
            }
            else
            {
               this._tooltipMgr.showComplex(this._model.tooltipData.tooltip);
            }
         }
      }
      
      public function isEnabled() : Boolean
      {
         return this._regionState != PERSONAL_MISSIONS_ALIASES.REGION_DISABLED;
      }
      
      public function setData(param1:PersonalMissionsPlanRegionVO) : void
      {
         if(param1 != null && this._model != param1)
         {
            this._model = param1;
            invalidateData();
         }
      }
      
      private function getStatePrefix() : String
      {
         switch(this._regionState)
         {
            case PERSONAL_MISSIONS_ALIASES.REGION_NOT_AVAILABLE:
            case PERSONAL_MISSIONS_ALIASES.REGION_DISABLED:
               return PREFIX_RED;
            case PERSONAL_MISSIONS_ALIASES.REGION_COMPLETED:
               return PREFIX_GREEN;
            case PERSONAL_MISSIONS_ALIASES.REGION_FULLY_COMPLETED:
               return PREFIX_EMERALD;
            case PERSONAL_MISSIONS_ALIASES.REGION_ON_PAUSE:
            case PERSONAL_MISSIONS_ALIASES.REGION_IN_PROGRESS:
               return PREFIX_YELLOW;
            default:
               App.utils.asserter.assert(true,Errors.WRONG_VALUE + " of region state: " + this._regionState);
               return Values.EMPTY_STR;
         }
      }
      
      private function getComponentStatePrefix() : String
      {
         switch(this._regionState)
         {
            case PERSONAL_MISSIONS_ALIASES.REGION_NOT_COMPLETED:
            case PERSONAL_MISSIONS_ALIASES.REGION_NOT_AVAILABLE:
               return !!StringUtils.isNotEmpty(this._model.vehType) ? getOperationPrefix(this._model.vehType) + UNDERSCORE : PREFIX_RED;
            case PERSONAL_MISSIONS_ALIASES.REGION_DISABLED:
               return PREFIX_RED;
            case PERSONAL_MISSIONS_ALIASES.REGION_COMPLETED:
            case PERSONAL_MISSIONS_ALIASES.REGION_FULLY_COMPLETED:
               return PREFIX_GREEN;
            case PERSONAL_MISSIONS_ALIASES.REGION_ON_PAUSE:
            case PERSONAL_MISSIONS_ALIASES.REGION_IN_PROGRESS:
               return PREFIX_YELLOW;
            default:
               App.utils.asserter.assert(true,Errors.WRONG_VALUE + " of region state: " + this._regionState);
               return Values.EMPTY_STR;
         }
      }
      
      private function applyRegionState() : void
      {
         this.checkImg.visible = false;
         this.sheetImg.visible = false;
         this.redBG.visible = false;
         switch(this._regionState)
         {
            case PERSONAL_MISSIONS_ALIASES.REGION_COMPLETED:
               if(this._model.isTokenPawned)
               {
                  this.sheetImg.x = this.digit.x + SHEET_IMG_X_OFFSET;
                  this.sheetImg.y = this.digit.y + SHEET_IMG_Y_OFFSET;
                  this.sheetImg.source = this._model.sheet;
                  this.sheetImg.visible = true;
               }
               break;
            case PERSONAL_MISSIONS_ALIASES.REGION_FULLY_COMPLETED:
               this.checkImg.x = this.digit.x + DOUBLE_CHECK_IMG_X_OFFSET;
               this.checkImg.y = this.digit.y + DOUBLE_CHECK_IMG_Y_OFFSET;
               this.checkImg.checkmarkImg.source = RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_CHECK_DOUBLE;
               this.checkImg.visible = true;
               break;
            case PERSONAL_MISSIONS_ALIASES.REGION_IN_PROGRESS:
            case PERSONAL_MISSIONS_ALIASES.REGION_ON_PAUSE:
               if(this._model.isTokenPawned)
               {
                  this.sheetImg.x = this.digit.x + SHEET_IMG_X_OFFSET;
                  this.sheetImg.y = this.digit.y + SHEET_IMG_Y_OFFSET;
                  this.sheetImg.source = this._model.sheet;
                  this.sheetImg.visible = true;
               }
               this.redBG.visible = true;
         }
         invalidateState();
      }
      
      public function get regionState() : int
      {
         return this._regionState;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get image() : Sprite
      {
         return this._image;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showTooltip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._tooltipMgr.hide();
      }
   }
}
