package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.VO.UserVO;
   
   public class ClanProfileProvinceVO extends UserVO
   {
       
      
      public var front:String = "";
      
      public var province:String = "";
      
      public var map:String = "";
      
      public var primeTime:String = "";
      
      public var days:String = "";
      
      public var daysValue:int = -1;
      
      public var isRobbed:Boolean = false;
      
      public var robbedTooltip:String = "";
      
      public function ClanProfileProvinceVO(param1:Object)
      {
         super(param1);
      }
   }
}
