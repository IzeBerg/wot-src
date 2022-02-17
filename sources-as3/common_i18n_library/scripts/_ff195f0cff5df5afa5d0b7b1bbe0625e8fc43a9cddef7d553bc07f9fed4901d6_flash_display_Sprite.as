package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ff195f0cff5df5afa5d0b7b1bbe0625e8fc43a9cddef7d553bc07f9fed4901d6_flash_display_Sprite extends Sprite
   {
       
      
      public function _ff195f0cff5df5afa5d0b7b1bbe0625e8fc43a9cddef7d553bc07f9fed4901d6_flash_display_Sprite()
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
