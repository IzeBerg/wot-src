package net.wg.gui.battle.commander.views.common
{
   import net.wg.data.constants.Time;
   
   public class ReloadingData
   {
      
      private static const RELOAD_FREEZE:Number = -1;
      
      private static const RELOAD_NO_AMMO:Number = -2;
      
      private static const RELOAD_END_TIME:Number = 0.01;
       
      
      private var _baseTime:Number = NaN;
      
      private var _timeLeft:Number = NaN;
      
      private var _updateTime:Number = NaN;
      
      public function ReloadingData()
      {
         super();
      }
      
      public function update() : void
      {
         var _loc1_:Number = NaN;
         if(this.isReloading)
         {
            _loc1_ = new Date().time / Time.MILLISECOND_IN_SECOND;
            this._timeLeft -= _loc1_ - this._updateTime;
            this._updateTime = _loc1_;
         }
      }
      
      public function updateValues(param1:Number, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Boolean = false;
         if(this._updateTime != param1)
         {
            this._updateTime = param1;
            _loc4_ = true;
         }
         if(this._timeLeft != param2)
         {
            this._timeLeft = param2;
            _loc4_ = true;
         }
         if(this._baseTime != param3)
         {
            this._baseTime = param3;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            this.update();
         }
         return _loc4_;
      }
      
      public function get isNoAmmo() : Boolean
      {
         return this._timeLeft == RELOAD_NO_AMMO;
      }
      
      public function get isFreeze() : Boolean
      {
         return this._timeLeft == RELOAD_FREEZE;
      }
      
      public function get isReloading() : Boolean
      {
         return this._timeLeft > RELOAD_END_TIME;
      }
      
      public function get isUpdateRequired() : Boolean
      {
         return this.isReloading;
      }
      
      public function get value() : Number
      {
         return !!this.isReloading ? Number(this._timeLeft) : Number(this._baseTime);
      }
   }
}
