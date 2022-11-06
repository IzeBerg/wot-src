package net.wg.gui.interfaces
{
   public interface ISettingsBase
   {
       
      
      function updateDependentData() : void;
      
      function needDataWithChanges() : Boolean;
      
      function get viewId() : String;
   }
}
