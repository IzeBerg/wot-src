package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _169ddd5ba0cbbe0b5472e25b5541b365922cab14ffab10ace68d9a8d2cc23fb9_flash_display_Sprite extends Sprite
   {
       
      
      public function _169ddd5ba0cbbe0b5472e25b5541b365922cab14ffab10ace68d9a8d2cc23fb9_flash_display_Sprite()
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
