package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _91f220f0d429241fc20d463edc68e37d0076de474bef87b7fd1f2140bd3f9db4_flash_display_Sprite extends Sprite
   {
       
      
      public function _91f220f0d429241fc20d463edc68e37d0076de474bef87b7fd1f2140bd3f9db4_flash_display_Sprite()
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
