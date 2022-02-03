package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.data.VO.WalletStatusVO;
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   import net.wg.utils.IVOManager;
   
   public class VOManager implements IVOManager
   {
       
      
      private var _walletStatusVO:IWalletStatusVO;
      
      private var _disposed:Boolean = false;
      
      public function VOManager()
      {
         super();
         this._walletStatusVO = new WalletStatusVO();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._walletStatusVO.dispose();
         this._walletStatusVO = null;
      }
      
      public function get walletStatusVO() : IWalletStatusVO
      {
         return this._walletStatusVO;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
