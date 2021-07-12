package net.wg.gui.components.controls.slotsPanel
{
   import net.wg.infrastructure.base.meta.ISlotsPanelMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public interface ISlotsPanel extends ISlotsPanelMeta, IUIComponentEx, IDAAPIModule, IFocusContainer
   {
       
      
      function isShowCheckBox(param1:int) : Boolean;
      
      function isInited() : Boolean;
      
      function redrawSlots(param1:int, param2:Boolean = false) : void;
   }
}
