package net.wg.gui.lobby.rankedBattles19.constants
{
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   
   public class RankedHelper
   {
       
      
      public function RankedHelper()
      {
         super();
      }
      
      public static function getDivisionStatus(param1:Boolean, param2:Boolean) : String
      {
         if(param2)
         {
            return RANKEDBATTLES_CONSTS.STATUS_ID_DONE;
         }
         if(param1)
         {
            return RANKEDBATTLES_CONSTS.STATUS_ID_CURRENT;
         }
         return RANKEDBATTLES_CONSTS.STATUS_ID_LOCK;
      }
   }
}
