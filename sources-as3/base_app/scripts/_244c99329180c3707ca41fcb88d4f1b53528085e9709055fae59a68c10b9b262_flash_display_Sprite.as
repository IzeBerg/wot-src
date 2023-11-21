package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _244c99329180c3707ca41fcb88d4f1b53528085e9709055fae59a68c10b9b262_flash_display_Sprite extends Sprite
   {
       
      
      public function _244c99329180c3707ca41fcb88d4f1b53528085e9709055fae59a68c10b9b262_flash_display_Sprite()
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
