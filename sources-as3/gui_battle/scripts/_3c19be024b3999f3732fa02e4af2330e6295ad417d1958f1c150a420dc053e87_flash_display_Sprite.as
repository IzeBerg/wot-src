package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3c19be024b3999f3732fa02e4af2330e6295ad417d1958f1c150a420dc053e87_flash_display_Sprite extends Sprite
   {
       
      
      public function _3c19be024b3999f3732fa02e4af2330e6295ad417d1958f1c150a420dc053e87_flash_display_Sprite()
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
