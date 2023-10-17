package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileBaseInfoVO extends DAAPIDataClass
   {
       
      
      public var battlesCount:int = -1;
      
      public var winsCount:int = -1;
      
      public var lossesCount:int = -1;
      
      public function ProfileBaseInfoVO(param1:Object)
      {
         super(param1);
      }
      
      public function getBattlesCountStr() : String
      {
         return App.utils.locale.integer(this.battlesCount);
      }
      
      public function getDrawsCountStr() : String
      {
         return App.utils.locale.integer(this.battlesCount - this.winsCount - this.lossesCount);
      }
      
      public function getLossesCountStr() : String
      {
         return App.utils.locale.integer(this.lossesCount);
      }
      
      public function getWinsCountStr() : String
      {
         return App.utils.locale.integer(this.winsCount);
      }
      
      public function getWinsEfficiencyStr() : String
      {
         var _loc1_:Number = this.winsCount / this.battlesCount;
         _loc1_ = !isNaN(_loc1_) ? Number(_loc1_) : Number(0);
         _loc1_ *= 100;
         return App.utils.locale.numberWithoutZeros(_loc1_);
      }
   }
}
