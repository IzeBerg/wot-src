package net.wg.gui.rally.interfaces
{
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   
   public interface ITeamSectionWithDropIndicators extends IBaseTeamSection
   {
       
      
      function updateIndicators(param1:uint) : void;
      
      function getIndicatorsUI() : Vector.<ISlotDropIndicator>;
      
      function highlightList() : void;
      
      function hideHighLight() : void;
   }
}
