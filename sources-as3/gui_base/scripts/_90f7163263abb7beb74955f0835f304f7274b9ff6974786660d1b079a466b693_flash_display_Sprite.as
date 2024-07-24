package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _90f7163263abb7beb74955f0835f304f7274b9ff6974786660d1b079a466b693_flash_display_Sprite extends Sprite
   {
       
      
      public function _90f7163263abb7beb74955f0835f304f7274b9ff6974786660d1b079a466b693_flash_display_Sprite()
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
