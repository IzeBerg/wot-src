package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5260d9dd3dfb97378f5326eade48c1fbfa110ca5c45da94d1aefc1e7ab342785_flash_display_Sprite extends Sprite
   {
       
      
      public function _5260d9dd3dfb97378f5326eade48c1fbfa110ca5c45da94d1aefc1e7ab342785_flash_display_Sprite()
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
