package net.wg.gui.lobby.missions.data
{
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   
   public class MissionTabVO extends TabsDataVo
   {
       
      
      public var alias:String = "";
      
      public var selected:Boolean = false;
      
      public var tooltip:String = "";
      
      public var enabled:Boolean = true;
      
      public var prefix:String = "";
      
      public function MissionTabVO(param1:Object)
      {
         super(param1);
      }
   }
}
