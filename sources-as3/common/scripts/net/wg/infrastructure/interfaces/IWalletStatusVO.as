package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IWalletStatusVO extends IDisposable, IGlobalVO
   {
       
      
      function get goldStatus() : uint;
      
      function get freeXpStatus() : uint;
      
      function get creditsStatus() : uint;
      
      function get crystalStatus() : uint;
   }
}
