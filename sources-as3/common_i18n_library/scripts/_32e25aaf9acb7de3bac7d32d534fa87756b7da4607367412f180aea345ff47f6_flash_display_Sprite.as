package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _32e25aaf9acb7de3bac7d32d534fa87756b7da4607367412f180aea345ff47f6_flash_display_Sprite extends Sprite
   {
       
      
      public function _32e25aaf9acb7de3bac7d32d534fa87756b7da4607367412f180aea345ff47f6_flash_display_Sprite()
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
