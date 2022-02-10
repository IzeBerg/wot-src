package net.wg.utils
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
   import net.wg.infrastructure.interfaces.ITweenHandler;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITweenAnimator extends ITweenHandler, IDisposable
   {
       
      
      function blinkInfinity(param1:DisplayObject) : void;
      
      function addFadeInAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void;
      
      function addFadeInAnimEx(param1:DisplayObject) : ITween;
      
      function addFadeOutAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void;
      
      function addFadeOutAnimEx(param1:DisplayObject) : ITween;
      
      function addMoveUpAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void;
      
      function addMoveUpAnimEx(param1:DisplayObject, param2:Number) : ITween;
      
      function addMoveDownAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void;
      
      function addMoveDownAnimEx(param1:DisplayObject, param2:Number) : ITween;
      
      function removeAnims(param1:DisplayObject) : void;
      
      function createPropsForAlpha(param1:DisplayObject, param2:uint, param3:Number, param4:uint = 0) : ITweenPropertiesVO;
      
      function addHalfTurnAnim(param1:DisplayObject) : void;
      
      function addHalfTurnAnimEx(param1:DisplayObject) : ITween;
   }
}
