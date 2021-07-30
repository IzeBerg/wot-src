package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _96e87bfe998efe98802a965a77cbd9d40c9d635c731f332753d97fff429733f9_flash_display_Sprite extends Sprite
   {
       
      
      public function _96e87bfe998efe98802a965a77cbd9d40c9d635c731f332753d97fff429733f9_flash_display_Sprite()
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
