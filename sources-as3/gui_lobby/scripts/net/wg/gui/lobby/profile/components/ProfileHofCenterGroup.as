package net.wg.gui.lobby.profile.components
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   
   public class ProfileHofCenterGroup extends UIComponentEx
   {
      
      private static const INVALIDATE_BTN_COUNTERS:String = "invBtnCounters";
       
      
      public var achievementsBtn:SoundButtonEx = null;
      
      public var vehiclesBtn:SoundButtonEx = null;
      
      public var iconAchievementsTf:TextField = null;
      
      public var iconVehiclesTf:TextField = null;
      
      private var _counterManager:ICounterManager;
      
      private var _countersToSet:Vector.<CountersVo> = null;
      
      private var _actualCounters:Vector.<SoundButtonEx>;
      
      public function ProfileHofCenterGroup()
      {
         this._counterManager = App.utils.counterManager;
         this._actualCounters = new Vector.<SoundButtonEx>();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.iconAchievementsTf.text = PROFILE.SECTION_HOF_ACHIEVEMENTSRATINGSTITLE;
         this.iconVehiclesTf.text = PROFILE.SECTION_HOF_VEHICLESRATINGSTITLE;
         this.achievementsBtn.label = PROFILE.SECTION_HOF_ACHIEVEMENTSRATINGSBTN;
         this.achievementsBtn.dynamicSizeByText = true;
         this.achievementsBtn.changeSizeOnlyUpwards = true;
         this.vehiclesBtn.label = PROFILE.SECTION_HOF_VEHICLESRATINGSBTN;
         this.vehiclesBtn.dynamicSizeByText = true;
         this.vehiclesBtn.changeSizeOnlyUpwards = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:ICounterProps = null;
         super.draw();
         if(this._countersToSet && isInvalid(INVALIDATE_BTN_COUNTERS))
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = Values.EMPTY_STR;
            _loc4_ = null;
            _loc5_ = new CounterProps(CounterProps.DEFAULT_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y);
            this.removeCounters();
            _loc2_ = this._countersToSet.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this._countersToSet[_loc1_].componentId;
               _loc4_ = getChildByName(_loc3_);
               App.utils.asserter.assertNotNull(_loc4_,_loc3_ + " " + Errors.CANT_NULL);
               this._counterManager.setCounter(_loc4_,this._countersToSet[_loc1_].count,null,_loc5_);
               this._actualCounters.push(_loc4_);
               _loc1_++;
            }
         }
      }
      
      public function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         this._countersToSet = param1;
         invalidate(INVALIDATE_BTN_COUNTERS);
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this.achievementsBtn.dispose();
         this.achievementsBtn = null;
         this.vehiclesBtn.dispose();
         this.vehiclesBtn = null;
         if(this._countersToSet)
         {
            this._countersToSet.splice(0,this._countersToSet.length);
            this._countersToSet = null;
         }
         this.removeCounters();
         this._actualCounters = null;
         this._counterManager = null;
      }
      
      private function removeCounters() : void
      {
         if(this._actualCounters)
         {
            while(this._actualCounters.length)
            {
               this._counterManager.removeCounter(this._actualCounters.pop());
            }
         }
      }
   }
}
