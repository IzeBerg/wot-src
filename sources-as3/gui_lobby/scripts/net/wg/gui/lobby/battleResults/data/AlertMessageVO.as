package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AlertMessageVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var text:String = "";
      
      public function AlertMessageVO(param1:Object)
      {
         super(param1);
      }
   }
}
