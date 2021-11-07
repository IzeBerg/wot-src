package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PlayerDataVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:int = -1;
      
      public var playerName:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleLevel:String = "";
      
      public var nationIcon:String = "";
      
      public var teamIndex:int = -1;
      
      public var fragsCount:String = "";
      
      public var isObserved:Boolean = false;
      
      public var isAlive:Boolean = true;
      
      public function PlayerDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
