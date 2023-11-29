package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _baf0df4fb379e94ce09eb10cffbeff4d33c52905061b735966da0c4e3ef8b0bd_flash_display_Sprite extends Sprite
   {
       
      
      public function _baf0df4fb379e94ce09eb10cffbeff4d33c52905061b735966da0c4e3ef8b0bd_flash_display_Sprite()
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
