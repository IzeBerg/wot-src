package net.wg.utils
{
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IVOManager extends IDisposable
   {
       
      
      function get walletStatusVO() : IWalletStatusVO;
   }
}
