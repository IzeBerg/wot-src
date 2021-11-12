package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3a02464cc4e06c21e0cd961d388f77ade9d06d2cb38c78e530acc57d6569debb_flash_display_Sprite extends Sprite
   {
       
      
      public function _3a02464cc4e06c21e0cd961d388f77ade9d06d2cb38c78e530acc57d6569debb_flash_display_Sprite()
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
