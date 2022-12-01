package net.wg.infrastructure.uilogger.new_year
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class LogTankBonus extends UILogger
   {
       
      
      public function LogTankBonus()
      {
         super(Constants.FEATURE,Constants.GROUP_TANK_BONUS);
      }
      
      public function bonusClick() : void
      {
         logOnce(Constants.ACTION_CLICK,LogLevels.INFO,{"parent_screen":"hangar"});
      }
   }
}
