package net.wg.gui.components.assets.interfaces
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IMovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface INewIndicator extends IDisposable, IMovieClip
   {
       
      
      function hide() : void;
      
      function pause() : void;
      
      function shine() : void;
      
      function get hitMC() : Sprite;
   }
}
