package net.wg.gui.lobby.storage.categories.cards
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BlueprintCardCostVO extends DAAPIDataClass
   {
       
      
      public var costStr:String = "";
      
      public var hasDelimeter:Boolean = false;
      
      public var delimeterOffset:int;
      
      public function BlueprintCardCostVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
