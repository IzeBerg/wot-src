package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehCompareVehParamRendererEvent extends Event
   {
      
      public static const PARAM_MOUSE_OVER:String = "paramMouseOver";
      
      public static const PARAM_MOUSE_OUT:String = "paramMouseOut";
      
      public static const PARAM_CLICK:String = "paramClick";
       
      
      public var paramID:String;
      
      public var index:int = -1;
      
      public var stageY:Number;
      
      public function VehCompareVehParamRendererEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
