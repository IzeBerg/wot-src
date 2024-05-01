package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;
   
   public class VehicleSelectorEvent extends Event
   {
      
      public static const SELECTION_CHANGED:String = "selectionChanged";
       
      
      public var selectedDescriptors:Array;
      
      public var selectedObjects:Array;
      
      public var forceSelect:Boolean = false;
      
      public function VehicleSelectorEvent(param1:String, param2:Array, param3:Array, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param4,param5);
         this.selectedDescriptors = param2;
         this.selectedObjects = param3;
         this.forceSelect = param6;
      }
   }
}
