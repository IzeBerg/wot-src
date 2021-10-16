package net.wg.utils
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IUniversalBtnStyledDisplayObjects extends IDisposable
   {
       
      
      function get states() : MovieClip;
      
      function get toggleGlow() : Sprite;
      
      function get toggleIndicator() : IUniversalBtnToggleIndicator;
   }
}
