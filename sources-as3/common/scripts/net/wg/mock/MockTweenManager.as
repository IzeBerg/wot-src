package net.wg.mock
{
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   import net.wg.utils.ITweenManager;
   
   public class MockTweenManager implements ITweenManager
   {
       
      
      public function MockTweenManager()
      {
         super();
      }
      
      public function createNewTween(param1:ITweenPropertiesVO) : ITween
      {
         return null;
      }
      
      public function dispose() : void
      {
      }
      
      public function disposeAllS() : void
      {
      }
      
      public function disposeTweenS(param1:ITween) : void
      {
      }
      
      public function getTweenManagerHelper() : ITweenManagerHelper
      {
         return null;
      }
   }
}
