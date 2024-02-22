package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionDetailsPopUpPanelVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var description:String = "";
      
      public var rendererLinkage:String = "";
      
      public function MissionDetailsPopUpPanelVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
