package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3438106d273c0644a64e8fb2cc4633bcae455ac956534bd7bdf5dea88a50d2ca_flash_display_Sprite extends Sprite
   {
       
      
      public function _3438106d273c0644a64e8fb2cc4633bcae455ac956534bd7bdf5dea88a50d2ca_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
