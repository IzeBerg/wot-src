package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _02bb5c6a15a1195fd63f1ecc75f578306f0c092c4af260d9cce62287fe328ab2_flash_display_Sprite extends Sprite
   {
       
      
      public function _02bb5c6a15a1195fd63f1ecc75f578306f0c092c4af260d9cce62287fe328ab2_flash_display_Sprite()
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
