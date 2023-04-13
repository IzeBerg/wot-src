package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _20a04215b839217df198a3b6f53ae4b5db6d6d4c39715664d291f23161a84d3f_flash_display_Sprite extends Sprite
   {
       
      
      public function _20a04215b839217df198a3b6f53ae4b5db6d6d4c39715664d291f23161a84d3f_flash_display_Sprite()
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
