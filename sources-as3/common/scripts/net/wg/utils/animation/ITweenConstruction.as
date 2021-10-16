package net.wg.utils.animation
{
   import net.wg.infrastructure.interfaces.ISimpleTweenPropertiesVO;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenHandler;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITweenConstruction extends ITweenHandler, IDisposable
   {
       
      
      function removeTween(param1:int) : void;
      
      function countTweens() : int;
      
      function getTweenByIdx(param1:int) : ISimpleTweenPropertiesVO;
      
      function getAllTweens() : Vector.<ISimpleTweenPropertiesVO>;
      
      function start() : void;
      
      function addFadeIn(param1:int, param2:String = null) : ITweenConstruction;
      
      function addFadeOut(param1:int, param2:String = null) : ITweenConstruction;
      
      function addMoveUp(param1:int, param2:String = null) : ITweenConstruction;
      
      function addMoveDown(param1:int, param2:String = null) : ITweenConstruction;
      
      function addHalfTurn(param1:int, param2:String = null) : ITweenConstruction;
      
      function addTween(param1:ITween, param2:int, param3:String = null) : ITweenConstruction;
   }
}
