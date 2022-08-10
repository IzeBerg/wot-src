package net.wg.gui.interfaces
{
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public interface ISaleItemBlockRenderer extends IListItemRenderer
   {
       
      
      function hideLine() : void;
      
      function setSize(param1:Number, param2:Number) : void;
   }
}
