package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class UseAwardSheetWindowVO extends DAAPIDataClass
   {
       
      
      public var neededLabel:String = "";
      
      public var neededValue:String = "";
      
      public var totalLabel:String = "";
      
      public var totalValue:String = "";
      
      public var statusText:String = "";
      
      public var icon:String = "";
      
      public function UseAwardSheetWindowVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
