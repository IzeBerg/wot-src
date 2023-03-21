package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ba322ffbbc99b10a527826acbb9b2a6b6fe58d8eef2dc92554929be91ade8f4c_flash_display_Sprite extends Sprite
   {
       
      
      public function _ba322ffbbc99b10a527826acbb9b2a6b6fe58d8eef2dc92554929be91ade8f4c_flash_display_Sprite()
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
