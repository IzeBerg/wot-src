package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.FrameLabel;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionVehicleAwardVO;
   import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
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
      
      private var _vehicleRewardData:PersonalMissionVehicleAwardVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      public function PersonalMissionExtraAwardAnim()
      {
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
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vehicleRewardData && isInvalid(InvalidationType.DATA))
         {
            this.vehicleDesk.setDesc(this._vehicleRewardData.vehicleTypeIcon,this._vehicleRewardData.vehicleLevel,this._vehicleRewardData.vehicleName);
            this.vehicle.setVehicleSrc(this._vehicleRewardData.vehicleSrc);
         }
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
      }
      
      private function onFadeOutComplete() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_OUT_COMPLETE));
      }
      
      private function onMoveStarted() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.MOVE_START));
      }
   }
}
