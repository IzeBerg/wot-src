package net.wg.utils
{
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   
   public interface ITweenManager
   {
       
      
      function createNewTween(param1:ITweenPropertiesVO) : ITween;
      
      function disposeTweenS(param1:ITween) : void;
      
      function disposeAllS() : void;
      
      function getTweenManagerHelper() : ITweenManagerHelper;
   }
}
