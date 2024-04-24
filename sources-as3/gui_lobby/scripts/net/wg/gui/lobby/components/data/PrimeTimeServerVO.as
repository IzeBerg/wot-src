package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.common.serverStats.ServerVO;
   
   public class PrimeTimeServerVO extends ServerVO
   {
       
      
      public var shortname:String = "";
      
      public var schedules:String = "";
      
      public var maxPrimeTimes:int = -1;
      
      public function PrimeTimeServerVO(param1:Object)
      {
         super(param1);
      }
   }
}
