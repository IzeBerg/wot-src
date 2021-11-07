package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DeviceSlotVO extends DAAPIDataClass
   {
       
      
      public var slotType:String = "";
      
      public var slotIndex:int = -1;
      
      public var tooltip:String = "";
      
      public var tooltipType:String = "";
      
      public var id:Number = NaN;
      
      public var level:int = -1;
      
      public var removable:Boolean = false;
      
      public var showRemoveBtn:Boolean = false;
      
      public var name:String = "";
      
      public var moduleLabel:String = "";
      
      public var extraModuleInfo:String = "";
      
      public var affectsAtTTC:Boolean = true;
      
      public var countValue:int = -1;
      
      public var highlight:Boolean = false;
      
      public var bgHighlightType:String = "";
      
      public var overlayType:String = "";
      
      public var isDisabledBgVisible:Boolean = true;
      
      public var counter:int = -1;
      
      public var slotLocked:Boolean = false;
      
      public function DeviceSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
