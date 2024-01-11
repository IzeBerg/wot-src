package net.wg.gui.lobby.personalMissions.components
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.common.FrameStatesContainer;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class OperationButton extends SoundButtonEx
   {
      
      private static const STATES_CURRENT:Vector.<String> = Vector.<String>(["current_",""]);
      
      private static const STATES_UNLOCKED:Vector.<String> = Vector.<String>(["unlocked_",""]);
      
      private static const STATES_LOCKED:Vector.<String> = Vector.<String>(["locked_",""]);
      
      private static const STATES_COMPLETED:Vector.<String> = Vector.<String>(["completed_",""]);
      
      private static const STATES_POSTPONED:Vector.<String> = Vector.<String>(["postponed_",""]);
      
      private static const STATE_UP:String = "up";
      
      private static const FRAME_STATE_PREFIX:String = "operation";
      
      private static const ARROW_POSTFIX_UNLOCKED:String = "_unlocked";
      
      private static const ARROW_POSTFIX_LOCKED:String = "_locked";
      
      private static const HIT_POSTFIX_CURRENT:String = "_current";
      
      private static const HIT_POSTFIX_LOCKED:String = "_locked";
      
      private static const UNDERSCORE:String = "_";
       
      
      public var icon:UILoaderAlt = null;
      
      public var arrow:FrameStateCmpnt = null;
      
      public var hitFrames:FrameStateCmpnt = null;
      
      public var unlockedHover:FrameStatesContainer = null;
      
      public var glowMc:FrameStateCmpnt = null;
      
      public var postponed:OperationButtonPostponed = null;
      
      public var badges:FrameStateCmpnt = null;
      
      private var _dataVo:OperationDataVO = null;
      
      private var _operationState:String = "";
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function OperationButton()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      private static function getArrowState(param1:String, param2:String) : String
      {
         var _loc3_:String = param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE || param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_DISABLED_STATE || param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_POSTPONED_STATE ? ARROW_POSTFIX_LOCKED : ARROW_POSTFIX_UNLOCKED;
         return param1 + _loc3_;
      }
      
      private static function getHitState(param1:String, param2:String) : String
      {
         var _loc3_:String = param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_CURRENT_STATE || param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_UNLOCKED_STATE ? HIT_POSTFIX_CURRENT : HIT_POSTFIX_LOCKED;
         return param1 + _loc3_;
      }
      
      private static function getBadgeState(param1:String, param2:String) : String
      {
         if(param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_COMPLETE_STATE || param2 == PERSONAL_MISSIONS_ALIASES.OPERATION_COMPLETE_FULL_STATE)
         {
            return param1 + UNDERSCORE + param2;
         }
         return Values.EMPTY_STR;
      }
      
      private static function getFrameState(param1:int) : String
      {
         return FRAME_STATE_PREFIX + param1.toString();
      }
      
      override protected function preInitialize() : void
      {
         _state = STATE_UP;
         preventAutosizing = true;
         constraintsDisabled = true;
         super.preInitialize();
      }
      
      override protected function showTooltip() : void
      {
         if(this._dataVo)
         {
            this._tooltipMgr.showSpecial(this._dataVo.tooltipAlias,null,this._dataVo.id);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitArea = this.hitFrames;
         this.icon.autoSize = false;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.postponed.visible = false;
         this.badges.visible = false;
         addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         mouseEnabledOnDisabled = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         if(this._dataVo && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._dataVo.icon;
            this.unlockedHover.visible = this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_CURRENT_STATE || this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_UNLOCKED_STATE;
            this.unlockedHover.frameLabel = this._operationState;
            this.glowMc.frameLabel = this._operationState;
            this.arrow.frameLabel = getArrowState(this._operationState,this._dataVo.state);
            this.hitFrames.frameLabel = getHitState(this._operationState,this._dataVo.state);
            _loc1_ = getBadgeState(this._operationState,this._dataVo.state);
            if(StringUtils.isNotEmpty(_loc1_))
            {
               this.badges.visible = true;
               this.badges.frameLabel = _loc1_;
            }
            else
            {
               this.badges.visible = false;
            }
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_POSTPONED_STATE && StringUtils.isNotEmpty(this._dataVo.postponedTime))
            {
               this.postponed.label = this._dataVo.postponedTime;
               this.postponed.visible = true;
            }
            else
            {
               this.postponed.visible = false;
            }
         }
         super.draw();
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.hitArea = null;
         this.hitFrames.dispose();
         this.hitFrames = null;
         this.unlockedHover.dispose();
         this.unlockedHover = null;
         this.glowMc.dispose();
         this.glowMc = null;
         this.badges.dispose();
         this.badges = null;
         this._dataVo = null;
         this.arrow.dispose();
         this.arrow = null;
         this.icon.dispose();
         this.icon = null;
         this.postponed.dispose();
         this.postponed = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._dataVo)
         {
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_CURRENT_STATE)
            {
               return STATES_CURRENT;
            }
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_UNLOCKED_STATE)
            {
               return STATES_UNLOCKED;
            }
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE || this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_DISABLED_STATE)
            {
               return STATES_LOCKED;
            }
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_COMPLETE_STATE || this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_COMPLETE_FULL_STATE)
            {
               return STATES_COMPLETED;
            }
            if(this._dataVo.state == PERSONAL_MISSIONS_ALIASES.OPERATION_POSTPONED_STATE)
            {
               return STATES_POSTPONED;
            }
         }
         return statesDefault;
      }
      
      override public function set data(param1:Object) : void
      {
         this._dataVo = OperationDataVO(param1);
         super.data = param1;
         enabled = this._dataVo.enabled;
         this._operationState = getFrameState(this._dataVo.id);
         setState(state);
         invalidateData();
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.icon.x = -this.icon.width >> 1;
         this.icon.y = -this.icon.height >> 1;
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new OperationEvent(OperationEvent.CLICK,this._dataVo.id,this._dataVo.pmType,true));
      }
   }
}
