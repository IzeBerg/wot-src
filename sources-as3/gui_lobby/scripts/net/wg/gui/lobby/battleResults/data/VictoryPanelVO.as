package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VictoryPanelVO extends DAAPIDataClass
   {
       
      
      public var score:int;
      
      public var victory:Boolean;
      
      public var tooltip:String = "";
      
      public var specialStatusStr:String = "";
      
      public function VictoryPanelVO(param1:Object)
      {
         super(param1);
      }
   }
}
