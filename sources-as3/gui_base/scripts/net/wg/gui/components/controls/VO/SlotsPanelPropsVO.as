package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SlotsPanelPropsVO extends DAAPIDataClass
   {
       
      
      public var slotsCount:int = -1;
      
      public var groupCount:int = -1;
      
      public var slotWidth:int = -1;
      
      public var paddings:int = -1;
      
      public var groupPadding:int = -1;
      
      public var ySlotPosition:int = -1;
      
      public var offsetSlot:int = -1;
      
      public var popoverAlias:String = "";
      
      public var panelAlias:String = "";
      
      public var useOnlyLeftBtn:Boolean = false;
      
      public function SlotsPanelPropsVO(param1:Object)
      {
         super(param1);
      }
   }
}
