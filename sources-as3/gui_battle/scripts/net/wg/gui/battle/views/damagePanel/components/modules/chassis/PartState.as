package net.wg.gui.battle.views.damagePanel.components.modules.chassis
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   
   public class PartState
   {
       
      
      public var state:String = "normal";
      
      public var repairTime:int = 0;
      
      public var repairPercent:int = 0;
      
      public var prevState:String = "normal";
      
      public function PartState()
      {
         super();
      }
      
      public function updateState(param1:String) : void
      {
         this.prevState = this.state;
         this.state = param1;
         if(this.state == BATTLE_ITEM_STATES.NORMAL || this.state == BATTLE_ITEM_STATES.REPAIRED || this.state == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            this.repairTime = Values.ZERO;
            this.repairPercent = Values.ZERO;
         }
      }
      
      public function updateRepairTime(param1:int, param2:int) : void
      {
         this.repairTime = param1;
         this.repairPercent = param2;
      }
      
      public function reset() : void
      {
         this.state = BATTLE_ITEM_STATES.NORMAL;
         this.prevState = BATTLE_ITEM_STATES.NORMAL;
         this.repairTime = Values.ZERO;
         this.repairPercent = Values.ZERO;
      }
   }
}
