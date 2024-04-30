package net.wg.gui.battle.historicalBattles.playersPanel.VO
{
   import flash.events.Event;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   
   public class HBPlayerInfoVO extends DAAPIVehicleInfoVO
   {
      
      public static const STATE_NONE:String = "none";
       
      
      public var countLives:uint = 0;
      
      public var igrType:int = 0;
      
      public var hpMax:int = 0;
      
      public var hpCurrent:int = 0;
      
      public var playerRole:String = "none";
      
      public var secondsToRespawn:int = 0;
      
      public function HBPlayerInfoVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function update(param1:DAAPIVehicleInfoVO) : void
      {
         super.update(param1);
         if(hasEventListener(Event.CHANGE))
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
   }
}
