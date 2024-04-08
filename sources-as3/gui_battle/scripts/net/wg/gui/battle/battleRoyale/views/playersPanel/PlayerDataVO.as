package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PlayerDataVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:int = -1;
      
      public var playerName:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleLevel:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var teamIndex:int = -1;
      
      public var fragsCount:String = "";
      
      public var isObserved:Boolean = false;
      
      public var isAlive:Boolean = true;
      
      public var hasRespawn:Boolean = false;
      
      public function PlayerDataVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:PlayerDataVO = param1 as PlayerDataVO;
         if(!_loc2_)
         {
            return false;
         }
         return this.vehicleID == _loc2_.vehicleID && this.playerName == _loc2_.playerName && this.vehicleName == _loc2_.vehicleName && this.vehicleLevel == _loc2_.vehicleLevel && this.vehicleTypeIcon == _loc2_.vehicleTypeIcon && this.teamIndex == _loc2_.teamIndex && this.fragsCount == _loc2_.fragsCount && this.isObserved == _loc2_.isObserved && this.isAlive == _loc2_.isAlive && this.hasRespawn == _loc2_.hasRespawn;
      }
   }
}
