package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a3c770143b619d54ff9d5e117eebdcf1bbf2c312d6f32559afdba3611a82cc21_flash_display_Sprite extends Sprite
   {
       
      
      public function _a3c770143b619d54ff9d5e117eebdcf1bbf2c312d6f32559afdba3611a82cc21_flash_display_Sprite()
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
