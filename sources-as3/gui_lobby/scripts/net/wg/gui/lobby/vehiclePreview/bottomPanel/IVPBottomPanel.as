package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.IMovieClip;
   
   public interface IVPBottomPanel extends IMovieClip
   {
       
      
      function getBtn() : SoundButtonEx;
      
      function getTotalHeight() : Number;
   }
}
