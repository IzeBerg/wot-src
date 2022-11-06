package net.wg.gui.battle.views.battleMessenger.VO
{
   import net.wg.data.constants.Values;
   
   public class BattleMessengerToxicVO
   {
       
      
      public var messageID:String = "";
      
      public var vehicleID:Number = -1;
      
      public var blackList:ButtonToxicStatusVO = null;
      
      public function BattleMessengerToxicVO()
      {
         super();
         this.blackList = new ButtonToxicStatusVO();
      }
      
      public function parseData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.messageID = param1.messageID;
         this.vehicleID = param1.vehicleID;
         this.blackList.parseData(param1.blackList);
      }
      
      public function reset() : void
      {
         this.messageID = Values.EMPTY_STR;
         this.vehicleID = -1;
         this.blackList.reset();
      }
   }
}
