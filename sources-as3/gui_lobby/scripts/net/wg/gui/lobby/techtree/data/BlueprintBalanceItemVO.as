package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BlueprintBalanceItemVO extends DAAPIDataClass
   {
       
      
      public var iconPath:String = "";
      
      public var title:String = "";
      
      public var fragmentCD:int = -1;
      
      public function BlueprintBalanceItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
