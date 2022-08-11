package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ab18e334e1056fec5aeff40ddfb61acb7fc4ebbbd5a0e25239015998cbc16fa4_flash_display_Sprite extends Sprite
   {
       
      
      public function _ab18e334e1056fec5aeff40ddfb61acb7fc4ebbbd5a0e25239015998cbc16fa4_flash_display_Sprite()
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
