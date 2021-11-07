package net.wg.mock.utils
{
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.utils.IIME;
   
   public class MockIME implements IIME
   {
       
      
      public function MockIME()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getContainer() : ISimpleManagedContainer
      {
         return null;
      }
      
      public function init(param1:Boolean) : void
      {
      }
      
      public function onLangBarResize(param1:Number, param2:Number) : void
      {
      }
      
      public function setVisible(param1:Boolean) : void
      {
      }
   }
}
