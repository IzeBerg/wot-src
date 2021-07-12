package net.wg.gui.lobby.vehicleCompare.interfaces
{
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   
   public interface IVehParamRenderer extends IScrollerItemRenderer
   {
       
      
      function updateHeight(param1:int) : void;
      
      function updateBottomLineState(param1:int, param2:Number) : void;
   }
}
