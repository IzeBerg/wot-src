package net.wg.gui.lobby.linkedSet.data
{
   import net.wg.gui.lobby.missions.data.MissionPackMarathonBodyVO;
   
   public class MissionLinkedSetBodyVO extends MissionPackMarathonBodyVO
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var buttonUseTokenLabel:String = "";
      
      public var isButtonUseTokenEnabled:Boolean = true;
      
      public var uiDecoration:String = "";
      
      public var eventID:String = "";
      
      public function MissionLinkedSetBodyVO(param1:Object, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function get missionCardClass() : Class
      {
         return MissionLinkedSetCardVO;
      }
   }
}
