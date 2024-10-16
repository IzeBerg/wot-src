package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IGunMarkerMixing extends IDisposable, IDisplayObject
   {
       
      
      function setReloadingState(param1:String) : void;
      
      function setReloadingAsPercent(param1:Number, param2:Boolean = false) : void;
      
      function setThickness(param1:String) : void;
   }
}
