package net.wg.gui.battle.views.damagePanel.components.modules.chassis
{
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   
   public class YohChassisState extends MultitrackChassisState
   {
       
      
      public function YohChassisState()
      {
         super();
      }
      
      override public function getChassisState() : String
      {
         if(leftTrack0.state == BATTLE_ITEM_STATES.DESTROYED || rightTrack0.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return saveState(BATTLE_ITEM_STATES.DESTROYED);
         }
         if(leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED || rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED && leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED || rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED && rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
         {
            return saveState(BATTLE_ITEM_STATES.REPAIRED);
         }
         if(leftTrack1.state == BATTLE_ITEM_STATES.REPAIRED && leftTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED || rightTrack1.state == BATTLE_ITEM_STATES.REPAIRED && rightTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED)
         {
            return saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(leftTrack1.state == BATTLE_ITEM_STATES.CRITICAL || rightTrack1.state == BATTLE_ITEM_STATES.CRITICAL || leftTrack0.state == BATTLE_ITEM_STATES.CRITICAL || rightTrack0.state == BATTLE_ITEM_STATES.CRITICAL)
         {
            return saveState(BATTLE_ITEM_STATES.CRITICAL);
         }
         if(leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL || rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            return saveState(BATTLE_ITEM_STATES.REPAIRED_FULL);
         }
         return saveState(BATTLE_ITEM_STATES.NORMAL);
      }
      
      override public function getRepairTimePart() : PartState
      {
         if(leftTrack0.repairTime > rightTrack0.repairTime)
         {
            if(leftTrack0.repairTime > 0)
            {
               return leftTrack0;
            }
         }
         else if(rightTrack0.repairTime > 0)
         {
            return rightTrack0;
         }
         if(leftTrack1.repairTime > rightTrack1.repairTime)
         {
            if(leftTrack1.repairTime > 0)
            {
               return leftTrack1;
            }
         }
         else if(rightTrack1.repairTime > 0)
         {
            return rightTrack1;
         }
         return null;
      }
   }
}
