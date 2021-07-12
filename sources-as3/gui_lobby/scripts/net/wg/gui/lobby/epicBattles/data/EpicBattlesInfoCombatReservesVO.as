package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicBattlesInfoCombatReservesVO extends DAAPIDataClass
   {
       
      
      public var titleHtmlText:String = "";
      
      public var descriptionHtmlText:String = "";
      
      public var progressHtmlText:String = "";
      
      public var buttonText:String = "";
      
      public var unspentPoints:int = -1;
      
      public var unspentHtmlPointsText:String = "";
      
      public function EpicBattlesInfoCombatReservesVO(param1:Object)
      {
         super(param1);
      }
   }
}
