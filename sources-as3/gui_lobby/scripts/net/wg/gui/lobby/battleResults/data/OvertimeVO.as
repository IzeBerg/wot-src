package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class OvertimeVO extends DAAPIDataClass
   {
       
      
      public var enabled:Boolean = false;
      
      public var mainTitle:String = "";
      
      public var overtimeTitle:String = "";
      
      public var overtimeFinishReason:String = "";
      
      public function OvertimeVO(param1:Object)
      {
         super(param1);
      }
   }
}
