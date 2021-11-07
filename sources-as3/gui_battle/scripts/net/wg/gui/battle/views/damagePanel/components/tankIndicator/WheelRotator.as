package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   import net.wg.utils.IClassFactory;
   
   public class WheelRotator extends SPGRotator
   {
      
      private static const WHEEL:String = "wheel";
      
      private static const Y_OFFSET:int = -56;
      
      private static const LEFT_OFFSET:int = -30;
      
      private static const RIGHT_OFFSET:int = 22;
      
      private static const WHEEL_Y_DELTA:int = 87;
      
      private static const SLAVE_WHEEL_ALPHA:Number = 0.4;
      
      private static const SLAVE_WHEEL_HALF_COUNT:int = 2;
       
      
      private var _wheels:Vector.<Wheel>;
      
      private var _classFactory:IClassFactory;
      
      public function WheelRotator()
      {
         this._wheels = new Vector.<Wheel>(0);
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override public function reset() : void
      {
         super.reset();
         var _loc1_:int = this._wheels.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._wheels[_loc2_].state = BATTLE_ITEM_STATES.NORMAL;
            _loc2_++;
         }
      }
      
      override public function setModuleState(param1:String, param2:String) : void
      {
         var _loc3_:DamagePanelItemFrameStates = DamagePanelItemFrameStates(this.getChildByName(param1));
         App.utils.asserter.assert(_loc3_ != null,"Not valid moduleName = " + param1);
         _loc3_.state = param2;
      }
      
      override public function showDestroyed() : void
      {
         var _loc2_:DamagePanelItemFrameStates = null;
         super.showDestroyed();
         var _loc1_:int = this._wheels.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = DamagePanelItemFrameStates(this._wheels[_loc3_]);
            _loc2_.state = BATTLE_ITEM_STATES.DESTROYED;
            _loc3_++;
         }
      }
      
      override protected function onDispose() : void
      {
         this.cleanWheels();
         this._wheels = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function setSpeedMode(param1:Boolean) : void
      {
         var _loc2_:Number = !!param1 ? Number(SLAVE_WHEEL_ALPHA) : Number(Values.DEFAULT_ALPHA);
         var _loc3_:int = this._wheels.length - SLAVE_WHEEL_HALF_COUNT;
         var _loc4_:int = SLAVE_WHEEL_HALF_COUNT;
         while(_loc4_ < _loc3_)
         {
            this._wheels[_loc4_].alpha = _loc2_;
            _loc4_++;
         }
      }
      
      public function setWheelCount(param1:int) : void
      {
         var _loc3_:Wheel = null;
         var _loc4_:Wheel = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this._wheels.length > 0)
         {
            this.cleanWheels();
         }
         var _loc2_:int = param1 >> 1;
         var _loc7_:int = WHEEL_Y_DELTA / (_loc2_ - 1);
         var _loc8_:int = 0;
         while(_loc8_ < _loc2_)
         {
            _loc3_ = this._classFactory.getComponent(Linkages.WHEEL,Wheel);
            _loc4_ = this._classFactory.getComponent(Linkages.WHEEL,Wheel);
            _loc5_ = Y_OFFSET + _loc7_ * _loc8_;
            _loc6_ = (_loc2_ - _loc8_) * 2 - 1;
            _loc4_.x = LEFT_OFFSET;
            _loc4_.y = _loc5_;
            _loc4_.alwaysVisible = true;
            _loc4_.name = WHEEL + (_loc6_ - 1);
            addChild(_loc4_);
            this._wheels.push(_loc4_);
            _loc3_.x = RIGHT_OFFSET;
            _loc3_.y = _loc5_;
            _loc3_.alwaysVisible = true;
            _loc3_.name = WHEEL + _loc6_;
            addChild(_loc3_);
            this._wheels.push(_loc3_);
            _loc8_++;
         }
      }
      
      private function cleanWheels() : void
      {
         var _loc1_:Wheel = null;
         for each(_loc1_ in this._wheels)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._wheels.splice(0,this._wheels.length);
      }
   }
}
