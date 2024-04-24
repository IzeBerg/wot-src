package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionVehicleAwardVO;
   import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionExtraAwardAnim extends UIComponentEx
   {
      
      private static const MOVE_START_LABEL:String = "moveStart";
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
      
      private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";
       
      
      public var vehicleDesk:PersonalMissionExtraAwardDesc = null;
      
      public var vehicle:PersonalMissionVehicleAward = null;
      
      public var vehicleHitArea:Sprite = null;
      
      private var _vehicleRewardData:PersonalMissionVehicleAwardVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function PersonalMissionExtraAwardAnim()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         mouseEnabled = mouseChildren = false;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeInComplete);
            }
            else if(_loc3_.name == FADE_OUT_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutComplete);
            }
            else if(_loc3_.name == MOVE_START_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onMoveStarted);
            }
            _loc4_++;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleRollOverHandler);
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vehicleRewardData && isInvalid(InvalidationType.DATA))
         {
            this.vehicleDesk.setDesc(this._vehicleRewardData.vehicleTypeIcon,this._vehicleRewardData.vehicleLevel,this._vehicleRewardData.vehicleName);
            this.vehicle.setVehicleSrc(this._vehicleRewardData.vehicleSrc);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleRollOverHandler);
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         stop();
         this._frameHelper.dispose();
         this._frameHelper = null;
         this._vehicleRewardData = null;
         this.vehicleDesk.dispose();
         this.vehicleDesk = null;
         this.vehicle.dispose();
         this.vehicle = null;
         this.vehicleHitArea = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function fadeIn() : void
      {
         gotoAndPlay(FADE_IN_LABEL);
      }
      
      public function fadeOut() : void
      {
         gotoAndPlay(FADE_OUT_LABEL);
      }
      
      public function setData(param1:PersonalMissionVehicleAwardVO) : void
      {
         this._vehicleRewardData = param1;
         invalidateData();
      }
      
      private function onFadeInComplete() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_IN_COMPLETE));
         this.updateMouseEnabled();
      }
      
      private function updateMouseEnabled() : void
      {
         var _loc3_:InteractiveObject = null;
         var _loc1_:uint = numChildren;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = getChildAt(_loc2_) as InteractiveObject;
            if(_loc3_ && _loc3_ != this.vehicleHitArea)
            {
               _loc3_.mouseEnabled = false;
               if(_loc3_ is DisplayObjectContainer)
               {
                  (_loc3_ as DisplayObjectContainer).mouseChildren = false;
               }
            }
            _loc2_++;
         }
         mouseChildren = true;
      }
      
      private function onFadeOutComplete() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_OUT_COMPLETE));
      }
      
      private function onMoveStarted() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.MOVE_START));
      }
      
      private function onVehicleRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = this._vehicleRewardData.tooltip;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.isSpecial)
         {
            this._toolTipMgr.showSpecial.apply(this,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
         }
         else
         {
            this._toolTipMgr.showComplex(_loc2_.tooltip);
         }
      }
      
      private function onVehicleRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
