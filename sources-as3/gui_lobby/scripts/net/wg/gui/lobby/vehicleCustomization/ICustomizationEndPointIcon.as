package net.wg.gui.lobby.vehicleCustomization
{
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   
   public interface ICustomizationEndPointIcon
   {
       
      
      function installItem(param1:CustomizationCarouselRendererVO) : void;
      
      function setSlotData(param1:CustomizationSlotUpdateVO) : void;
      
      function applyState(param1:int, param2:Boolean = true) : void;
      
      function onDragTargetChange(param1:Boolean) : void;
      
      function onDragEnd() : void;
      
      function onDragStart() : void;
      
      function getSupportedType() : int;
      
      function get id() : CustomizationSlotIdVO;
      
      function set selected(param1:Boolean) : void;
      
      function set enabled(param1:Boolean) : void;
   }
}
