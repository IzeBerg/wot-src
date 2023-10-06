package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import net.wg.infrastructure.interfaces.entity.IDisplayable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IGunMarkerMixing extends IDisposable, IDisplayable
   {
       
      
      function setReloadingState(param1:String) : void;
      
      function setReloadingAsPercent(param1:Number, param2:Boolean = false) : void;
      
      function setAlpha(param1:Number) : void;
      
      function setThickness(param1:String) : void;
   }
}
