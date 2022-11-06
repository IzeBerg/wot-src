package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HistoricIndicatorVO extends DAAPIDataClass
   {
       
      
      public var historicText:String = "";
      
      public var isDefaultAppearance:Boolean = true;
      
      public var isHistoric:Boolean = false;
      
      public var tooltip:String = "";
      
      public function HistoricIndicatorVO(param1:Object)
      {
         super(param1);
      }
   }
}
