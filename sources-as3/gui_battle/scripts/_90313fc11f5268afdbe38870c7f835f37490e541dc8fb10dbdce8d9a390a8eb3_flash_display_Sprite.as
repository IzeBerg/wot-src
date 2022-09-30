package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _90313fc11f5268afdbe38870c7f835f37490e541dc8fb10dbdce8d9a390a8eb3_flash_display_Sprite extends Sprite
   {
       
      
      public function _90313fc11f5268afdbe38870c7f835f37490e541dc8fb10dbdce8d9a390a8eb3_flash_display_Sprite()
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
