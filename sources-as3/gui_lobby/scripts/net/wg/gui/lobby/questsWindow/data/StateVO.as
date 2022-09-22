package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StateVO extends DAAPIDataClass
   {
       
      
      public var statusState:String = "";
      
      public var statusText:String = "";
      
      public function StateVO(param1:Object)
      {
         super(param1);
      }
   }
}
