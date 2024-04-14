package net.wg.gui.lobby.premiumMissions.data
{
   import net.wg.gui.lobby.battleMatters.data.MissionPremiumCardVO;
   import net.wg.gui.lobby.missions.data.MissionPackMarathonBodyVO;
   
   public class MissionPremiumBodyVO extends MissionPackMarathonBodyVO
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var completeTitle:String = "";
      
      public var buttonDetails:String = "";
      
      public var uiDecoration:String = "";
      
      public var icon:String = "";
      
      public var hasPremium:Boolean = false;
      
      public function MissionPremiumBodyVO(param1:Object, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function get missionCardClass() : Class
      {
         return MissionPremiumCardVO;
      }
   }
}
