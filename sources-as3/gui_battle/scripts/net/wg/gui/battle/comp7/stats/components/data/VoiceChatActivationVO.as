package net.wg.gui.battle.comp7.stats.components.data
{
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   
   public class VoiceChatActivationVO extends DAAPIVehiclesDataVO
   {
       
      
      public var activeText:String = "";
      
      public var inactiveText:String = "";
      
      public function VoiceChatActivationVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
