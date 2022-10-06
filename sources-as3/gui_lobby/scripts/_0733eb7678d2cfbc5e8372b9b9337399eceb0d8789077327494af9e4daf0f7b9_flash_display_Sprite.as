package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0733eb7678d2cfbc5e8372b9b9337399eceb0d8789077327494af9e4daf0f7b9_flash_display_Sprite extends Sprite
   {
       
      
      public function _0733eb7678d2cfbc5e8372b9b9337399eceb0d8789077327494af9e4daf0f7b9_flash_display_Sprite()
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
