package net.wg.infrastructure.uilogger.new_year
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class LogTankSlot extends UILogger
   {
       
      
      public function LogTankSlot()
      {
         super(Constants.FEATURE,Constants.GROUP_TANK_SLOT);
      }
      
      public function slotClick() : void
      {
         logOnce(Constants.ACTION_CLICK,LogLevels.INFO,{"parent_screen":"hangar"});
      }
   }
}
