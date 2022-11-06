package net.wg.gui.battle.views.minimap.components.entries.interfaces
{
   public interface IHighlightableMinimapEntry
   {
       
      
      function highlight() : void;
      
      function unhighlight() : void;
      
      function get vehicleID() : Number;
   }
}
