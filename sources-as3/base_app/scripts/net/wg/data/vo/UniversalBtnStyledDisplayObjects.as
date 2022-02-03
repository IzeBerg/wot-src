package net.wg.data.vo
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;
   import net.wg.utils.IUniversalBtnStyledDisplayObjects;
   
   public class UniversalBtnStyledDisplayObjects implements IUniversalBtnStyledDisplayObjects
   {
       
      
      private var _states:MovieClip = null;
      
      private var _toggleGlow:Sprite = null;
      
      private var _toggleIndicator:IUniversalBtnToggleIndicator = null;
      
      private var _disposed:Boolean = false;
      
      public function UniversalBtnStyledDisplayObjects(param1:MovieClip, param2:Sprite, param3:IUniversalBtnToggleIndicator)
      {
         super();
         this._states = param1;
         this._toggleGlow = param2;
         this._toggleIndicator = param3;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._states = null;
         this._toggleGlow = null;
         this._toggleIndicator.dispose();
         this._toggleIndicator = null;
      }
      
      public function get states() : MovieClip
      {
         return this._states;
      }
      
      public function get toggleGlow() : Sprite
      {
         return this._toggleGlow;
      }
      
      public function get toggleIndicator() : IUniversalBtnToggleIndicator
      {
         return this._toggleIndicator;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
