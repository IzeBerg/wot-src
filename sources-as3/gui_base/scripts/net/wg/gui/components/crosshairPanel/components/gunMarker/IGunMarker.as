package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import net.wg.infrastructure.interfaces.IMovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IGunMarker extends IDisposable, IDisplayable, IMovieClip
   {
       
      
      function setReloadingParams(param1:Number, param2:String) : void;
      
      function setSettings(param1:Number, param2:Number, param3:Number, param4:Number) : void;
      
      function setColor(param1:String) : void;
      
      function setScale(param1:Number) : void;
      
      function setMixingScale(param1:Number) : void;
      
      function setIsSecondary(param1:Boolean) : void;
      
      function setDualAccActive(param1:Boolean) : void;
      
      function setExplosiveMarker(param1:Boolean) : void;
   }
}
