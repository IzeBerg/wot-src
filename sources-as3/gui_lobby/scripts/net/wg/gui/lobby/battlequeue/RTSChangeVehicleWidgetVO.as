package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RTSChangeVehicleWidgetVO extends DAAPIDataClass
   {
       
      
      public var vehicleName:String = "";
      
      public var changeTitle:String = "";
      
      public var btnLabel:String = "";
      
      public var calculatedText:String = "";
      
      public var waitingTime:String = "";
      
      public var changeDescr:String = "";
      
      public var bonusLabel:String = "";
      
      public function RTSChangeVehicleWidgetVO(param1:Object)
      {
         super(param1);
      }
   }
}
