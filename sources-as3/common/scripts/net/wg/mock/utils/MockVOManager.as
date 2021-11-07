package net.wg.mock.utils
{
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   import net.wg.utils.IVOManager;
   
   public class MockVOManager implements IVOManager
   {
       
      
      public function MockVOManager()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get walletStatusVO() : IWalletStatusVO
      {
         return null;
      }
   }
}
