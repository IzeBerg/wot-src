package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SwitchModePanelVO extends DAAPIDataClass
   {
       
      
      public var iconSource:String = "";
      
      public var buttonLabel:String = "";
      
      public var label:String = "";
      
      public var autoSquadEnabled:Boolean = false;
      
      public var autoSquadLabel:String = "";
      
      public var autoSquadInfoTooltip:String = "";
      
      public var autoSquadIsVisible:Boolean = false;
      
      public function SwitchModePanelVO(param1:Object)
      {
         super(param1);
      }
   }
}
