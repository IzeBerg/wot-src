package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _19daccacdb84aef59c21132fa4b9332a148471cf17d322031100a66400193e6b_flash_display_Sprite extends Sprite
   {
       
      
      public function _19daccacdb84aef59c21132fa4b9332a148471cf17d322031100a66400193e6b_flash_display_Sprite()
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
