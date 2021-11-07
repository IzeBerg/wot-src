package net.wg.gui.components.questProgress.interfaces
{
   import net.wg.gui.components.questProgress.interfaces.components.IQPComponent;
   
   public interface ITypedViewItem extends IQPComponent
   {
       
      
      function get viewType() : String;
      
      function set viewType(param1:String) : void;
   }
}
